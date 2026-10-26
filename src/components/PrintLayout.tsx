import { useEffect, useRef, useState } from 'react';
import { Dumbbell, Apple, Rocket } from 'lucide-react';
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
  WeeklyDietMeal,
  WeeklyDietFoodItem,
  MealSubstitution,
  MealSubstitutionFoodItem,
  Reminder,
  ProgressReport,
} from '@/lib/supabase';
import { DIET_TIP_CATEGORY_LABELS, DAY_OF_WEEK_LABELS, MEAL_TYPE_LABELS, type DayOfWeek } from '@/lib/supabase';
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
  weeklyDietMeals: WeeklyDietMeal[];
  weeklyFoodItemsByMeal: Map<string, WeeklyDietFoodItem[]>;
  weeklySubsByMeal: Map<string, MealSubstitution[]>;
  weeklySubFoodItemsBySub: Map<string, MealSubstitutionFoodItem[]>;
  reminders: Reminder[];
  progressReports: ProgressReport[];
  nextReportDate: string | null;
  onDone: () => void;
}

interface SectionInfo {
  key: string;
  title: string;
}

const A4_USABLE_HEIGHT_PX = 1011;
const WEEK_DAY_ORDER: DayOfWeek[] = ['شنبه', 'یکشنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنجشنبه', 'جمعه'];

