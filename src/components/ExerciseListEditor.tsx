import { useMemo, useState } from 'react';
import { Plus, Trash2, Play, ExternalLink, ChevronUp, ChevronDown, Replace, AlertCircle, Calendar, X } from 'lucide-react';
import { type Exercise, getEmbedUrl } from '@/lib/supabase';
import ExercisePicker from './ExercisePicker';

export interface ExerciseAssignment {
  id?: string;
  exercise_id: string;
  exercise_name_fa: string;
  exercise_name_en: string;
  exercise_video_url: string;
  source_template_id: string | null;
  sort_order: number;
  sets: string;
  reps: string;
  rest_seconds: string;
  rpe: string;
  day_label: string;
  coach_notes: string;
}

const DEFAULT_DAY = 'روز ۱';

export default function ExerciseListEditor({
  exercises,
  assignments,
  onChange,
  loading,
}: {
  exercises: Exercise[];
  assignments: ExerciseAssignment[];
  onChange: (a: ExerciseAssignment[]) => void;
  loading: boolean;
}) {
  const [pickerOpen, setPickerOpen] = useState(false);
  const [pickerDay, setPickerDay] = useState<string | null>(null);
  const [replaceIndex, setReplaceIndex] = useState<number | null>(null);

  const handlePick = (ex: Exercise) => {
    const day = pickerDay ?? DEFAULT_DAY;
    const sameDay = assignments.filter((a) => a.day_label === day);
    const newAssignment: ExerciseAssignment = {
      exercise_id: ex.id,
      exercise_name_fa: ex.name_fa,
      exercise_name_en: ex.name_en,
      exercise_video_url: ex.video_url,
      source_template_id: null,
      sort_order: sameDay.length,
      sets: '',
      reps: '',
      rest_seconds: '',
      rpe: '',
      day_label: day,
      coach_notes: '',
    };
    onChange([...assignments, newAssignment]);
    setPickerOpen(false);
    setPickerDay(null);
  };

  const handleReplace = (ex: Exercise) => {
    if (replaceIndex === null) return;
    const updated = [...assignments];
    updated[replaceIndex] = {
      ...updated[replaceIndex],
      exercise_id: ex.id,
      exercise_name_fa: ex.name_fa,
      exercise_name_en: ex.name_en,
      exercise_video_url: ex.video_url,
    };
    onChange(updated);
    setReplaceIndex(null);
  };

  const update = (index: number, field: keyof ExerciseAssignment, value: string) => {
    const updated = [...assignments];
    updated[index] = { ...updated[index], [field]: value };
    onChange(updated);
  };

  const remove = (index: number) => {
    onChange(assignments.filter((_, i) => i !== index));
  };

  const move = (index: number, dir: -1 | 1) => {
    const newIndex = index + dir;
    if (newIndex < 0 || newIndex >= assignments.length) return;
    const updated = [...assignments];
    [updated[index], updated[newIndex]] = [updated[newIndex], updated[index]];
    updated.forEach((a, i) => (a.sort_order = i));
    onChange(updated);
  };

  // Day grouping
  const days = useMemo(() => {
    const daySet: string[] = [];
    for (const a of assignments) {
      if (!daySet.includes(a.day_label)) daySet.push(a.day_label);
    }
    if (daySet.length === 0) daySet.push(DEFAULT_DAY);
    return daySet;
  }, [assignments]);

  const assignmentsByDay = useMemo(() => {
    const map = new Map<string, { assignment: ExerciseAssignment; globalIndex: number }[]>();
    for (let i = 0; i < assignments.length; i++) {
      const a = assignments[i];
      const arr = map.get(a.day_label) ?? [];
      arr.push({ assignment: a, globalIndex: i });
      map.set(a.day_label, arr);
    }
    return map;
  }, [assignments]);

  const addDay = () => {
    const dayNum = days.length + 1;
    const newDay = `روز ${dayNum}`;
    onChange([...assignments, {
      exercise_id: '',
      exercise_name_fa: '',
      exercise_name_en: '',
      exercise_video_url: '',
      source_template_id: null,
      sort_order: 0,
      sets: '',
      reps: '',
      rest_seconds: '',
      rpe: '',
      day_label: newDay,
      coach_notes: '',
    }]);
    // Remove the placeholder immediately — it was just to add the day label
    // Actually we need a different approach: just set pickerDay and open picker
  };

  const openAddForDay = (day: string) => {
    setPickerDay(day);
    setPickerOpen(true);
  };

  const renameDay = (oldName: string, newName: string) => {
    if (!newName.trim() || oldName === newName) return;
    onChange(assignments.map((a) => a.day_label === oldName ? { ...a, day_label: newName.trim() } : a));
  };

  const removeDay = (day: string) => {
    onChange(assignments.filter((a) => a.day_label !== day));
  };

  return (
    <div className="flex flex-col gap-3">
      <div className="flex items-center justify-between">
        <h3 className="text-sm font-semibold text-gray-700">حرکات برنامه</h3>
        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={() => {
              const dayNum = days.length + 1;
              const newDay = `روز ${dayNum}`;
              setPickerDay(newDay);
              setPickerOpen(true);
            }}
            className="flex items-center gap-1.5 rounded-lg bg-gray-100 px-3 py-1.5 text-xs font-medium text-gray-600 hover:bg-gray-200 transition-colors"
          >
            <Calendar size={14} />
            روز جدید
          </button>
          <button
            type="button"
            onClick={() => {
              setPickerDay(days[0]);
              setPickerOpen(true);
            }}
            className="flex items-center gap-1.5 rounded-lg bg-brand-50 px-3 py-1.5 text-xs font-medium text-brand-700 hover:bg-brand-100 transition-colors"
          >
            <Plus size={14} />
            افزودن حرکت
          </button>
        </div>
      </div>

      {pickerOpen && (
        <div className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm">
          <ExercisePicker
            exercises={exercises}
            onPick={handlePick}
            onClose={() => { setPickerOpen(false); setPickerDay(null); }}
            excludeIds={assignments.map((a) => a.exercise_id).filter(Boolean)}
            loading={loading}
          />
        </div>
      )}

      {replaceIndex !== null && (
        <div className="rounded-xl border border-gray-200 bg-white p-4 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <h4 className="text-xs font-semibold text-gray-600">انتخاب حرکت جایگزین</h4>
            <button onClick={() => setReplaceIndex(null)} className="p-1 rounded-lg text-gray-400 hover:text-gray-600 hover:bg-gray-50">
              <X size={16} />
            </button>
          </div>
          <ExercisePicker
            exercises={exercises}
            onPick={handleReplace}
            onClose={() => setReplaceIndex(null)}
            excludeIds={assignments.map((a, i) => i !== replaceIndex ? a.exercise_id : '').filter(Boolean)}
            loading={loading}
          />
        </div>
      )}

      {assignments.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-200 p-6 text-center">
          <p className="text-xs text-gray-400">هنوز حرکتی به این برنامه اضافه نشده است.</p>
        </div>
      ) : (
        <div className="space-y-4">
          {days.map((day) => {
            const dayItems = assignmentsByDay.get(day) ?? [];
            return (
              <DayGroup
                key={day}
                dayLabel={day}
                items={dayItems}
                canRemoveDay={days.length > 1}
                onAddExercise={() => openAddForDay(day)}
                onRenameDay={(newName) => renameDay(day, newName)}
                onRemoveDay={() => removeDay(day)}
                onUpdate={update}
                onRemove={remove}
                onMove={move}
                onReplace={(idx) => setReplaceIndex(idx)}
                totalAssignments={assignments.length}
              />
            );
          })}
        </div>
      )}
    </div>
  );
}

