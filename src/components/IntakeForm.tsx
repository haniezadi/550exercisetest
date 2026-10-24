import { useMemo, useState } from 'react';
import { ArrowRight, ArrowLeft, Check, Loader2, Dumbbell } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import {
  FORM_STEPS,
  UNKNOWN_VALUE,
  createEmptyFormValues,
  type FieldDef,
} from '@/lib/formConfig';

export default function IntakeForm() {
  const [stepIndex, setStepIndex] = useState(0);
  const [values, setValues] = useState<Record<string, unknown>>(createEmptyFormValues);
  const [submitting, setSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const step = FORM_STEPS[stepIndex];
  const isLast = stepIndex === FORM_STEPS.length - 1;
  const progress = Math.round(((stepIndex + 1) / FORM_STEPS.length) * 100);

  const setField = (key: string, value: unknown) => {
    setValues((v) => ({ ...v, [key]: value }));
  };

  const validateStep = (): boolean => {
    for (const field of step.fields) {
      if (!field.required) continue;
      const val = values[field.key];
      if (field.type === 'multiselect') {
        if (!Array.isArray(val) || val.length === 0) return false;
      } else if (!val || (typeof val === 'string' && !val.trim())) {
        return false;
      }
    }
    return true;
  };

  const next = () => {
    if (!validateStep()) {
      setError('لطفاً بخش‌های الزامی را پر کنید');
      return;
    }
    setError(null);
    if (isLast) {
      void submit();
    } else {
      setStepIndex((i) => Math.min(i + 1, FORM_STEPS.length - 1));
    }
  };

  const back = () => {
    setError(null);
    setStepIndex((i) => Math.max(i - 1, 0));
  };

  const submit = async () => {
    setSubmitting(true);
    setError(null);
    const { error: insertErr } = await supabase.from('intake_requests').insert({
      status: 'new',
      form_data: values,
    });
    setSubmitting(false);
    if (insertErr) {
      setError('ارسال فرم ناموفق بود. لطفاً دوباره تلاش کنید.');
      return;
    }
    setSubmitted(true);
  };

  if (submitted) {
    return (
      <div className="min-h-screen bg-[#f6f7f9] flex items-center justify-center p-4" dir="rtl">
        <div className="max-w-md w-full bg-white rounded-2xl shadow-card p-8 text-center">
          <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-brand-50 text-brand-600">
            <Check size={32} />
          </div>
          <h1 className="mt-5 text-xl font-bold text-gray-800">فرم شما ارسال شد</h1>
          <p className="mt-2 text-sm text-gray-500 leading-7">
            درخواست شما با موفقیت ثبت شد. مربی شما پس از بررسی اطلاعات با شما تماس
            خواهد گرفت.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#f6f7f9]" dir="rtl">
      {/* Header */}
      <header className="bg-white border-b border-gray-100">
        <div className="mx-auto max-w-xl px-4 py-4 flex items-center gap-2.5">
          <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-brand-600 text-white">
            <Dumbbell size={18} />
          </div>
          <div>
            <h1 className="text-sm font-bold text-gray-800">فرم اطلاعات شاگرد</h1>
            <p className="text-[11px] text-gray-400">پنل طراحی برنامه هانی ایزدی</p>
          </div>
        </div>
        {/* Progress bar */}
        <div className="h-1 bg-gray-100">
          <div
            className="h-full bg-brand-500 transition-all duration-300"
            style={{ width: `${progress}%` }}
          />
        </div>
      </header>

      <main className="mx-auto max-w-xl px-4 py-6">
        {/* Step indicator */}
        <div className="flex items-center justify-between mb-5">
          <div>
            <h2 className="text-lg font-bold text-gray-800">{step.title}</h2>
            <p className="text-sm text-gray-500 mt-0.5">{step.subtitle}</p>
          </div>
          <span className="text-xs font-medium text-gray-400 shrink-0">
            مرحلهٔ {stepIndex + 1} از {FORM_STEPS.length}
          </span>
        </div>

        {error && (
          <div className="mb-4 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
            {error}
          </div>
        )}

        <div className="bg-white rounded-2xl border border-gray-100 shadow-card p-5 flex flex-col gap-4">
          {step.fields.map((field) => (
            <FieldRenderer
              key={field.key}
              field={field}
              value={values[field.key]}
              onChange={(v) => setField(field.key, v)}
            />
          ))}
        </div>

        {/* Navigation */}
        <div className="mt-5 flex items-center justify-between gap-3">
          <button
            onClick={back}
            disabled={stepIndex === 0}
            className="flex items-center gap-1.5 rounded-xl bg-gray-100 px-4 py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-200 transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
          >
            <ArrowRight size={16} />
            قبلی
          </button>
          <button
            onClick={next}
            disabled={submitting}
            className="flex items-center gap-1.5 rounded-xl bg-brand-600 px-5 py-2.5 text-sm font-medium text-white hover:bg-brand-700 transition-colors disabled:opacity-50"
          >
            {submitting ? (
              <Loader2 size={16} className="animate-spin" />
            ) : isLast ? (
              <Check size={16} />
            ) : (
              <ArrowLeft size={16} />
            )}
            {submitting ? 'در حال ارسال...' : isLast ? 'ارسال فرم' : 'بعدی'}
          </button>
        </div>
      </main>
    </div>
  );
}

function FieldRenderer({
  field,
  value,
  onChange,
}: {
  field: FieldDef;
  value: unknown;
  onChange: (v: unknown) => void;
}) {
  const requiredMark = field.required ? ' *' : '';

  if (field.type === 'text' || field.type === 'number') {
    return (
      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">
          {field.label}
          {requiredMark}
          {field.unit && <span className="text-gray-400 text-xs mr-1">({field.unit})</span>}
        </label>
        <input
          type={field.type === 'number' ? 'tel' : 'text'}
          inputMode={field.type === 'number' ? 'numeric' : undefined}
          value={String(value ?? '')}
          onChange={(e) => {
            const raw = e.target.value;
            if (field.type === 'number') {
              const digits = raw.replace(/[^0-9.]/g, '');
              onChange(digits);
            } else {
              onChange(raw);
            }
          }}
          placeholder={field.placeholder ?? ''}
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
        />
        {field.allowUnknown && (
          <UnknownToggle
            active={value === UNKNOWN_VALUE}
            onToggle={() => onChange(value === UNKNOWN_VALUE ? '' : UNKNOWN_VALUE)}
          />
        )}
      </div>
    );
  }

  if (field.type === 'textarea') {
    return (
      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">
          {field.label}
          {requiredMark}
        </label>
        <textarea
          value={String(value ?? '')}
          onChange={(e) => onChange(e.target.value)}
          placeholder={field.placeholder ?? ''}
          rows={3}
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6"
        />
        {field.allowUnknown && (
          <UnknownToggle
            active={value === UNKNOWN_VALUE}
            onToggle={() => onChange(value === UNKNOWN_VALUE ? '' : UNKNOWN_VALUE)}
          />
        )}
      </div>
    );
  }

  if (field.type === 'select') {
    const options = field.allowUnknown ? [...(field.options ?? []), UNKNOWN_VALUE] : field.options ?? [];
    return (
      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">
          {field.label}
          {requiredMark}
        </label>
        <div className="grid grid-cols-2 gap-2">
          {options.map((opt) => {
            const selected = value === opt;
            return (
              <button
                key={opt}
                type="button"
                onClick={() => onChange(selected ? '' : opt)}
                className={`text-right rounded-xl border px-3.5 py-2.5 text-sm transition-all ${
                  selected
                    ? 'border-brand-500 bg-brand-50 text-brand-700 font-medium ring-2 ring-brand-100'
                    : 'border-gray-200 bg-white text-gray-700 hover:border-gray-300 hover:bg-gray-50'
                }`}
              >
                {opt}
              </button>
            );
          })}
        </div>
      </div>
    );
  }

  if (field.type === 'multiselect') {
    const arr = Array.isArray(value) ? (value as string[]) : [];
    const toggle = (opt: string) => {
      if (opt === 'هیچ‌کدام') {
        onChange(arr.includes('هیچ‌کدام') ? [] : ['هیچ‌کدام']);
        return;
      }
      const without = arr.filter((o) => o !== 'هیچ‌کدام' && o !== opt);
      if (arr.includes(opt)) {
        onChange(without);
      } else {
        onChange([...without, opt]);
      }
    };
    return (
      <div className="flex flex-col gap-1.5">
        <label className="text-sm font-medium text-gray-600">
          {field.label}
          {requiredMark}
        </label>
        <div className="grid grid-cols-2 gap-2">
          {field.options?.map((opt) => {
            const selected = arr.includes(opt);
            return (
              <button
                key={opt}
                type="button"
                onClick={() => toggle(opt)}
                className={`text-right rounded-xl border px-3.5 py-2.5 text-sm transition-all ${
                  selected
                    ? 'border-brand-500 bg-brand-50 text-brand-700 font-medium ring-2 ring-brand-100'
                    : 'border-gray-200 bg-white text-gray-700 hover:border-gray-300 hover:bg-gray-50'
                }`}
              >
                {opt}
              </button>
            );
          })}
        </div>
      </div>
    );
  }

  return null;
}

function UnknownToggle({ active, onToggle }: { active: boolean; onToggle: () => void }) {
  return (
    <button
      type="button"
      onClick={onToggle}
      className={`self-start text-xs rounded-lg px-2.5 py-1 transition-colors ${
        active
          ? 'bg-gray-200 text-gray-600 font-medium'
          : 'text-gray-400 hover:text-gray-600 hover:bg-gray-100'
      }`}
    >
      {active ? '✓ در حال حاضر مشخص نیست' : 'در حال حاضر مشخص نیست'}
    </button>
  );
}