function sanitizeFilename(name: string): string {
  const cleaned = name.trim().replace(/[\\/:*?"<>|]/g, ' ').replace(/\s+/g, ' ').trim();
  return cleaned || 'برنامه-شاگرد';
}

function weekDayIndex(label: string): number {
  for (let i = 0; i < WEEK_DAY_ORDER.length; i++) {
    if (label.startsWith(WEEK_DAY_ORDER[i])) return i;
  }
  return WEEK_DAY_ORDER.length;
}

function calcMealCalories(foods: WeeklyDietFoodItem[]): number {
  let sum = 0;
  for (const f of foods) {
    if (f.calories != null) sum += Number(f.calories);
  }
  return sum;
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
  weeklyDietMeals,
  weeklyFoodItemsByMeal,
  weeklySubsByMeal,
  weeklySubFoodItemsBySub,
  reminders,
  progressReports,
  nextReportDate,
  onDone,
}: PrintLayoutProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const sectionRefs = useRef<Record<string, HTMLElement | null>>({});
  const [pageNumbers, setPageNumbers] = useState<Record<string, number>>({});
  const [phase, setPhase] = useState<'measure' | 'print'>('measure');

  const hasWorkout = mode === 'full' && programExercises.length > 0;
  const hasWeeklyDiet = weeklyDietMeals.length > 0;
  const hasLegacyDiet = dietMeals.length > 0;
  const hasDiet = (mode === 'full' || mode === 'diet') && (hasWeeklyDiet || hasLegacyDiet);

  // Workout days ordered by Persian week
  const workoutDays: { label: string; items: ProgramExercise[] }[] = [];
  {
    const grouped = new Map<string, ProgramExercise[]>();
    for (const pe of programExercises) {
      const day = pe.day_label || 'روز ۱';
      const arr = grouped.get(day) ?? [];
      arr.push(pe);
      grouped.set(day, arr);
    }
    const sortedKeys = Array.from(grouped.keys()).sort((a, b) => weekDayIndex(a) - weekDayIndex(b));
    for (const k of sortedKeys) {
      workoutDays.push({ label: k, items: grouped.get(k)!.slice().sort((a, b) => a.sort_order - b.sort_order) });
    }
  }

  // Weekly diet meals grouped by day, ordered by Persian week
  const weeklyByDay: { day: DayOfWeek; meals: WeeklyDietMeal[] }[] = [];
  if (hasWeeklyDiet) {
    const grouped = new Map<DayOfWeek, WeeklyDietMeal[]>();
    for (const m of weeklyDietMeals) {
      const arr = grouped.get(m.day_of_week) ?? [];
      arr.push(m);
      grouped.set(m.day_of_week, arr);
    }
    for (const d of WEEK_DAY_ORDER) {
      const arr = grouped.get(d);
      if (arr && arr.length > 0) {
        arr.sort((a, b) => a.sort_order - b.sort_order);
        weeklyByDay.push({ day: d, meals: arr });
      }
    }
  }

  // Quick-start content
  const pendingReminders = reminders.filter((r) => r.status === 'pending').sort((a, b) => a.due_date.localeCompare(b.due_date));
  const nextReminder = pendingReminders[0] ?? null;

  const sections: SectionInfo[] = [];
  if (mode === 'full') sections.push({ key: 'quickstart', title: 'راهنمای شروع سریع' });
  if (hasDiet) sections.push({ key: 'diet', title: 'برنامه تغذیه' });
  if (hasWorkout) sections.push({ key: 'workout', title: 'برنامه تمرین' });

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
      mode === 'diet'
        ? 'برنامه غذایی'
        : 'برنامه اختصاصی';
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
    mode === 'diet'
      ? 'برنامه غذایی'
      : hasWorkout && hasDiet
        ? 'برنامه اختصاصی تمرین و تغذیه'
        : hasWorkout
          ? 'برنامه اختصاصی تمرین'
          : 'برنامه اختصاصی تغذیه';

  const todayStr = todayInTehran();
  const showToc = sections.length > 2;

  const renderPageHeader = (tag: string) => (
    <div className="print-page-header">
      <div className="print-page-brand">هانی ایزدی<small>برنامه اختصاصی تمرین و تغذیه</small></div>
      <div className="print-page-tag">{tag}</div>
    </div>
  );

  const renderPageFooter = (sectionKey?: string) => (
    <div className="print-page-footer">
      <span>{student.name}</span>
      {sectionKey && pageNumbers[sectionKey] != null && (
        <span className="print-page-footer-num">{toPersianDigits(pageNumbers[sectionKey])}</span>
      )}
    </div>
  );

  return (
    <div ref={containerRef} className="print-root" dir="rtl" style={{ display: phase === 'measure' ? 'none' : 'block' }}>
      {/* ── 1. Cover page ── */}
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
            {activePlan && (
              <div className="print-cover-info-item">
                <small>بازه برنامه</small>
                <strong>{formatJalaliShort(activePlan.start_date)} تا {formatJalaliShort(activePlan.end_date)}</strong>
              </div>
            )}
            {!activePlan && (
              <div className="print-cover-info-item">
                <small>تاریخ صدور</small>
                <strong>{formatJalaliLong(todayStr)}</strong>
              </div>
            )}
            {activePlan && (
              <div className="print-cover-info-item">
                <small>تاریخ صدور</small>
                <strong>{formatJalaliLong(todayStr)}</strong>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* ── Table of contents ── */}
      {showToc && (
        <div
          ref={(el) => { sectionRefs.current['toc'] = el; }}
          className="print-toc-page"
        >
          {renderPageHeader('فهرست مطالب')}
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
          {renderPageFooter('toc')}
        </div>
      )}

      {/* ── 2. Quick-start guide ── */}
      {mode === 'full' && (
        <div
          ref={(el) => { sectionRefs.current['quickstart'] = el; }}
          className="print-content-section"
        >
          {renderPageHeader('راهنمای شروع سریع')}
          <h2 className="print-section-title">
            <Rocket size={18} className="print-section-icon" />
            راهنمای شروع سریع
          </h2>
          <div className="print-quickstart">
            <div className="print-quickstart-block">
              <h3 className="print-quickstart-h3">قوانین ضروری</h3>
              <ul className="print-quickstart-list">
                <li>برنامه را دقیقاً مطابق دستور مربی اجرا کنید؛ ست‌ها، تکرارها و استراحت‌ها را تغییر ندهید.</li>
                <li>وعده‌های غذایی را حذف نکنید؛ در صورت در دسترس نبودن یک ماده، از جایگزین‌های ذکر‌شده استفاده کنید.</li>
                <li>حداقل ۲ لیتر آب در روز مصرف کنید.</li>
                <li>در صورت بروز درد غیرعادی، تمرین را متوقف کرده و به مربی اطلاع دهید.</li>
              </ul>
            </div>
            <div className="print-quickstart-block">
              <h3 className="print-quickstart-h3">نحوه اجرای برنامه</h3>
              <ul className="print-quickstart-list">
                <li>روزهای تمرین را طبق تقسیم‌بندی هفتگی در بخش تمرین اجرا کنید.</li>
                <li>گرم کردن ۵ تا ۱۰ دقیقه پیش از شروع الزامی است.</li>
                <li>لینک ویدئوی آموزشی هر حرکت در جدول تمرین درج شده است؛ پیش از اجرا ببینید.</li>
              </ul>
            </div>
            {program?.custom_description && (
              <div className="print-quickstart-block">
                <h3 className="print-quickstart-h3">توضیحات برنامه</h3>
                <p className="print-quickstart-note">{program.custom_description}</p>
              </div>
            )}
            {nextReminder && (
              <div className="print-quickstart-block">
                <h3 className="print-quickstart-h3">گزارش بعدی</h3>
                <p className="print-quickstart-note">
                  تاریخ گزارش پیشرفت بعدی: <strong>{formatJalaliLong(nextReminder.due_date)}</strong>
                  {nextReminder.detail ? ` — ${nextReminder.detail}` : ''}
                </p>
              </div>
            )}
          </div>
          {renderPageFooter('quickstart')}
        </div>
      )}

      {/* ── 3. Diet section ── */}
      {hasDiet && (
        <div
          ref={(el) => { sectionRefs.current['diet'] = el; }}
          className="print-content-section"
        >
          {renderPageHeader('برنامه تغذیه')}
          <h2 className="print-section-title">
            <Apple size={18} className="print-section-icon" />
            برنامه تغذیه
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

          {/* Weekly diet program table (preferred data source) */}
          {hasWeeklyDiet && (
            <div className="print-weekly-diet">
              {weeklyByDay.map((dayData) => (
                <div key={dayData.day} className="print-weekly-day">
                  <div className="print-weekly-day-title">{dayData.day}</div>
                  <table className="print-food-table">
                    <thead>
                      <tr>
                        <th className="print-food-col-name">وعده / ماده غذایی</th>
                        <th className="print-food-col-amount">مقدار (گرم)</th>
                        <th className="print-food-col-household">واحد خانگی</th>
                        <th className="print-food-col-sub">جایگزین</th>
                        <th className="print-food-col-cal">کالری</th>
                      </tr>
                    </thead>
                    <tbody>
                      {dayData.meals.map((meal) => {
                        const foods = weeklyFoodItemsByMeal.get(meal.id) ?? [];
                        const subs = weeklySubsByMeal.get(meal.id) ?? [];
                        const mealCals = calcMealCalories(foods);
                        const mealLabel = meal.meal_name || MEAL_TYPE_LABELS[meal.meal_type] || 'وعده';
                        const rows: React.ReactNode[] = [];
                        foods.forEach((f, fi) => {
                          rows.push(
                            <tr key={f.id} className={fi === 0 ? 'print-meal-row-start' : ''}>
                              {fi === 0 ? (
                                <td className="print-food-cell-name">
                                  <span className="print-meal-label-inline">{mealLabel}</span>
                                  <span className="print-food-sub-name">{f.name}</span>
                                  {f.notes && <p className="print-food-notes">{f.notes}</p>}
                                </td>
                              ) : (
                                <td className="print-food-cell-name">
                                  <span className="print-food-sub-name">{f.name}</span>
                                  {f.notes && <p className="print-food-notes">{f.notes}</p>}
                                </td>
                              )}
                              <td className="print-food-cell-amount">{f.amount}{f.unit ? ` ${f.unit}` : ''}</td>
                              <td className="print-food-cell-household">{f.household_unit || '—'}</td>
                              <td className="print-food-cell-sub">
                                {subs.length > 0 ? subs.map((s) => s.substitution_name).join('، ') : '—'}
                              </td>
                              <td className="print-food-cell-cal">
                                {fi === 0 && mealCals > 0 ? toPersianDigits(Math.round(mealCals)) : ''}
                              </td>
                            </tr>
                          );
                        });
                        // Substitution detail rows
                        subs.forEach((sub) => {
                          const subFoods = weeklySubFoodItemsBySub.get(sub.id) ?? [];
                          subFoods.forEach((sf, sfi) => {
                            rows.push(
                              <tr key={sf.id} className="print-sub-row">
                                <td className="print-food-cell-name">
                                  <span className="print-sub-prefix">↳ {sub.substitution_name}</span>
                                  <span className="print-food-sub-name">{sf.name}</span>
                                </td>
                                <td className="print-food-cell-amount">{sf.amount}{sf.unit ? ` ${sf.unit}` : ''}</td>
                                <td className="print-food-cell-household">{sf.household_unit || '—'}</td>
                                <td className="print-food-cell-sub">—</td>
                                <td className="print-food-cell-cal">{sf.calories != null ? toPersianDigits(Math.round(Number(sf.calories))) : ''}</td>
                              </tr>
                            );
                          });
                        });
                        return rows;
                      })}
                    </tbody>
                  </table>
                </div>
              ))}
            </div>
          )}

          {/* Legacy diet meals (fallback) */}
          {!hasWeeklyDiet && hasLegacyDiet && (
            <div className="print-meals">
              {dietMeals.map((meal, mi) => {
                const foods = dietFoodItemsByMeal.get(meal.id) ?? [];
                return (
                  <div key={meal.id} className="print-meal break-inside-avoid">
                    <div className="print-meal-header">
                      <span className="print-meal-number">{toPersianDigits(mi + 1)}</span>
                      <h3 className="print-meal-name">{meal.name || `وعده ${toPersianDigits(mi + 1)}`}</h3>
                    </div>
                    {foods.length > 0 && (
                      <table className="print-food-table">
                        <thead>
                          <tr>
                            <th className="print-food-col-name">ماده غذایی</th>
                            <th className="print-food-col-amount">مقدار</th>
                            <th className="print-food-col-household">واحد خانگی</th>
                            <th className="print-food-col-sub">جایگزین</th>
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
                              <td className="print-food-cell-household">—</td>
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

          {renderPageFooter('diet')}
        </div>
      )}

      {/* ── 4. Workout section ── */}
      {hasWorkout && (
        <div
          ref={(el) => { sectionRefs.current['workout'] = el; }}
          className="print-content-section"
        >
          {renderPageHeader('برنامه تمرین')}
          <h2 className="print-section-title">
            <Dumbbell size={18} className="print-section-icon" />
            برنامه تمرین
          </h2>

          {/* Weekly split overview */}
          <div className="print-workout-split">
            <h3 className="print-workout-split-title">تقسیم‌بندی هفتگی</h3>
            <table className="print-food-table">
              <thead>
                <tr>
                  <th className="print-food-col-name">روز</th>
                  <th className="print-food-col-name">نوع جلسه</th>
                  <th className="print-food-col-amount">تعداد حرکات</th>
                </tr>
              </thead>
              <tbody>
                {workoutDays.map((d, i) => (
                  <tr key={i}>
                    <td className="print-food-cell-name">{d.label}</td>
                    <td className="print-food-cell-name">{d.items.length > 0 ? 'روز تمرینی' : '—'}</td>
                    <td className="print-food-cell-amount">{toPersianDigits(d.items.length)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Day details */}
          {workoutDays.map((day, di) => (
            <div key={`day-${di}`} className="print-workout-day">
              <div className="print-workout-day-title">
                <span className="print-workout-day-letter">{toPersianDigits(di + 1)}</span>
                {day.label}
              </div>
              <table className="print-exercise-table">
                <thead>
                  <tr>
                    <th className="print-ex-col-name">حرکت</th>
                    <th className="print-ex-col-sets">ست</th>
                    <th className="print-ex-col-reps">تکرار/مدت</th>
                    <th className="print-ex-col-rest">استراحت</th>
                    <th className="print-ex-col-notes">توضیحات</th>
                    <th className="print-ex-col-link">ویدئو</th>
                  </tr>
                </thead>
                <tbody>
                  {day.items.map((pe, i) => (
                    <tr key={pe.id ?? `pe-${di}-${i}`}>
                      <td className="print-ex-cell-name">
                        <span className="print-ex-num">{toPersianDigits(i + 1)}.</span>
                        <span className="print-ex-name">{pe.exercise_name_fa || pe.exercise_name_en}</span>
                        {pe.exercise_name_en && pe.exercise_name_en !== pe.exercise_name_fa && (
                          <p className="print-ex-en">{pe.exercise_name_en}</p>
                        )}
                      </td>
                      <td className="print-ex-cell-sets">{pe.sets != null ? toPersianDigits(pe.sets) : '—'}</td>
                      <td className="print-ex-cell-reps">{pe.reps || '—'}</td>
                      <td className="print-ex-cell-rest">{pe.rest_seconds != null ? `${toPersianDigits(pe.rest_seconds)}ث` : '—'}</td>
                      <td className="print-ex-cell-notes">{pe.coach_notes || '—'}</td>
                      <td className="print-ex-cell-link">
                        {pe.exercise_video_url ? (
                          <a
                            href={pe.exercise_video_url}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="print-ex-link"
                          >
                            مشاهده
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

          {/* Coach contact block */}
          <div className="print-coach-contact">
            <div className="print-coach-contact-inner">
              <span className="print-coach-contact-label">ارتباط با مربی</span>
              <a href="tel:09172775456" className="print-coach-phone">۰۹۱۷۲۷۷۵۴۵۶</a>
              <a
                href="https://t.me/"
                target="_blank"
                rel="noopener noreferrer"
                className="print-coach-telegram"
              >
                <svg className="print-coach-telegram-icon" viewBox="0 0 24 24" width="18" height="18" fill="currentColor" aria-hidden="true">
                  <path d="M9.78 18.65l.28-4.23 7.68-6.92c.34-.31-.07-.46-.52-.19L7.74 13.3 3.64 12c-.88-.25-.89-.86.2-1.3l15.97-6.16c.73-.33 1.43.36 1.15 1.3l-2.72 12.81c-.19.91-.74 1.13-1.5.71L12.6 16.3l-1.99 1.93c-.23.23-.42.42-.83.42z"/>
                </svg>
                <span>تلگرام</span>
              </a>
            </div>
          </div>

          {renderPageFooter('workout')}
        </div>
      )}
    </div>
  );
}
