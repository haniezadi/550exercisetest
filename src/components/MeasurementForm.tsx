import { useState } from 'react';
import { todayInTehran, type Measurement } from '@/lib/supabase';
import JalaliDatePicker from './JalaliDatePicker';

export interface MeasurementFormValues {
  recorded_at: string;
  weight_kg: string;
  waist_cm: string;
  hip_cm: string;
  chest_cm: string;
  thigh_cm: string;
  arm_cm: string;
  notes: string;
}

export default function MeasurementForm({
  initial,
  onSubmit,
  onCancel,
  submitLabel,
}: {
  initial?: Measurement;
  onSubmit: (vals: MeasurementFormValues) => void;
  onCancel: () => void;
  submitLabel: string;
}) {
  const [vals, setVals] = useState<MeasurementFormValues>({
    recorded_at: initial?.recorded_at ?? todayInTehran(),
    weight_kg: initial?.weight_kg != null ? String(initial.weight_kg) : '',
    waist_cm: initial?.waist_cm != null ? String(initial.waist_cm) : '',
    hip_cm: initial?.hip_cm != null ? String(initial.hip_cm) : '',
    chest_cm: initial?.chest_cm != null ? String(initial.chest_cm) : '',
    thigh_cm: initial?.thigh_cm != null ? String(initial.thigh_cm) : '',
    arm_cm: initial?.arm_cm != null ? String(initial.arm_cm) : '',
    notes: initial?.notes ?? '',
  });

  const set = <K extends keyof MeasurementFormValues>(k: K, v: MeasurementFormValues[K]) =>
    setVals((s) => ({ ...s, [k]: v }));

  const numInput = (key: keyof MeasurementFormValues, placeholder: string) => (
    <div className="flex flex-col gap-1.5">
      <label className="text-xs text-gray-500">{placeholder}</label>
      <input
        type="text"
        inputMode="decimal"
        value={String(vals[key])}
        onChange={(e) => set(key, e.target.value.replace(/[^0-9.]/g, '') as MeasurementFormValues[typeof key])}
        placeholder="—"
        dir="ltr"
        className="w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 text-left"
      />
    </div>
  );

  const submit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!vals.recorded_at) return;
    onSubmit(vals);
  };

  return (
    <form onSubmit={submit} className="flex flex-col gap-4">
      <JalaliDatePicker
        label="تاریخ اندازه‌گیری"
        required
        value={vals.recorded_at}
        onChange={(iso) => set('recorded_at', iso)}
      />

      <div className="grid grid-cols-3 gap-3">
        {numInput('weight_kg', 'وزن (kg)')}
        {numInput('waist_cm', 'دور کمر (cm)')}
        {numInput('hip_cm', 'دور باسن (cm)')}
        {numInput('chest_cm', 'دور سینه (cm)')}
        {numInput('thigh_cm', 'دور ران (cm)')}
        {numInput('arm_cm', 'دور بازو (cm)')}
      </div>

      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">یادداشت (اختیاری)</label>
        <textarea
          value={vals.notes}
          onChange={(e) => set('notes', e.target.value)}
          rows={2}
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6"
        />
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
