import { useState } from 'react';
import { PLAN_TYPE_LABELS, PAYMENT_STATUS_LABELS, type PlanType, type PaymentStatus, type StudentPlan } from '@/lib/supabase';
import JalaliDatePicker from './JalaliDatePicker';

export interface PlanFormValues {
  plan_type: PlanType;
  custom_type_label: string;
  start_date: string;
  end_date: string;
  amount: string;
  payment_status: PaymentStatus;
  notes: string;
}

export default function PlanForm({
  initial,
  onSubmit,
  onCancel,
  submitLabel,
}: {
  initial?: StudentPlan;
  onSubmit: (vals: PlanFormValues) => void;
  onCancel: () => void;
  submitLabel: string;
}) {
  const [vals, setVals] = useState<PlanFormValues>({
    plan_type: initial?.plan_type ?? 'workout_diet',
    custom_type_label: initial?.custom_type_label ?? '',
    start_date: initial?.start_date ?? '',
    end_date: initial?.end_date ?? '',
    amount: initial ? String(initial.amount) : '',
    payment_status: initial?.payment_status ?? 'unpaid',
    notes: initial?.notes ?? '',
  });

  const set = <K extends keyof PlanFormValues>(k: K, v: PlanFormValues[K]) =>
    setVals((s) => ({ ...s, [k]: v }));

  const submit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!vals.start_date || !vals.end_date) return;
    onSubmit(vals);
  };

  return (
    <form onSubmit={submit} className="flex flex-col gap-4">
      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">نوع پلن</label>
        <div className="grid grid-cols-3 gap-2">
          {(Object.keys(PLAN_TYPE_LABELS) as PlanType[]).map((t) => (
            <button
              key={t}
              type="button"
              onClick={() => set('plan_type', t)}
              className={`rounded-lg border px-3 py-2 text-xs font-medium transition-all ${
                vals.plan_type === t
                  ? 'border-brand-500 bg-brand-50 text-brand-700 ring-2 ring-brand-100'
                  : 'border-gray-200 bg-white text-gray-600 hover:bg-gray-50'
              }`}
            >
              {PLAN_TYPE_LABELS[t]}
            </button>
          ))}
        </div>
        {vals.plan_type === 'custom' && (
          <input
            type="text"
            value={vals.custom_type_label}
            onChange={(e) => set('custom_type_label', e.target.value)}
            placeholder="نام پلن سفارشی..."
            className="mt-1 w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
          />
        )}
      </div>

      <div className="grid grid-cols-2 gap-3">
        <JalaliDatePicker
          label="تاریخ شروع"
          required
          value={vals.start_date}
          onChange={(iso) => set('start_date', iso)}
        />
        <JalaliDatePicker
          label="تاریخ پایان"
          required
          value={vals.end_date}
          onChange={(iso) => set('end_date', iso)}
        />
      </div>

      <div className="grid grid-cols-2 gap-3">
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-medium text-gray-600">مبلغ (تومان)</label>
          <input
            type="text"
            inputMode="numeric"
            value={vals.amount}
            onChange={(e) => set('amount', e.target.value.replace(/[^0-9]/g, ''))}
            placeholder="0"
            dir="ltr"
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 text-left"
          />
        </div>
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-medium text-gray-600">وضعیت پرداخت</label>
          <div className="flex gap-1.5">
            {(Object.keys(PAYMENT_STATUS_LABELS) as PaymentStatus[]).map((s) => (
              <button
                key={s}
                type="button"
                onClick={() => set('payment_status', s)}
                className={`flex-1 rounded-lg border px-2 py-2 text-xs font-medium transition-all ${
                  vals.payment_status === s
                    ? 'border-brand-500 bg-brand-50 text-brand-700'
                    : 'border-gray-200 bg-white text-gray-600 hover:bg-gray-50'
                }`}
              >
                {PAYMENT_STATUS_LABELS[s]}
              </button>
            ))}
          </div>
        </div>
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