function DayGroup({
  dayLabel,
  items,
  canRemoveDay,
  onAddExercise,
  onRenameDay,
  onRemoveDay,
  onUpdate,
  onRemove,
  onMove,
  onReplace,
  totalAssignments,
}: {
  dayLabel: string;
  items: { assignment: ExerciseAssignment; globalIndex: number }[];
  canRemoveDay: boolean;
  onAddExercise: () => void;
  onRenameDay: (newName: string) => void;
  onRemoveDay: () => void;
  onUpdate: (index: number, field: keyof ExerciseAssignment, value: string) => void;
  onRemove: (index: number) => void;
  onMove: (index: number, dir: -1 | 1) => void;
  onReplace: (index: number) => void;
  totalAssignments: number;
}) {
  const [editing, setEditing] = useState(false);
  const [name, setName] = useState(dayLabel);

  return (
    <div className="rounded-xl border border-gray-200 bg-gray-50/40 p-3">
      <div className="flex items-center justify-between gap-2 mb-2">
        <div className="flex items-center gap-2 flex-1 min-w-0">
          <Calendar size={14} className="text-brand-600 shrink-0" />
          {editing ? (
            <input
              autoFocus
              value={name}
              onChange={(e) => setName(e.target.value)}
              onBlur={() => { onRenameDay(name); setEditing(false); }}
              onKeyDown={(e) => {
                if (e.key === 'Enter') { onRenameDay(name); setEditing(false); }
                if (e.key === 'Escape') { setName(dayLabel); setEditing(false); }
              }}
              className="rounded-lg border border-brand-300 px-2 py-0.5 text-sm font-semibold text-gray-700 outline-none focus:border-brand-500"
            />
          ) : (
            <button
              onClick={() => { setName(dayLabel); setEditing(true); }}
              className="text-sm font-semibold text-gray-700 hover:text-brand-600 transition-colors"
            >
              {dayLabel}
            </button>
          )}
          <span className="text-[10px] text-gray-400">({items.length} حرکت)</span>
        </div>
        <div className="flex items-center gap-1 shrink-0">
          <button
            type="button"
            onClick={onAddExercise}
            className="flex items-center gap-1 rounded-lg bg-brand-50 px-2 py-1 text-[10px] font-medium text-brand-700 hover:bg-brand-100 transition-colors"
          >
            <Plus size={12} />
            حرکت
          </button>
          {canRemoveDay && (
            <button
              type="button"
              onClick={onRemoveDay}
              className="p-1 rounded-lg text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors"
              title="حذف روز"
            >
              <Trash2 size={13} />
            </button>
          )}
        </div>
      </div>

      {items.length === 0 ? (
        <p className="text-xs text-gray-400 py-2 text-center">حرکتی در این روز نیست</p>
      ) : (
        <div className="space-y-2">
          {items.map((item, dayIdx) => (
            <AssignmentRow
              key={item.assignment.exercise_id + item.globalIndex}
              assignment={item.assignment}
              index={item.globalIndex}
              dayIndex={dayIdx}
              dayTotal={items.length}
              total={totalAssignments}
              onUpdate={(field, value) => onUpdate(item.globalIndex, field, value)}
              onRemove={() => onRemove(item.globalIndex)}
              onMove={(dir) => onMove(item.globalIndex, dir)}
              onReplace={() => onReplace(item.globalIndex)}
            />
          ))}
        </div>
      )}
    </div>
  );
}

