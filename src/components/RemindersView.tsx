import { useMemo, useState } from 'react';
import { Bell, Loader2, ChevronLeft, Check, Calendar, Ruler, RefreshCw } from 'lucide-react';
import {
  type Reminder,
  type ReminderType,
  type ReminderStatus,
  type Student,
  REMINDER_TYPE_LABELS,
  REMINDER_STATUS_LABELS,
  REMINDER_STATUS_COLORS,
} from '@/lib/supabase';
import { formatJalaliShort } from '@/lib/jalali';

export default function RemindersView({
  reminders,
  students,
  onMarkDone,
  onOpenStudent,
  loading,
}: {
  reminders: Reminder[];
  students: Student[];
  onMarkDone: (id: string) => void;
  onOpenStudent: (studentId: string) => void;
  loading: boolean;
}) {
  const [typeFilter, setTypeFilter] = useState<ReminderType | 'all'>('all');
  const [statusFilter, setStatusFilter] = useState<ReminderStatus | 'all'>('all');

  const today = new Date().toLocaleDateString('en-CA', { timeZone: 'Asia/Tehran' });

  const studentMap = useMemo(() => {
    const m = new Map<string, Student>();
    for (const s of students) m.set(s.id, s);
    return m;
  }, [students]);

  const filtered = useMemo(() => {
    let list = reminders;
    if (typeFilter !== 'all') list = list.filter((r) => r.type === typeFilter);
    if (statusFilter !== 'all') list = list.filter((r) => r.status === statusFilter);
    return [...list].sort((a, b) => a.due_date.localeCompare(b.due_date));
  }, [reminders, typeFilter, statusFilter]);

  const overdue = useMemo(
    () => reminders.filter((r) => r.status === 'pending' && r.due_date < today),
    [reminders, today],
  );
  const todayCount = useMemo(
    () => reminders.filter((r) => r.status === 'pending' && r.due_date === today).length,
    [reminders, today],
  );

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800">یادآورها</h1>
      <p className="text-sm text-gray-500 mt-1">
        {todayCount > 0
          ? `${todayCount} یادآور برای امروز`
          : 'یادآوری برای امروز وجود ندارد'}
        {overdue.length > 0 && ` · ${overdue.length} یادآور عقب‌افتاده`}
      </p>

      {/* Filters */}
      <div className="mt-4 flex items-center gap-2 flex-wrap">
        <span className="text-xs text-gray-400">نوع:</span>
        <Chip label="همه" active={typeFilter === 'all'} onClick={() => setTypeFilter('all')} />
        {(Object.keys(REMINDER_TYPE_LABELS) as ReminderType[]).map((t) => (
          <Chip
            key={t}
            label={REMINDER_TYPE_LABELS[t]}
            active={typeFilter === t}
            onClick={() => setTypeFilter(t)}
          />
        ))}
        <span className="text-xs text-gray-400 mr-3">وضعیت:</span>
        <Chip label="همه" active={statusFilter === 'all'} onClick={() => setStatusFilter('all')} />
        {(Object.keys(REMINDER_STATUS_LABELS) as ReminderStatus[]).map((s) => (
          <Chip
            key={s}
            label={REMINDER_STATUS_LABELS[s]}
            active={statusFilter === s}
            onClick={() => setStatusFilter(s)}
          />
        ))}
      </div>

      {loading ? (
        <div className="flex items-center justify-center py-16 text-gray-400">
          <Loader2 className="animate-spin" size={24} />
        </div>
      ) : filtered.length === 0 ? (
        <div className="mt-4 rounded-2xl border border-dashed border-gray-200 bg-white p-12 text-center">
          <Bell className="mx-auto text-gray-300" size={32} />
          <p className="mt-3 text-sm text-gray-500">یادآوری یافت نشد.</p>
        </div>
      ) : (
        <div className="mt-4 space-y-2">
          {filtered.map((r) => {
            const student = studentMap.get(r.student_id);
            const isOverdue = r.status === 'pending' && r.due_date < today;
            const isToday = r.due_date === today;
            return (
              <div
                key={r.id}
                className={`flex items-center justify-between rounded-2xl border bg-white p-4 shadow-card transition-all ${
                  isOverdue ? 'border-red-200' : isToday ? 'border-amber-200' : 'border-gray-100'
                }`}
              >
                <div className="flex items-center gap-3">
                  <div
                    className={`flex h-10 w-10 items-center justify-center rounded-xl ${
                      r.type === 'measurement'
                        ? 'bg-blue-50 text-blue-700'
                        : 'bg-amber-50 text-amber-700'
                    }`}
                  >
                    {r.type === 'measurement' ? <Ruler size={18} /> : <RefreshCw size={18} />}
                  </div>
                  <div>
                    <button
                      onClick={() => onOpenStudent(r.student_id)}
                      className="text-sm font-semibold text-gray-800 hover:text-brand-700"
                    >
                      {student?.name ?? '—'}
                    </button>
                    <p className="text-xs text-gray-500 mt-0.5">{r.title}</p>
                    {r.detail && (
                      <p className="text-xs text-gray-400 mt-0.5">{r.detail}</p>
                    )}
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <div className="text-left">
                    <div className="flex items-center gap-1 text-xs text-gray-500">
                      <Calendar size={12} />
                      {formatJalaliShort(r.due_date)}
                    </div>
                    {isOverdue && (
                      <span className="text-[10px] text-red-500 font-medium">عقب‌افتاده</span>
                    )}
                    {isToday && r.status === 'pending' && (
                      <span className="text-[10px] text-amber-600 font-medium">امروز</span>
                    )}
                    <span
                      className={`mt-0.5 inline-flex rounded-full px-2 py-0.5 text-[10px] font-medium ${REMINDER_STATUS_COLORS[r.status]}`}
                    >
                      {REMINDER_STATUS_LABELS[r.status]}
                    </span>
                  </div>
                  {r.status === 'pending' && (
                    <button
                      onClick={() => onMarkDone(r.id)}
                      className="flex items-center gap-1 rounded-lg bg-emerald-50 px-3 py-1.5 text-xs font-medium text-emerald-700 hover:bg-emerald-100 transition-colors"
                    >
                      <Check size={14} />
                      انجام شد
                    </button>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}

function Chip({ label, active, onClick }: { label: string; active: boolean; onClick: () => void }) {
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
