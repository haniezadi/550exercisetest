import { useEffect, useState } from 'react';
import type { Student } from '@/lib/supabase';
import JalaliDatePicker from './JalaliDatePicker';

export interface StudentFormValues {
  name: string;
  age: string;
  height_cm: string;
  weight_kg: string;
  goal: string;
  phone: string;
  birth_date: string; // ISO YYYY-MM-DD or ''
  coach_notes: string;
}

interface StudentFormProps {
  initial?: Partial<Student>;
  onSubmit: (values: StudentFormValues) => void;
  onCancel: () => void;
  submitLabel?: string;
}

const empty: StudentFormValues = {
  name: '',
  age: '',
  height_cm: '',
  weight_kg: '',
  goal: '',
  phone: '',
  birth_date: '',
  coach_notes: '',
};

export default function StudentForm({
  initial,
  onSubmit,
  onCancel,
  submitLabel = 'ذخیره',
}: StudentFormProps) {
  const [values, setValues] = useState<StudentFormValues>(empty);
  const [errors, setErrors] = useState<Partial<Record<keyof StudentFormValues, string>>>({});

  useEffect(() => {
    if (initial) {
      setValues({
        name: initial.name ?? '',
        age: initial.age != null ? String(initial.age) : '',
        height_cm: initial.height_cm != null ? String(initial.height_cm) : '',
        weight_kg: initial.weight_kg != null ? String(initial.weight_kg) : '',
        goal: initial.goal ?? '',
        phone: initial.phone ?? '',
        birth_date: initial.birth_date ?? '',
        coach_notes: initial.coach_notes ?? '',
      });
    } else {
      setValues(empty);
    }
    setErrors({});
  }, [initial]);

  const set = (key: keyof StudentFormValues, value: string) => {
    setValues((v) => ({ ...v, [key]: value }));
    setErrors((e) => ({ ...e, [key]: undefined }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const errs: typeof errors = {};
    if (!values.name.trim()) errs.name = 'نام الزامی است';
    if (values.age && (isNaN(+values.age) || +values.age <= 0)) errs.age = 'سن نامعتبر است';
    if (values.height_cm && (isNaN(+values.height_cm) || +values.height_cm <= 0))
      errs.height_cm = 'قد نامعتبر است';
    if (values.weight_kg && (isNaN(+values.weight_kg) || +values.weight_kg <= 0))
      errs.weight_kg = 'وزن نامعتبر است';
    if (Object.keys(errs).length) {
      setErrors(errs);
      return;
    }
    onSubmit(values);
  };

  const field = (
    key: keyof StudentFormValues,
    label: string,
    type: string = 'text',
    placeholder?: string,
  ) => (
    <div className="flex flex-col gap-1.5">
      <label className="text-sm font-medium text-gray-600">{label}</label>
      <input
        type={type}
        value={values[key]}
        onChange={(e) => set(key, e.target.value)}
        placeholder={placeholder}
        className={`w-full rounded-xl border px-3.5 py-2.5 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100 ${
          errors[key] ? 'border-red-300 bg-red-50/40' : 'border-gray-200'
        }`}
      />
      {errors[key] && <span className="text-xs text-red-500">{errors[key]}</span>}
    </div>
  );

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-4">
      {field('name', 'نام و نام خانوادگی', 'text', 'مثال: سارا محمدی')}
      <div className="grid grid-cols-2 gap-3">
        {field('phone', 'شماره تماس', 'text', '۰۹۱۲...')}
        <JalaliDatePicker
          label="تاریخ تولد"
          value={values.birth_date}
          onChange={(iso) => set('birth_date', iso)}
          placeholder="۱۴۰۵/۰۷/۲۸"
        />
      </div>
      <div className="grid grid-cols-3 gap-3">
        {field('age', 'سن', 'number', '28')}
        {field('height_cm', 'قد (cm)', 'number', '165')}
        {field('weight_kg', 'وزن (kg)', 'number', '78')}
      </div>
      {field('goal', 'هدف', 'text', 'مثال: کاهش ۸ کیلوگرم در ۳ ماه')}

      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">یادداشت داخلی مربی</label>
        <textarea
          value={values.coach_notes}
          onChange={(e) => set('coach_notes', e.target.value)}
          placeholder="یادداشت‌های داخلی — این بخش به شاگرد نمایش داده نمی‌شود."
          rows={3}
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6"
        />
      </div>

      <div className="flex justify-start gap-2 pt-2">
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
