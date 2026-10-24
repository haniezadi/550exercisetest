import { useState } from 'react';
import {
  type Exercise,
  type ExerciseType,
  type ExerciseDifficulty,
  type ExerciseLocation,
  EXERCISE_TYPE_LABELS,
  EXERCISE_DIFFICULTY_LABELS,
  EXERCISE_LOCATION_LABELS,
  MUSCLE_OPTIONS,
  EQUIPMENT_OPTIONS,
  TAG_SUGGESTIONS,
} from '@/lib/supabase';

export interface ExerciseFormValues {
  name_fa: string;
  name_en: string;
  primary_muscles: string[];
  secondary_muscles: string[];
  exercise_type: ExerciseType;
  equipment: string[];
  difficulty: ExerciseDifficulty;
  location: ExerciseLocation;
  instructions: string;
  tips: string;
  limitations: string;
  alternative_names: string;
  video_url: string;
  is_active: boolean;
  is_favorite: boolean;
  tags: string[];
  coach_notes: string;
}

export default function ExerciseForm({
  initial,
  onSubmit,
  onCancel,
  submitLabel,
  duplicateNames,
}: {
  initial?: Exercise;
  onSubmit: (vals: ExerciseFormValues) => void;
  onCancel: () => void;
  submitLabel: string;
  duplicateNames?: string[];
}) {
  const [vals, setVals] = useState<ExerciseFormValues>({
    name_fa: initial?.name_fa ?? '',
    name_en: initial?.name_en ?? '',
    primary_muscles: initial?.primary_muscles ?? [],
    secondary_muscles: initial?.secondary_muscles ?? [],
    exercise_type: initial?.exercise_type ?? 'strength',
    equipment: initial?.equipment ?? [],
    difficulty: initial?.difficulty ?? 'beginner',
    location: initial?.location ?? 'both',
    instructions: initial?.instructions ?? '',
    tips: initial?.tips ?? '',
    limitations: initial?.limitations ?? '',
    alternative_names: initial?.alternative_names ?? '',
    video_url: initial?.video_url ?? '',
    is_active: initial?.is_active ?? true,
    is_favorite: initial?.is_favorite ?? false,
    tags: initial?.tags ?? [],
    coach_notes: initial?.coach_notes ?? '',
  });

  const [confirmDuplicate, setConfirmDuplicate] = useState(false);

  const set = <K extends keyof ExerciseFormValues>(k: K, v: ExerciseFormValues[K]) =>
    setVals((s) => ({ ...s, [k]: v }));

  const toggleArray = (key: 'primary_muscles' | 'secondary_muscles' | 'equipment' | 'tags', value: string) => {
    setVals((s) => {
      const arr = s[key];
      return { ...s, [key]: arr.includes(value) ? arr.filter((x) => x !== value) : [...arr, value] };
    });
  };

  const checkDuplicate = (): boolean => {
    if (!duplicateNames || duplicateNames.length === 0) return false;
    const nameFa = vals.name_fa.trim();
    const nameEn = vals.name_en.trim().toLowerCase();
    return duplicateNames.some((n) => {
      const lower = n.toLowerCase();
      return lower === nameFa.toLowerCase() || lower === nameEn || n.toLowerCase() === nameFa.toLowerCase();
    });
  };

  const handleSubmit = (e: React.FormEvent, force = false) => {
    e.preventDefault();
    if (!vals.name_fa.trim() && !vals.name_en.trim()) return;
    if (checkDuplicate() && !force && !confirmDuplicate) {
      setConfirmDuplicate(true);
      return;
    }
    setConfirmDuplicate(false);
    onSubmit(vals);
  };

  const renderChips = (
    key: 'primary_muscles' | 'secondary_muscles' | 'equipment' | 'tags',
    options: string[],
    label: string,
  ) => (
    <div className="flex flex-col gap-1.5">
      <label className="text-sm font-medium text-gray-600">{label}</label>
      <div className="flex flex-wrap gap-1.5">
        {options.map((opt) => {
          const active = vals[key].includes(opt);
          return (
            <button
              key={opt}
              type="button"
              onClick={() => toggleArray(key, opt)}
              className={`rounded-lg border px-3 py-1.5 text-xs font-medium transition-all ${
                active
                  ? 'border-brand-500 bg-brand-50 text-brand-700'
                  : 'border-gray-200 bg-white text-gray-600 hover:bg-gray-50'
              }`}
            >
              {opt}
            </button>
          );
        })}
      </div>
    </div>
  );

  const renderChoice = (
    key: 'exercise_type' | 'difficulty' | 'location',
    options: Record<string, string>,
    label: string,
  ) => (
    <div className="flex flex-col gap-1.5">
      <label className="text-sm font-medium text-gray-600">{label}</label>
      <div className="flex gap-1.5 flex-wrap">
        {Object.entries(options).map(([val, lbl]) => (
          <button
            key={val}
            type="button"
            onClick={() => set(key, val as ExerciseFormValues[typeof key])}
            className={`rounded-lg border px-3 py-2 text-xs font-medium transition-all ${
              vals[key] === val
                ? 'border-brand-500 bg-brand-50 text-brand-700 ring-2 ring-brand-100'
                : 'border-gray-200 bg-white text-gray-600 hover:bg-gray-50'
            }`}
          >
            {lbl}
          </button>
        ))}
      </div>
    </div>
  );

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-4">
      {confirmDuplicate && (
        <div className="rounded-xl border border-amber-200 bg-amber-50 p-3 text-sm text-amber-800 leading-7">
          حرکتی با این نام احتمالاً تکراری است. آیا مطمئن هستید که می‌خواهید ادامه دهید؟
          <div className="mt-2 flex gap-2">
            <button
              type="button"
              onClick={(e) => handleSubmit(e as unknown as React.FormEvent, true)}
              className="rounded-lg bg-amber-600 px-4 py-1.5 text-xs font-medium text-white hover:bg-amber-700 transition-colors"
            >
              بله، ثبت کن
            </button>
            <button
              type="button"
              onClick={() => setConfirmDuplicate(false)}
              className="rounded-lg bg-gray-100 px-4 py-1.5 text-xs font-medium text-gray-700 hover:bg-gray-200 transition-colors"
            >
              اصلاح نام
            </button>
          </div>
        </div>
      )}

      <div className="grid grid-cols-2 gap-3">
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-medium text-gray-600">نام فارسی</label>
          <input
            type="text"
            value={vals.name_fa}
            onChange={(e) => set('name_fa', e.target.value)}
            placeholder="مثال: اسکات با هالتر"
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
          />
        </div>
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-medium text-gray-600">نام انگلیسی</label>
          <input
            type="text"
            value={vals.name_en}
            onChange={(e) => set('name_en', e.target.value)}
            placeholder="Barbell Squat"
            dir="ltr"
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 text-left"
          />
        </div>
      </div>

      {renderChips('primary_muscles', MUSCLE_OPTIONS, 'عضلات اصلی')}
      {renderChips('secondary_muscles', MUSCLE_OPTIONS, 'عضلات کمکی')}
      {renderChips('equipment', EQUIPMENT_OPTIONS, 'تجهیزات موردنیاز')}

      <div className="grid grid-cols-3 gap-3">
        {renderChoice('exercise_type', EXERCISE_TYPE_LABELS, 'نوع حرکت')}
        {renderChoice('difficulty', EXERCISE_DIFFICULTY_LABELS, 'سطح دشواری')}
        {renderChoice('location', EXERCISE_LOCATION_LABELS, 'محل اجرا')}
      </div>

      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">روش اجرای صحیح</label>
        <textarea
          value={vals.instructions}
          onChange={(e) => set('instructions', e.target.value)}
          rows={3}
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6"
        />
      </div>

      <div className="grid grid-cols-2 gap-3">
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-medium text-gray-600">نکات مهم و خطاهای رایج</label>
          <textarea
            value={vals.tips}
            onChange={(e) => set('tips', e.target.value)}
            rows={2}
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6"
          />
        </div>
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-medium text-gray-600">محدودیت‌ها و ملاحظات</label>
          <textarea
            value={vals.limitations}
            onChange={(e) => set('limitations', e.target.value)}
            rows={2}
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6"
          />
        </div>
      </div>

      <div className="grid grid-cols-2 gap-3">
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-medium text-gray-600">حرکات جایگزین (با کاما جدا کنید)</label>
          <input
            type="text"
            value={vals.alternative_names}
            onChange={(e) => set('alternative_names', e.target.value)}
            placeholder="اسکات با دمبل, گابلت اسکات"
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
          />
        </div>
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-medium text-gray-600">لینک ویدئوی آموزشی</label>
          <input
            type="text"
            value={vals.video_url}
            onChange={(e) => set('video_url', e.target.value)}
            placeholder="https://drive.google.com/..."
            dir="ltr"
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 text-left"
          />
        </div>
      </div>

      {renderChips('tags', TAG_SUGGESTIONS, 'برچسب‌ها')}

      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">یادداشت خصوصی مربی</label>
        <textarea
          value={vals.coach_notes}
          onChange={(e) => set('coach_notes', e.target.value)}
          rows={2}
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6"
        />
      </div>

      <div className="flex gap-4">
        <label className="flex items-center gap-2 text-sm text-gray-600 cursor-pointer">
          <input
            type="checkbox"
            checked={vals.is_active}
            onChange={(e) => set('is_active', e.target.checked)}
            className="h-4 w-4 rounded border-gray-300 text-brand-600 focus:ring-brand-500"
          />
          فعال
        </label>
        <label className="flex items-center gap-2 text-sm text-gray-600 cursor-pointer">
          <input
            type="checkbox"
            checked={vals.is_favorite}
            onChange={(e) => set('is_favorite', e.target.checked)}
            className="h-4 w-4 rounded border-gray-300 text-brand-600 focus:ring-brand-500"
          />
          پرکاربرد
        </label>
      </div>

      <div className="flex justify-start gap-2 pt-2">
        <button
          type="submit"
          className="px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 transition-colors"
        >
          {submitLabel}
        </button>
        <button
          type="button"
          onClick={onCancel}
          className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200 transition-colors"
        >
          انصراف
        </button>
      </div>
    </form>
  );
}
