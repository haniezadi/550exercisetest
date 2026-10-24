import { useMemo, useState } from 'react';
import {
  Inbox,
  ArrowRight,
  Loader2,
  ChevronLeft,
  UserCheck,
  Clock,
  FileText,
} from 'lucide-react';
import { supabase } from '@/lib/supabase';
import {
  type IntakeRequest,
  type RequestStatus,
  REQUEST_STATUS_LABELS,
  REQUEST_STATUS_COLORS,
} from '@/lib/supabase';
import { formatJalaliDateTime } from '@/lib/jalali';
import { FORM_STEPS } from '@/lib/formConfig';

const STATUS_ORDER: RequestStatus[] = [
  'new',
  'reviewing',
  'needs_info',
  'approved',
  'rejected',
  'converted',
];

export default function RequestsView({
  requests,
  loading,
  onRefresh,
}: {
  requests: IntakeRequest[];
  loading: boolean;
  onRefresh: () => void;
}) {
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [filter, setFilter] = useState<RequestStatus | 'all'>('all');

  const selected = useMemo(
    () => requests.find((r) => r.id === selectedId) ?? null,
    [requests, selectedId],
  );

  const filtered = useMemo(() => {
    const list = filter === 'all' ? requests : requests.filter((r) => r.status === filter);
    return [...list].sort(
      (a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime(),
    );
  }, [requests, filter]);

  if (selected) {
    return (
      <RequestDetail
        request={selected}
        onBack={() => setSelectedId(null)}
        onRefresh={onRefresh}
      />
    );
  }

  return (
    <div>
      <Header
        title="درخواست‌های جدید"
        subtitle={`${requests.length} درخواست کل`}
      />

      <div className="mt-4 flex items-center gap-2 flex-wrap">
        <FilterChip label="همه" active={filter === 'all'} onClick={() => setFilter('all')} />
        {STATUS_ORDER.map((s) => (
          <FilterChip
            key={s}
            label={REQUEST_STATUS_LABELS[s]}
            active={filter === s}
            onClick={() => setFilter(s)}
          />
        ))}
      </div>

      {loading ? (
        <div className="flex items-center justify-center py-16 text-gray-400">
          <Loader2 className="animate-spin" size={24} />
        </div>
      ) : filtered.length === 0 ? (
        <div className="mt-4 rounded-2xl border border-dashed border-gray-200 bg-white p-12 text-center">
          <Inbox className="mx-auto text-gray-300" size={32} />
          <p className="mt-3 text-sm text-gray-500">درخواستی یافت نشد.</p>
        </div>
      ) : (
        <div className="mt-4 overflow-hidden rounded-2xl border border-gray-100 bg-white shadow-card">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-gray-100 bg-gray-50/60 text-gray-500 text-xs">
                <th className="px-5 py-3 text-right font-medium">نام</th>
                <th className="px-5 py-3 text-right font-medium">تاریخ ارسال</th>
                <th className="px-5 py-3 text-right font-medium">وضعیت</th>
                <th className="px-5 py-3 text-left font-medium"></th>
              </tr>
            </thead>
            <tbody>
              {filtered.map((r) => {
                const name = String(r.form_data?.name ?? 'بدون نام');
                return (
                  <tr
                    key={r.id}
                    className="border-b border-gray-50 last:border-0 hover:bg-gray-50/50 transition-colors cursor-pointer"
                    onClick={() => setSelectedId(r.id)}
                  >
                    <td className="px-5 py-3.5">
                      <span className="font-medium text-gray-800">{name}</span>
                    </td>
                    <td className="px-5 py-3.5 text-gray-500 text-xs">
                      {formatJalaliDateTime(r.created_at)}
                    </td>
                    <td className="px-5 py-3.5">
                      <span
                        className={`inline-flex rounded-full px-2.5 py-0.5 text-xs font-medium ${REQUEST_STATUS_COLORS[r.status]}`}
                      >
                        {REQUEST_STATUS_LABELS[r.status]}
                      </span>
                    </td>
                    <td className="px-5 py-3.5 text-left">
                      <ChevronLeft size={16} className="text-gray-300 inline" />
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

function FilterChip({ label, active, onClick }: { label: string; active: boolean; onClick: () => void }) {
  return (
    <button
      onClick={onClick}
      className={`rounded-lg px-3 py-1.5 text-xs font-medium transition-colors ${
        active ? 'bg-brand-600 text-white' : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-50'
      }`}
    >
      {label}
    </button>
  );
}

function RequestDetail({
  request,
  onBack,
  onRefresh,
}: {
  request: IntakeRequest;
  onBack: () => void;
  onRefresh: () => void;
}) {
  const [status, setStatus] = useState<RequestStatus>(request.status);
  const [note, setNote] = useState(request.coach_note);
  const [saving, setSaving] = useState(false);
  const [converting, setConverting] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);
  const [err, setErr] = useState<string | null>(null);

  const name = String(request.form_data?.name ?? 'بدون نام');

  const saveStatusAndNote = async () => {
    setSaving(true);
    setErr(null);
    const { error } = await supabase
      .from('intake_requests')
      .update({ status, coach_note: note, updated_at: new Date().toISOString() })
      .eq('id', request.id);
    setSaving(false);
    if (error) {
      setErr('ذخیره ناموفق بود');
      return;
    }
    setMsg('ذخیره شد');
    setTimeout(() => setMsg(null), 2000);
    onRefresh();
  };

  const convertToStudent = async () => {
    setConverting(true);
    setErr(null);
    const fd = request.form_data;
    const studentPayload = {
      name: String(fd?.name ?? '').trim(),
      age: toNumber(fd?.age),
      height_cm: toNumber(fd?.height_cm),
      weight_kg: toNumber(fd?.weight_kg),
      goal: buildGoalString(fd),
      source_request_id: request.id,
    };
    if (!studentPayload.name) {
      setErr('نام در فرم خالی است؛ نمی‌توان پرونده ساخت');
      setConverting(false);
      return;
    }
    const { data: inserted, error: insertErr } = await supabase
      .from('students')
      .insert(studentPayload)
      .select()
      .maybeSingle();
    if (insertErr || !inserted) {
      setErr('ساخت پرونده ناموفق بود');
      setConverting(false);
      return;
    }
    await supabase
      .from('intake_requests')
      .update({
        status: 'converted',
        converted_student_id: inserted.id,
        updated_at: new Date().toISOString(),
      })
      .eq('id', request.id);
    setStatus('converted');
    setConverting(false);
    setMsg('درخواست به پروندهٔ شاگرد تبدیل شد');
    onRefresh();
  };

  const isConverted = status === 'converted';

  return (
    <div>
      <button
        onClick={onBack}
        className="no-print flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-700 mb-4"
      >
        <ArrowRight size={16} className="rotate-180" />
        بازگشت به فهرست درخواست‌ها
      </button>

      <div className="flex items-start justify-between gap-4">
        <div>
          <h1 className="text-xl font-bold text-gray-800">{name}</h1>
          <p className="text-sm text-gray-500 mt-0.5 flex items-center gap-1.5">
            <Clock size={14} />
            {formatJalaliDateTime(request.created_at)}
          </p>
        </div>
        <span
          className={`inline-flex rounded-full px-3 py-1 text-xs font-medium ${REQUEST_STATUS_COLORS[status]}`}
        >
          {REQUEST_STATUS_LABELS[status]}
        </span>
      </div>

      {/* Form answers */}
      <div className="mt-5 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
        <h2 className="text-base font-semibold text-gray-800 mb-4">پاسخ‌های فرم</h2>
        <div className="flex flex-col gap-6">
          {FORM_STEPS.map((step) => (
            <div key={step.id}>
              <h3 className="text-sm font-semibold text-brand-700 mb-2.5 pb-1.5 border-b border-gray-100">
                {step.title}
              </h3>
              <div className="grid grid-cols-2 gap-x-4 gap-y-3">
                {step.fields.map((field) => (
                  <AnswerRow
                    key={field.key}
                    label={field.label}
                    value={request.form_data?.[field.key]}
                  />
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Coach controls */}
      <div className="mt-5 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
        <h2 className="text-base font-semibold text-gray-800 mb-4">مدیریت درخواست</h2>

        {err && (
          <div className="mb-3 rounded-xl border border-red-200 bg-red-50 px-4 py-2.5 text-sm text-red-700">
            {err}
          </div>
        )}
        {msg && (
          <div className="mb-3 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-2.5 text-sm text-emerald-700">
            {msg}
          </div>
        )}

        <div className="flex flex-col gap-4">
          <div className="flex flex-col gap-1.5">
            <label className="text-sm font-medium text-gray-600">وضعیت</label>
            <div className="flex flex-wrap gap-2">
              {STATUS_ORDER.map((s) => (
                <button
                  key={s}
                  onClick={() => !isConverted && setStatus(s)}
                  disabled={isConverted}
                  className={`rounded-lg px-3 py-1.5 text-xs font-medium transition-colors ${
                    status === s
                      ? 'bg-brand-600 text-white'
                      : 'bg-gray-100 text-gray-600 hover:bg-gray-200 disabled:opacity-50'
                  } ${isConverted ? 'cursor-not-allowed' : ''}`}
                >
                  {REQUEST_STATUS_LABELS[s]}
                </button>
              ))}
            </div>
          </div>

          <div className="flex flex-col gap-1.5">
            <label className="text-sm font-medium text-gray-600">یادداشت داخلی مربی</label>
            <textarea
              value={note}
              onChange={(e) => setNote(e.target.value)}
              disabled={isConverted}
              rows={3}
              placeholder="یادداشت خصوصی دربارهٔ این درخواست..."
              className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6 disabled:bg-gray-50"
            />
          </div>

          <div className="flex items-center gap-2 pt-1">
            <button
              onClick={saveStatusAndNote}
              disabled={saving || isConverted}
              className="flex items-center gap-1.5 rounded-xl bg-brand-600 px-4 py-2.5 text-sm font-medium text-white hover:bg-brand-700 transition-colors disabled:opacity-50"
            >
              {saving ? <Loader2 size={15} className="animate-spin" /> : <FileText size={15} />}
              ذخیره وضعیت و یادداشت
            </button>
            {!isConverted && (
              <button
                onClick={convertToStudent}
                disabled={converting}
                className="flex items-center gap-1.5 rounded-xl bg-emerald-600 px-4 py-2.5 text-sm font-medium text-white hover:bg-emerald-700 transition-colors disabled:opacity-50"
              >
                {converting ? <Loader2 size={15} className="animate-spin" /> : <UserCheck size={15} />}
                تبدیل به پروندهٔ شاگرد
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

function AnswerRow({ label, value }: { label: string; value: unknown }) {
  let display: string;
  if (Array.isArray(value)) {
    display = value.length ? value.join('، ') : '—';
  } else if (value == null || value === '') {
    display = '—';
  } else {
    display = String(value);
  }
  return (
    <div>
      <p className="text-xs text-gray-400">{label}</p>
      <p className="text-sm text-gray-800 mt-0.5 leading-6">{display}</p>
    </div>
  );
}

function Header({ title, subtitle }: { title: string; subtitle?: string }) {
  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800">{title}</h1>
      {subtitle && <p className="text-sm text-gray-500 mt-1">{subtitle}</p>}
    </div>
  );
}

function toNumber(v: unknown): number | null {
  if (v == null || v === '') return null;
  const n = Number(String(v).replace(/[^0-9.]/g, ''));
  return isNaN(n) ? null : n;
}

function buildGoalString(fd: Record<string, unknown> | undefined): string | null {
  const goal = fd?.primary_goal ? String(fd.primary_goal) : '';
  const target = fd?.target_weight_kg ? ` (هدف وزن: ${fd.target_weight_kg} kg)` : '';
  const timeframe = fd?.timeframe && fd.timeframe !== 'نمی‌دانم' ? ` - ${fd.timeframe}` : '';
  const combined = `${goal}${target}${timeframe}`.trim();
  return combined || null;
}
