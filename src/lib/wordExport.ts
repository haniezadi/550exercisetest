import type {
  Student,
  AssignedProgram,
  StudentPlan,
  ProgramExercise,
  DietProgramMeal,
  DietProgramFoodItem,
  DietProgramTip,
  DietTip,
  Template,
} from '@/lib/supabase';
import { DIET_TIP_CATEGORY_LABELS } from '@/lib/supabase';
import type { DietTipCategory } from '@/lib/supabase';
import { formatJalaliLong, formatJalaliShort, toPersianDigits } from '@/lib/jalali';
import { todayInTehran } from '@/lib/supabase';

export function exportWordDoc(
  student: Student,
  program: AssignedProgram | null,
  activePlan: StudentPlan | null,
  programExercises: ProgramExercise[],
  dietMeals: DietProgramMeal[],
  dietFoodItemsByMeal: Map<string, DietProgramFoodItem[]>,
  dietProgramTips: DietProgramTip[],
  dietTips: DietTip[],
  dietTemplate: Template | null,
) {
  const today = todayInTehran();
  const lines: string[] = [];

  lines.push(`<html dir="rtl" lang="fa"><head><meta charset="utf-8"><title>برنامه ${student.name}</title>`);
  lines.push(`<style>body{font-family:'Vazirmatn','Segoe UI',Tahoma,sans-serif;line-height:1.8;color:#1f2937;padding:40px}h1{color:#1c5a48;font-size:24px;border-bottom:2px solid #1c5a48;padding-bottom:8px}h2{color:#1c5a48;font-size:18px;margin-top:24px}table{width:100%;border-collapse:collapse;margin:8px 0}th,td{border:1px solid #d1d5db;padding:6px 10px;text-align:right;font-size:13px}th{background:#f0faf5;color:#1c5a48;font-weight:bold}.tip{margin:8px 0;padding:8px;background:#fffbf0;border-right:3px solid #d4a017;border-radius:4px}.cover{text-align:center;padding:40px 0}.cover h1{font-size:32px;border:none}.info{margin:20px 0}.info td{border:none;padding:4px 10px}</style></head><body>`);

  // Cover
  lines.push(`<div class="cover"><h1>برنامه اختصاصی ${student.name}</h1><p style="font-size:16px;color:#667">هانی ایزدی — ${formatJalaliLong(today)}</p></div>`);

  // Student info table
  lines.push(`<div class="info"><table>`);
  if (student.age != null) lines.push(`<tr><td>سن</td><td>${toPersianDigits(student.age)} سال</td></tr>`);
  if (student.height_cm != null) lines.push(`<tr><td>قد</td><td>${toPersianDigits(student.height_cm)} سانتی‌متر</td></tr>`);
  if (student.weight_kg != null) lines.push(`<tr><td>وزن</td><td>${toPersianDigits(student.weight_kg)} کیلوگرم</td></tr>`);
  if (student.goal) lines.push(`<tr><td>هدف</td><td>${student.goal}</td></tr>`);
  if (activePlan) lines.push(`<tr><td>بازه همکاری</td><td>${formatJalaliShort(activePlan.start_date)} تا ${formatJalaliShort(activePlan.end_date)}</td></tr>`);
  lines.push(`</table></div>`);

  // Diet targets
  if (program?.diet_target_calories != null || program?.diet_target_protein_g != null) {
    lines.push(`<h2>اهداف روزانه</h2><table>`);
    if (program?.diet_target_calories != null) lines.push(`<tr><td>کالری هدف</td><td>${toPersianDigits(program.diet_target_calories)} کالری</td></tr>`);
    if (program?.diet_target_protein_g != null) lines.push(`<tr><td>پروتئین هدف</td><td>${toPersianDigits(program.diet_target_protein_g)} گرم</td></tr>`);
    if (program?.diet_pattern) lines.push(`<tr><td>الگوی رژیم</td><td>${program.diet_pattern}</td></tr>`);
    lines.push(`</table>`);
  }

  // Diet meals
  if (dietMeals.length > 0) {
    lines.push(`<h2>برنامه غذایی</h2>`);
    dietMeals.forEach((meal, mi) => {
      const foods = dietFoodItemsByMeal.get(meal.id) ?? [];
      lines.push(`<h3>${meal.name || `وعده ${toPersianDigits(mi + 1)}`}</h3>`);
      if (foods.length > 0) {
        lines.push(`<table><tr><th>ماده غذایی</th><th>مقدار</th><th>واحد</th><th>وضعیت</th></tr>`);
        foods.forEach(f => {
          lines.push(`<tr><td>${f.name}</td><td>${f.amount || ''}</td><td>${f.unit || ''}</td><td>${f.is_raw ? 'خام' : 'پخته'}</td></tr>`);
        });
        lines.push(`</table>`);
      }
      if (meal.notes) lines.push(`<p style="font-size:12px;color:#667">${meal.notes}</p>`);
    });
  }

  // Workout
  if (programExercises.length > 0) {
    lines.push(`<h2>برنامه تمرینی</h2>`);
    const days: { label: string; items: ProgramExercise[] }[] = [];
    const seen = new Set<string>();
    for (const pe of programExercises) {
      const day = pe.day_label || 'روز ۱';
      if (!seen.has(day)) { seen.add(day); days.push({ label: day, items: [] }); }
      days[days.length - 1].items.push(pe);
    }
    days.forEach(day => {
      lines.push(`<h3>${day.label}</h3>`);
      lines.push(`<table><tr><th>#</th><th>حرکت</th><th>ست</th><th>تکرار</th><th>استراحت</th><th>ویدئو</th></tr>`);
      day.items.forEach((pe, i) => {
        const videoLink = pe.exercise_video_url ? `<a href="${pe.exercise_video_url}">مشاهده</a>` : '—';
        lines.push(`<tr><td>${toPersianDigits(i + 1)}</td><td>${pe.exercise_name_fa || pe.exercise_name_en}${pe.coach_notes ? `<br><small>${pe.coach_notes}</small>` : ''}</td><td>${pe.sets != null ? toPersianDigits(pe.sets) : '—'}</td><td>${pe.reps || '—'}</td><td>${pe.rest_seconds != null ? toPersianDigits(pe.rest_seconds) + 'ث' : '—'}</td><td>${videoLink}</td></tr>`);
      });
      lines.push(`</table>`);
    });
  }

  // Tips
  if (dietProgramTips.length > 0) {
    lines.push(`<h2>نکات اجرایی</h2>`);
    dietProgramTips.forEach(pt => {
      const tip = dietTips.find(d => d.id === pt.tip_id);
      const category = tip?.category ?? 'custom';
      lines.push(`<div class="tip"><strong>${DIET_TIP_CATEGORY_LABELS[category as DietTipCategory] ?? category}</strong>${tip?.title ? ` — ${tip.title}` : ''}<br>${pt.custom_text}</div>`);
    });
  }

  if (program?.custom_description) {
    lines.push(`<h2>توضیحات تکمیلی</h2><p>${program.custom_description}</p>`);
  }

  lines.push(`<p style="margin-top:30px;font-size:11px;color:#999;text-align:center">این سند توسط پنل هانی ایزدی تولید شده است.</p>`);
  lines.push(`</body></html>`);

  const html = lines.join('\n');
  const blob = new Blob(['\ufeff', html], { type: 'application/msword' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `برنامه ${student.name}.doc`;
  a.click();
  URL.revokeObjectURL(url);
}
