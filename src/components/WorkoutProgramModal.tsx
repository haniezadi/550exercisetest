import { useEffect, useState } from 'react';
import { Dumbbell, Check } from 'lucide-react';
import type { Template, Exercise, TemplateExercise } from '@/lib/supabase';
import ExerciseListEditor, { type ExerciseAssignment } from './ExerciseListEditor';

export interface WorkoutSaveData {
  customName: string;
  assignments: ExerciseAssignment[];
}

export default function WorkoutProgramModal({
  open,
  templates,
  templateExercises,
  exercises,
  existingAssignments,
  existingCustomName,
  onSave,
  onClose,
  saving,
}: {
  open: boolean;
  templates: Template[];
  templateExercises: TemplateExercise[];
  exercises: Exercise[];
  existingAssignments: ExerciseAssignment[];
  existingCustomName: string;
  onSave: (data: WorkoutSaveData) => void;
  onClose: () => void;
  saving: boolean;
}) {
  const [selectedTemplateIds, setSelectedTemplateIds] = useState<string[]>([]);
  const [customName, setCustomName] = useState('');
  const [assignments, setAssignments] = useState<ExerciseAssignment[]>([]);

  useEffect(() => {
    if (open) {
      setCustomName(existingCustomName);
      setAssignments(existingAssignments);
      // Derive selected templates from the source_template_id tags
      const ids = new Set<string>();
      for (const a of existingAssignments) {
        if (a.source_template_id) ids.add(a.source_template_id);
      }
      setSelectedTemplateIds([...ids]);
    }
  }, [open, existingCustomName, existingAssignments]);

  const toggleTemplate = (templateId: string) => {
    setSelectedTemplateIds((prev) => {
      const isSelected = prev.includes(templateId);
      setAssignments((current) => {
        if (isSelected) {
          // Deselecting: remove only assignments sourced from this template
          return current.filter((a) => a.source_template_id !== templateId);
        }
        // Selecting: copy template exercises, tagged with source_template_id
        const tExercises = templateExercises
          .filter((te) => te.template_id === templateId)
          .sort((a, b) => a.sort_order - b.sort_order);
        if (tExercises.length === 0) return current;
        const newOnes: ExerciseAssignment[] = tExercises.map((te) => {
          const ex = exercises.find((e) => e.id === te.exercise_id);
          return {
            exercise_id: te.exercise_id,
            exercise_name_fa: ex?.name_fa ?? '',
            exercise_name_en: ex?.name_en ?? '',
            exercise_video_url: ex?.video_url ?? '',
            source_template_id: templateId,
            sort_order: te.sort_order,
            sets: te.sets != null ? String(te.sets) : '',
            reps: te.reps,
            rest_seconds: te.rest_seconds != null ? String(te.rest_seconds) : '',
            rpe: te.rpe != null ? String(te.rpe) : '',
            day_label: te.day_label || 'روز ۱',
            coach_notes: te.coach_notes,
          };
        });
        return [...current, ...newOnes];
      });
      return isSelected ? prev.filter((id) => id !== templateId) : [...prev, templateId];
    });
  };

  const handleSave = () => {
    onSave({ customName: customName.trim(), assignments });
  };

  if (!open) return null;

  return (
    <div className="flex flex-col gap-4">
      <div className="flex items-center gap-2">
        <Dumbbell size={18} className="text-brand-600" />
        <h3 className="text-sm font-semibold text-gray-800">برنامه تمرینی</h3>
      </div>

      {/* Template selector — multi-select */}
      <div>
        <label className="text-xs font-medium text-gray-500 mb-2 block">افزودن از قالب‌های آماده</label>
        {templates.length === 0 ? (
          <p className="text-xs text-gray-400 rounded-lg bg-gray-50 p-3">قالب تمرینی موجود نیست.</p>
        ) : (
          <div className="space-y-2">
            {templates.map((t) => {
              const selected = selectedTemplateIds.includes(t.id);
              const count = templateExercises.filter((te) => te.template_id === t.id).length;
              return (
                <button
                  key={t.id}
                  type="button"
                  onClick={() => toggleTemplate(t.id)}
                  className={`w-full text-right rounded-xl border p-3 transition-all ${
                    selected
                      ? 'border-brand-500 bg-brand-50 ring-2 ring-brand-100'
                      : 'border-gray-200 bg-white hover:border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <div className="flex items-start justify-between gap-2">
                    <h4 className="text-sm font-semibold text-gray-800">{t.name}</h4>
                    <span
                      className={`mt-0.5 flex h-4 w-4 shrink-0 items-center justify-center rounded-md border-2 ${
                        selected ? 'border-brand-600 bg-brand-600 text-white' : 'border-gray-300'
                      }`}
                    >
                      {selected && <Check size={10} />}
                    </span>
                  </div>
                  {t.description && (
                    <p className="mt-1 text-xs leading-6 text-gray-500">{t.description}</p>
                  )}
                  {count > 0 && (
                    <span className="mt-1.5 inline-flex items-center gap-1 text-[10px] text-brand-600">
                      <Check size={10} />
                      {count} حرکت ساختارمند
                    </span>
                  )}
                </button>
              );
            })}
          </div>
        )}
        <p className="mt-1.5 text-[10px] text-gray-400 leading-5">
          هر قالب یک کپی از حرکاتش را در برنامه شاگرد می‌گذارد. برداشتن تیک یک قالب فقط حرکات همان قالب را حذف می‌کند و حرکات دستی یا قالب‌های دیگر دست‌نخورده باقی می‌مانند. تغییرات برنامه شاگرد روی قالب اصلی اثر نمی‌گذارد.
        </p>
      </div>

      {/* Custom name */}
      <div>
        <label className="text-xs font-medium text-gray-500 mb-1.5 block">نام برنامه (اختیاری)</label>
        <input
          type="text"
          value={customName}
          onChange={(e) => setCustomName(e.target.value)}
          placeholder="مثال: برنامه اختصاصی - هفته ۱"
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
        />
      </div>

      {/* Exercise editor */}
      <div className="border-t border-gray-100 pt-4">
        <ExerciseListEditor
          exercises={exercises}
          assignments={assignments}
          onChange={setAssignments}
          loading={false}
        />
      </div>

      {/* Actions */}
      <div className="flex justify-start gap-2 pt-2 border-t border-gray-100">
        <button
          type="button"
          onClick={handleSave}
          disabled={saving}
          className="px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 transition-colors disabled:opacity-50"
        >
          {saving ? 'در حال ذخیره...' : 'ذخیره برنامه تمرینی'}
        </button>
        <button
          type="button"
          onClick={onClose}
          className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200 transition-colors"
        >
          انصراف
        </button>
      </div>
    </div>
  );
}
