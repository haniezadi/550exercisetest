import { useEffect, useRef, useState } from 'react';
import { Dumbbell, Apple, Lightbulb } from 'lucide-react';
import type {
  Student,
  AssignedProgram,
  Template,
  StudentPlan,
  ProgramExercise,
  DietProgramMeal,
  DietProgramFoodItem,
  DietProgramTip,
  DietTip,
  DietTipCategory,
} from '@/lib/supabase';
import { DIET_TIP_CATEGORY_LABELS } from '@/lib/supabase';
import { formatJalaliLong, formatJalaliShort, toPersianDigits } from '@/lib/jalali';
import { todayInTehran } from '@/lib/supabase';

export type PrintMode = 'full' | 'diet' | 'tips';

interface PrintLayoutProps {
  mode: PrintMode;
  student: Student;
  program: AssignedProgram | null;
  activePlan: StudentPlan | null;
  programExercises: ProgramExercise[];
  dietMeals: DietProgramMeal[];
  dietFoodItemsByMeal: Map<string, DietProgramFoodItem[]>;
  dietProgramTips: DietProgramTip[];
  dietTips: DietTip[];
  dietTemplate: Template | null;
  onDone: () => void;
}

interface SectionInfo {
  key: string;
  title: string;
}

const A4_USABLE_HEIGHT_PX = 1011;