function AssignmentRow({
  assignment,
  index,
  dayIndex,
  dayTotal,
  total,
  onUpdate,
  onRemove,
  onMove,
  onReplace,
}: {
  assignment: ExerciseAssignment;
  index: number;
  dayIndex: number;
  dayTotal: number;
  total: number;
  onUpdate: (field: keyof ExerciseAssignment, value: string) => void;
  onRemove: () => void;
  onMove: (dir: -1 | 1) => void;
  onReplace: () => void;
}) {
  const [showVideo, setShowVideo] = useState(false);
  const [embedError, setEmbedError] = useState(false);
  const name = assignment.exercise_name_fa || assignment.exercise_name_en || '—';
  const embedUrl = assignment.exercise_video_url ? getEmbedUrl(assignment.exercise_video_url) : null;

  return (
    <div className="rounded-xl border border-gray-100 bg-white p-3">
      <div className="flex items-center justify-between gap-2">
        <div className="flex items-center gap-2 flex-1 min-w-0">
          <div className="flex flex-col">
            <button
              type="button"
              onClick={() => onMove(-1)}
              disabled={index === 0}
              className="p-0.5 text-gray-300 hover:text-gray-600 disabled:opacity-20"
            >
              <ChevronUp size={12} />
            </button>
            <button
              type="button"
              onClick={() => onMove(1)}
              disabled={index === total - 1}
              className="p-0.5 text-gray-300 hover:text-gray-600 disabled:opacity-20"
            >
              <ChevronDown size={12} />
            </button>
          </div>
          <span className="text-xs font-semibold text-gray-700 w-5 text-center">{dayIndex + 1}</span>
          <span className="text-sm font-medium text-gray-800 truncate">{name}</span>
        </div>
        <div className="flex items-center gap-1 shrink-0">
          {assignment.exercise_video_url && (
            <button
              type="button"
              onClick={() => setShowVideo((v) => !v)}
              className="flex items-center gap-1 rounded-lg bg-blue-50 px-2 py-1 text-[10px] font-medium text-blue-700 hover:bg-blue-100 transition-colors"
            >
              <Play size={10} />
              ویدئو
            </button>
          )}
          <button
            type="button"
            onClick={onReplace}
            className="p-1 rounded-lg text-gray-400 hover:text-blue-600 hover:bg-blue-50 transition-colors"
            title="جایگزینی حرکت"
          >
            <Replace size={13} />
          </button>
          <button
            type="button"
            onClick={onRemove}
            className="p-1 rounded-lg text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors"
          >
            <Trash2 size={14} />
          </button>
        </div>
      </div>

      {showVideo && assignment.exercise_video_url && (
        <div className="mt-2">
          {embedUrl && !embedError ? (
            <div>
              <div className="overflow-hidden rounded-lg border border-gray-200" style={{ aspectRatio: '16/9' }}>
                <iframe
                  src={embedUrl}
                  allow="autoplay; fullscreen"
                  className="h-full w-full"
                  title={name}
                  onError={() => setEmbedError(true)}
                />
              </div>
              <a
                href={assignment.exercise_video_url}
                target="_blank"
                rel="noopener noreferrer"
                className="mt-1.5 inline-flex items-center gap-1 text-[10px] text-blue-600 hover:text-blue-700"
              >
                <ExternalLink size={10} />
                باز کردن در تب جدید
              </a>
            </div>
          ) : (
            <div className="rounded-lg border border-amber-200 bg-amber-50/60 p-3 flex items-start gap-2">
              <AlertCircle size={16} className="text-amber-600 shrink-0 mt-0.5" />
              <div className="flex-1">
                <p className="text-xs text-amber-700 leading-6">
                  پخش ویدئو در پنل ممکن است به دلیل محدودیت حریم خصوصی یا مجوز دسترسی میزبان مسدود شده باشد.
                </p>
                <a
                  href={assignment.exercise_video_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="mt-1 inline-flex items-center gap-1 text-xs text-blue-600 hover:text-blue-700 font-medium"
                >
                  <ExternalLink size={12} />
                  باز کردن ویدئو در تب جدید
                </a>
              </div>
            </div>
          )}
        </div>
      )}

      <div className="mt-2 grid grid-cols-4 gap-2">
        <NumField label="ست" value={assignment.sets} onChange={(v) => onUpdate('sets', v)} placeholder="3" />
        <NumField label="تکرار" value={assignment.reps} onChange={(v) => onUpdate('reps', v)} placeholder="10-12" />
        <NumField label="استراحت" value={assignment.rest_seconds} onChange={(v) => onUpdate('rest_seconds', v)} placeholder="60" />
        <NumField label="RPE" value={assignment.rpe} onChange={(v) => onUpdate('rpe', v)} placeholder="7" />
      </div>

      <input
        type="text"
        value={assignment.coach_notes}
        onChange={(e) => onUpdate('coach_notes', e.target.value)}
        placeholder="توضیحات اختصاصی مربی..."
        className="mt-2 w-full rounded-lg border border-gray-200 px-2.5 py-1.5 text-xs outline-none focus:border-brand-500"
      />
    </div>
  );
}

function NumField({
  label,
  value,
  onChange,
  placeholder,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  placeholder: string;
}) {
  return (
    <div className="flex flex-col gap-0.5">
      <span className="text-[9px] text-gray-400 text-center">{label}</span>
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        dir="ltr"
        className="w-full rounded-lg border border-gray-200 px-2 py-1.5 text-xs outline-none focus:border-brand-500 text-center"
      />
    </div>
  );
}
