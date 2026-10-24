import { useEffect, useState } from 'react';
import type { Template } from '@/lib/supabase';

export interface ProgramFormValues {
  workout_template_id: string | null;
  diet_template_id: string | null;
  custom_name: string;
  custom_description: string;
}

interface ProgramFormProps {
  templates: Template[];
  initial?: Partial<ProgramFormValues>;
  onSubmit: (values: ProgramFormValues) => void;
  onCancel: () => void;
  submitLabel?: string;
}

export default function ProgramForm({
  templates,
  initial,
  onSubmit,
  onCancel,
  submitLabel = 'ذخیره برنامه',
}: ProgramFormProps) {
  const [values, setValues] = useState<ProgramFormValues>({
    workout_template_id: null,
    diet_template_id: null,
    custom_name: '',
    custom_description: '',
  });

  useEffect(() => {
    if (initial) {
      setValues({
        workout_template_id: initial.workout_template_id ?? null,
        diet_template_id: initial.diet_template_id ?? null,
        custom_name: initial.custom_name ?? '',
        custom_description: initial.custom_description ?? '',
      });
    }
  }, [initial]);

  const workoutTemplates = templates.filter((t) => t.type === 'workout');
  const dietTemplates = templates.filter((t) => t.type === 'diet');

  const set = <K extends keyof ProgramFormValues>(key: K, value: ProgramFormValues[K]) => {
    setValues((v) => ({ ...v, [key]: value }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit(values);
  };

  const renderTemplateCard = (
    t: Template,
    selected: boolean,
    onSelect: () => void,
  ) => (
    <button
      type="button"
      key={t.id}
      onClick={onSelect}
      className={`text-right rounded-xl border p-4 transition-all ${
        selected
          ? 'border-brand-500 bg-brand-50 ring-2 ring-brand-100'
          : 'border-gray-200 bg-white hover:border-gray-300 hover:bg-gray-50'
      }`}
    >
      <div className="flex items-start justify-between gap-2">
        <h4 className="text-sm font-semibold text-gray-800">{t.name}</h4>
        <span
          className={`mt-0.5 h-4 w-4 shrink-0 rounded-full border-2 ${
            selected ? 'border-brand-600 bg-brand-600' : 'border-gray-300'
          }`}
        />
      </div>
      <p className="mt-1.5 text-xs leading-6 text-gray-500">{t.description}</p>
    </button>
  );

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-5">
      <div className="flex flex-col gap-2">
        <label className="text-sm font-medium text-gray-700">قالب تمرینی</label>
        <div className="grid grid-cols-1 gap-2.5">
          {workoutTemplates.map((t) =>
            renderTemplateCard(t, values.workout_template_id === t.id, () =>
              set(
                'workout_template_id',
                values.workout_template_id === t.id ? null : t.id,
              ),
            ),
          )}
        </div>
      </div>

      <div className="flex flex-col gap-2">
        <label className="text-sm font-medium text-gray-700">قالب غذایی</label>
        <div className="grid grid-cols-1 gap-2.5">
          {dietTemplates.map((t) =>
            renderTemplateCard(t, values.diet_template_id === t.id, () =>
              set(
                'diet_template_id',
                values.diet_template_id === t.id ? null : t.id,
              ),
            ),
          )}
        </div>
      </div>

      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">نام سفارشی برنامه</label>
        <input
          type="text"
          value={values.custom_name}
          onChange={(e) => set('custom_name', e.target.value)}
          placeholder="مثال: برنامه اختصاصی سارا"
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
        />
      </div>

      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">توضیحات سفارشی</label>
        <textarea
          value={values.custom_description}
          onChange={(e) => set('custom_description', e.target.value)}
          placeholder="یادداشت‌ها یا تنظیمات خاص این شاگرد..."
          rows={3}
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6"
        />
      </div>

      <div className="flex justify-start gap-2 pt-1">
        <button
          type="submit"
          className="px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 transition-colors shadow-sm"
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