function sanitizeFilename(name: string): string {
  const cleaned = name.trim().replace(/[\\/:*?"<>|]/g, ' ').replace(/\s+/g, ' ').trim();
  return cleaned || 'برنامه-شاگرد';
}

export default function PrintLayout({
  mode,
  student,
  program,
  activePlan,
  programExercises,
  dietMeals,
  dietFoodItemsByMeal,
  dietProgramTips,
  dietTips,
  dietTemplate,
  onDone,
}: PrintLayoutProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const sectionRefs = useRef<Record<string, HTMLElement | null>>({});
  const [pageNumbers, setPageNumbers] = useState<Record<string, number>>({});
  const [phase, setPhase] = useState<'measure' | 'print'>('measure');

  const tipsForFullPdf = dietProgramTips.filter((pt) => (pt.pdf_mode ?? 'full') !== 'none');
  const tipsForTipsPdf = dietProgramTips.filter((pt) => {
    const m = pt.pdf_mode ?? 'full';
    return m === 'full' || m === 'tips_only';
  });
  const tipsToShow = mode === 'tips' ? tipsForTipsPdf : tipsForFullPdf;

  const hasWorkout = mode === 'full' && programExercises.length > 0;
  const hasDiet = (mode === 'full' || mode === 'diet') && (dietMeals.length > 0 || program?.custom_description);
  const hasTips = tipsToShow.length > 0;

  const sections: SectionInfo[] = [];
  if (hasDiet) sections.push({ key: 'diet', title: 'برنامه غذایی' });
  if (hasWorkout) sections.push({ key: 'workout', title: 'برنامه تمرینی' });
  if (hasTips) sections.push({ key: 'tips', title: 'نکات اجرایی' });

  useEffect(() => {
    if (phase !== 'measure') return;

    const measure = () => {
      const container = containerRef.current;
      if (!container) return;

      container.style.position = 'absolute';
      container.style.left = '-9999px';
      container.style.top = '0';
      container.style.width = '210mm';
      container.style.display = 'block';

      void container.offsetHeight;

      const numbers: Record<string, number> = {};
      const containerTop = container.offsetTop;

      if (sectionRefs.current['cover']) numbers['cover'] = 1;

      const summaryEl = sectionRefs.current['summary'];
      if (summaryEl) {
        numbers['summary'] = Math.floor((summaryEl.offsetTop - containerTop) / A4_USABLE_HEIGHT_PX) + 1;
      }

      const tocEl = sectionRefs.current['toc'];
      if (tocEl) {
        numbers['toc'] = Math.floor((tocEl.offsetTop - containerTop) / A4_USABLE_HEIGHT_PX) + 1;
      }

      for (const s of sections) {
        const el = sectionRefs.current[s.key];
        if (el) {
          numbers[s.key] = Math.floor((el.offsetTop - containerTop) / A4_USABLE_HEIGHT_PX) + 1;
        }
      }

      container.style.position = '';
      container.style.left = '';
      container.style.top = '';
      container.style.width = '';

      setPageNumbers(numbers);
      setPhase('print');
    };

    if (document.fonts && document.fonts.ready) {
      document.fonts.ready.then(() => requestAnimationFrame(measure));
    } else {
      const timer = setTimeout(measure, 300);
      return () => clearTimeout(timer);
    }
  }, [phase, sections]);

  useEffect(() => {
    if (phase !== 'print') return;

    const prefix =
      mode === 'tips'
        ? 'نکات اجرایی'
        : mode === 'diet'
          ? 'برنامه غذایی'
          : 'برنامه و دفترچه اختصاصی';
    const filename = `${prefix} ${sanitizeFilename(student.name)}.pdf`;
    const prevTitle = document.title;
    document.title = filename;

    const handleAfterPrint = () => {
      window.removeEventListener('afterprint', handleAfterPrint);
      document.title = prevTitle;
      onDone();
    };
    window.addEventListener('afterprint', handleAfterPrint);

    const timer = setTimeout(() => {
      window.print();
    }, 100);

    return () => {
      clearTimeout(timer);
      window.removeEventListener('afterprint', handleAfterPrint);
      document.title = prevTitle;
    };
  }, [phase, mode, student.name, onDone]);

  const programTitle =
    mode === 'tips'
      ? 'نکات و توصیه‌های اجرایی'
      : mode === 'diet'
        ? 'برنامه غذایی'
        : hasWorkout && hasDiet
          ? 'برنامه تمرینی و غذایی'
          : hasWorkout
            ? 'برنامه تمرینی'
            : 'برنامه غذایی';

  const todayStr = todayInTehran();

  const workoutDays: { label: string; items: ProgramExercise[] }[] = [];
  {
    const seen = new Set<string>();
    for (const pe of programExercises) {
      const day = pe.day_label || 'روز ۱';
      if (!seen.has(day)) {
        seen.add(day);
        workoutDays.push({ label: day, items: [] });
      }
      workoutDays[workoutDays.length - 1].items.push(pe);
    }
  }

  return (
    <div ref={containerRef} className="print-root" dir="rtl" style={{ display: phase === 'measure' ? 'none' : 'block' }}>
      {/* ── Cover page ── */}
      <div
        ref={(el) => { sectionRefs.current['cover'] = el; }}
        className="print-cover-page"
      >
        <div className="print-cover-brand">
          <div className="print-cover-logo">
            <Dumbbell size={28} />
          </div>
          <div className="print-cover-brand-text">
            <p>هانی ایزدی</p>
            <span>برنامه اختصاصی تمرین و تغذیه</span>
          </div>
        </div>
        <div className="print-cover-center">
          <span className="print-cover-pill">برنامه اختصاصی</span>
          <h1 className="print-cover-name">{student.name}</h1>
          <p className="print-cover-program-type">{programTitle}</p>
        </div>
        <div className="print-cover-footer">
          <div className="print-cover-info-grid">
            <div className="print-cover-info-item">
              <small>مربی</small>
              <strong>هانی ایزدی</strong>
            </div>
            <div className="print-cover-info-item">
              <small>تاریخ</small>
              <strong>{formatJalaliLong(todayStr)}</strong>
            </div>
            {activePlan && (
              <div className="print-cover-info-item">
                <small>بازه همکاری</small>
                <strong>{formatJalaliShort(activePlan.start_date)} تا {formatJalaliShort(activePlan.end_date)}</strong>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* ── Summary page ── */}
      {(mode === 'full' || mode === 'diet') && (
        <div
          ref={(el) => { sectionRefs.current['summary'] = el; }}
          className="print-summary-page"
        >
          <div className="print-page-header">
            <div className="print-page-brand">هانی ایزدی<small>برنامه اختصاصی</small></div>
            <div className="print-page-tag">خلاصه برنامه</div>
          </div>

          <h2 className="print-section-title">خلاصه برنامه</h2>

          <div className="print-student-card">
            <div className="print-student-card-row">
              <div className="print-student-card-item">
                <span className="print-student-card-label">نام</span>
                <span className="print-student-card-value">{student.name}</span>
              </div>
              {student.age != null && (
                <div className="print-student-card-item">
                  <span className="print-student-card-label">سن</span>
                  <span className="print-student-card-value">{toPersianDigits(student.age)} سال</span>
                </div>
              )}
              {student.height_cm != null && (
                <div className="print-student-card-item">
                  <span className="print-student-card-label">قد</span>
                  <span className="print-student-card-value">{toPersianDigits(student.height_cm)} سانتی‌متر</span>
                </div>
              )}
              {student.weight_kg != null && (
                <div className="print-student-card-item">
                  <span className="print-student-card-label">وزن</span>
                  <span className="print-student-card-value">{toPersianDigits(student.weight_kg)} کیلوگرم</span>
                </div>
              )}
              {student.goal && (
                <div className="print-student-card-item">
                  <span className="print-student-card-label">هدف</span>
                  <span className="print-student-card-value">{student.goal}</span>
                </div>
              )}
            </div>
          </div>

          <div className="print-summary-grid">
            {program?.diet_pattern && (
              <div className="print-summary-item">
                <span className="print-summary-label">الگوی رژیم</span>
                <span className="print-summary-value">{program.diet_pattern}</span>
              </div>
            )}
            {program?.diet_target_calories != null && (
              <div className="print-summary-item">
                <span className="print-summary-label">کالری هدف روزانه</span>
                <span className="print-summary-value">{toPersianDigits(program.diet_target_calories)} کالری</span>
              </div>
            )}
            {program?.diet_target_protein_g != null && (
              <div className="print-summary-item">
                <span className="print-summary-label">پروتئین هدف</span>
                <span className="print-summary-value">{toPersianDigits(program.diet_target_protein_g)} گرم</span>
              </div>
            )}
            {hasDiet && (
              <div className="print-summary-item">
                <span className="print-summary-label">تعداد وعده‌ها</span>
                <span className="print-summary-value">{toPersianDigits(dietMeals.length)}</span>
              </div>
            )}
            {hasWorkout && (
              <div className="print-summary-item">
                <span className="print-summary-label">تعداد روزهای تمرین</span>
                <span className="print-summary-value">{toPersianDigits(workoutDays.length)}</span>
              </div>
            )}
            {hasWorkout && (
              <div className="print-summary-item">
                <span className="print-summary-label">تعداد حرکات</span>
                <span className="print-summary-value">{toPersianDigits(programExercises.length)}</span>
              </div>
            )}
            {hasTips && (
              <div className="print-summary-item">
                <span className="print-summary-label">تعداد نکات اجرایی</span>
                <span className="print-summary-value">{toPersianDigits(tipsToShow.length)}</span>
              </div>
            )}
          </div>

          {activePlan && (
            <div className="print-summary-plan">
              <div className="print-summary-item">
                <span className="print-summary-label">بازه همکاری</span>
                <span className="print-summary-value">
                  {formatJalaliShort(activePlan.start_date)} تا {formatJalaliShort(activePlan.end_date)}
                </span>
              </div>
            </div>
          )}

          <div className="print-page-footer">
            <span>{student.name}</span>
          </div>
        </div>
      )}

      {/* ── Table of contents ── */}
      {(mode === 'full' || mode === 'diet') && sections.length > 0 && (
        <div
          ref={(el) => { sectionRefs.current['toc'] = el; }}
          className="print-toc-page"
        >
          <div className="print-page-header">
            <div className="print-page-brand">هانی ایزدی<small>برنامه اختصاصی</small></div>
            <div className="print-page-tag">فهرست مطالب</div>
          </div>

          <h2 className="print-section-title">فهرست مطالب</h2>
          <ul className="print-toc-list">
            {sections.map((s) => (
              <li key={s.key} className="print-toc-item">
                <span className="print-toc-title">{s.title}</span>
                <span className="print-toc-dots">·············································</span>
                <span className="print-toc-page">{pageNumbers[s.key] ? toPersianDigits(pageNumbers[s.key]) : '—'}</span>
              </li>
            ))}
          </ul>

          <div className="print-page-footer">
            <span>{student.name}</span>
          </div>
        </div>
      )}

      {/* ── Diet section ── */}
      {hasDiet && (
        <div
          ref={(el) => { sectionRefs.current['diet'] = el; }}
          className="print-content-section"
        >
          <div className="print-page-header">
            <div className="print-page-brand">هانی ایزدی<small>برنامه اختصاصی</small></div>
            <div className="print-page-tag">برنامه غذایی</div>
          </div>

          <h2 className="print-section-title">
            <Apple size={18} className="print-section-icon" />
            برنامه غذایی
          </h2>

          {(program?.diet_target_calories != null || program?.diet_target_protein_g != null || program?.diet_pattern) && (
            <div className="print-diet-targets">
              {program?.diet_pattern && (
                <span className="print-diet-target-badge">{program.diet_pattern}</span>
              )}
              {program?.diet_target_calories != null && (
                <span className="print-diet-target-text">
                  کالری هدف: <strong>{toPersianDigits(program.diet_target_calories)}</strong>
                </span>
              )}
              {program?.diet_target_protein_g != null && (
                <span className="print-diet-target-text">
                  پروتئین هدف: <strong>{toPersianDigits(program.diet_target_protein_g)} گرم</strong>
                </span>
              )}
            </div>
          )}

          {dietMeals.length > 0 && (
            <div className="print-meals">
              {dietMeals.map((meal, mi) => {
                const foods = dietFoodItemsByMeal.get(meal.id) ?? [];
                return (
                  <div key={meal.id} className="print-meal break-inside-avoid">
                    <div className="print-meal-header">
                      <span className="print-meal-number">{toPersianDigits(mi + 1)}</span>
                      <h3 className="print-meal-name">{meal.name || `وعده ${toPersianDigits(mi + 1)}`}</h3>
                    </div>
                    {(meal.fasting_start || meal.fasting_end) && (
                      <p className="print-meal-fasting">
                        بازه ناشتایی: {meal.fasting_start} تا {meal.fasting_end}
                      </p>
                    )}
                    {foods.length > 0 && (
                      <table className="print-food-table">
                        <thead>
                          <tr>
                            <th className="print-food-col-name">ماده غذایی</th>
                            <th className="print-food-col-amount">مقدار</th>
                            <th className="print-food-col-raw">خام/پخته</th>
                            <th className="print-food-col-alt">جایگزین</th>
                          </tr>
                        </thead>
                        <tbody>
                          {foods.map((f) => (
                            <tr key={f.id}>
                              <td className="print-food-cell-name">
                                {f.name}
                                {f.notes && <p className="print-food-notes">{f.notes}</p>}
                              </td>
                              <td className="print-food-cell-amount">
                                {f.amount}{f.unit ? ` ${f.unit}` : ''}
                              </td>
                              <td className="print-food-cell-raw">
                                {f.is_raw === true ? 'خام' : f.is_raw === false ? 'پخته' : '—'}
                              </td>
                              <td className="print-food-cell-alt">{f.alternatives || '—'}</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    )}
                    {meal.notes && (
                      <p className="print-meal-notes">{meal.notes}</p>
                    )}
                  </div>
                );
              })}
            </div>
          )}

          {program?.custom_description && (
            <div className="print-diet-description">
              <p className="print-diet-desc-label">توضیحات تکمیلی</p>
              <p className="print-diet-desc-text">{program.custom_description}</p>
            </div>
          )}

          <div className="print-page-footer">
            <span>{student.name}</span>
          </div>
        </div>
      )}

      {/* ── Workout section ── */}
      {hasWorkout && (
        <div
          ref={(el) => { sectionRefs.current['workout'] = el; }}
          className="print-content-section"
        >
          <div className="print-page-header">
            <div className="print-page-brand">هانی ایزدی<small>برنامه اختصاصی</small></div>
            <div className="print-page-tag">برنامه تمرینی</div>
          </div>

          <h2 className="print-section-title">
            <Dumbbell size={18} className="print-section-icon" />
            برنامه تمرینی
          </h2>

          {program?.custom_name && (
            <p className="print-workout-name">{program.custom_name}</p>
          )}

          {workoutDays.map((day, di) => (
            <div key={`day-${di}`} className="print-workout-day break-inside-avoid">
              <div className="print-workout-day-title">
                <span className="print-workout-day-letter">{toPersianDigits(di + 1)}</span>
                {day.label}
              </div>
              <table className="print-exercise-table">
                <thead>
                  <tr>
                    <th className="print-ex-col-name">حرکت</th>
                    <th className="print-ex-col-sets">ست</th>
                    <th className="print-ex-col-reps">تکرار</th>
                    <th className="print-ex-col-rest">استراحت</th>
                    <th className="print-ex-col-rpe">RPE</th>
                    <th className="print-ex-col-link">آموزش</th>
                  </tr>
                </thead>
                <tbody>
                  {day.items.map((pe, i) => (
                    <tr key={pe.id ?? `pe-${di}-${i}`}>
                      <td className="print-ex-cell-name">
                        <span className="print-ex-num">{toPersianDigits(i + 1)}.</span>
                        <span className="print-ex-name">{pe.exercise_name_fa || pe.exercise_name_en}</span>
                        {pe.coach_notes && (
                          <p className="print-ex-notes">{pe.coach_notes}</p>
                        )}
                      </td>
                      <td className="print-ex-cell-sets">{pe.sets != null ? toPersianDigits(pe.sets) : '—'}</td>
                      <td className="print-ex-cell-reps">{pe.reps || '—'}</td>
                      <td className="print-ex-cell-rest">{pe.rest_seconds != null ? `${toPersianDigits(pe.rest_seconds)}ث` : '—'}</td>
                      <td className="print-ex-cell-rpe">{pe.rpe != null ? toPersianDigits(pe.rpe) : '—'}</td>
                      <td className="print-ex-cell-link">
                        {pe.exercise_video_url ? (
                          <a
                            href={pe.exercise_video_url}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="print-ex-link"
                          >
                            مشاهده آموزش
                          </a>
                        ) : (
                          <span className="print-ex-no-link">—</span>
                        )}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ))}

          <div className="print-page-footer">
            <span>{student.name}</span>
          </div>
        </div>
      )}

      {/* ── Tips section ── */}
      {hasTips && (
        <div
          ref={(el) => { sectionRefs.current['tips'] = el; }}
          className="print-content-section"
        >
          <div className="print-page-header">
            <div className="print-page-brand">هانی ایزدی<small>برنامه اختصاصی</small></div>
            <div className="print-page-tag">نکات اجرایی</div>
          </div>

          <h2 className="print-section-title">
            <Lightbulb size={18} className="print-section-icon" />
            نکات و توصیه‌های اجرایی
          </h2>
          <div className="print-tips">
            {tipsToShow.map((pt) => {
              const tip = dietTips.find((d) => d.id === pt.tip_id);
              const category = tip?.category ?? 'custom';
              return (
                <div key={pt.id} className="print-tip break-inside-avoid">
                  <div className="print-tip-header">
                    <span className="print-tip-category">
                      {DIET_TIP_CATEGORY_LABELS[category as DietTipCategory] ?? category}
                    </span>
                    {tip?.title && <span className="print-tip-title">{tip.title}</span>}
                  </div>
                  <p className="print-tip-body">{pt.custom_text}</p>
                </div>
              );
            })}
          </div>

          <div className="print-page-footer">
            <span>{student.name}</span>
          </div>
        </div>
      )}
    </div>
  );
}
