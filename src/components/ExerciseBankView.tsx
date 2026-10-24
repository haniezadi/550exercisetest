import { useMemo, useState } from 'react';
import { Search, Star, Pencil, Trash2, Plus, Dumbbell, Loader2, ExternalLink, Play } from 'lucide-react';
import {
  type Exercise,
  type ExerciseType,
  type ExerciseDifficulty,
  type ExerciseLocation,
  EXERCISE_TYPE_LABELS,
  EXERCISE_TYPE_COLORS,
  EXERCISE_DIFFICULTY_LABELS,
  EXERCISE_DIFFICULTY_COLORS,
  EXERCISE_LOCATION_LABELS,
  MUSCLE_OPTIONS,
  EQUIPMENT_OPTIONS,
  formatExerciseName,
  getEmbedUrl,
} from '@/lib/supabase';

export default function ExerciseBankView({
  exercises,
  onAdd,
  onEdit,
  onDelete,
  onToggleFavorite,
  onView,
  loading,
}: {
  exercises: Exercise[];
  onAdd: () => void;
  onEdit: (e: Exercise) => void;
  onDelete: (e: Exercise) => void;
  onToggleFavorite: (e: Exercise) => void;
  onView: (e: Exercise) => void;
  loading: boolean;
}) {
  const [query, setQuery] = useState('');
  const [typeFilter, setTypeFilter] = useState<ExerciseType | 'all'>('all');
  const [difficultyFilter, setDifficultyFilter] = useState<ExerciseDifficulty | 'all'>('all');
  const [muscleFilter, setMuscleFilter] = useState<string>('all');
  const [equipmentFilter, setEquipmentFilter] = useState<string>('all');
  const [showFavoritesOnly, setShowFavoritesOnly] = useState(false);

  const filtered = useMemo(() => {
    let list = exercises.filter((e) => e.is_active);
    if (showFavoritesOnly) list = list.filter((e) => e.is_favorite);
    if (typeFilter !== 'all') list = list.filter((e) => e.exercise_type === typeFilter);
    if (difficultyFilter !== 'all') list = list.filter((e) => e.difficulty === difficultyFilter);
    if (muscleFilter !== 'all') list = list.filter((e) => e.primary_muscles.includes(muscleFilter) || e.secondary_muscles.includes(muscleFilter));
    if (equipmentFilter !== 'all') list = list.filter((e) => e.equipment.includes(equipmentFilter));
    const q = query.trim().toLowerCase();
    if (q) {
      list = list.filter((e) =>
        e.name_fa.toLowerCase().includes(q) ||
        e.name_en.toLowerCase().includes(q) ||
        e.tags.some((t) => t.toLowerCase().includes(q)),
      );
    }
    return [...list].sort((a, b) => {
      if (a.is_favorite !== b.is_favorite) return a.is_favorite ? -1 : 1;
      return (a.name_fa || a.name_en).localeCompare(b.name_fa || b.name_en, 'fa');
    });
  }, [exercises, query, typeFilter, difficultyFilter, muscleFilter, equipmentFilter, showFavoritesOnly]);

  return (
    <div>
      <div className="flex items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">بانک حرکات</h1>
          <p className="text-sm text-gray-500 mt-1">{exercises.filter((e) => e.is_active).length} حرکت ثبت‌شده</p>
        </div>
        <button
          onClick={onAdd}
          className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-white text-sm font-medium hover:bg-brand-700 transition-colors shadow-sm"
        >
          <Plus size={18} />
          حرکت جدید
        </button>
      </div>

      {/* Search + Filters */}
      <div className="mt-5 space-y-3">
        <div className="relative">
          <Search size={18} className="absolute right-3.5 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="جست‌وجو بر اساس نام فارسی یا انگلیسی..."
            className="w-full rounded-xl border border-gray-200 bg-white py-2.5 pr-11 pl-4 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
          />
        </div>

        <div className="flex items-center gap-2 flex-wrap">
          <FilterChips
            label="نوع"
            value={typeFilter}
            onChange={(v) => setTypeFilter(v as ExerciseType | 'all')}
            options={[['all', 'همه'], ...Object.entries(EXERCISE_TYPE_LABELS)]}
          />
          <FilterChips
            label="سطح"
            value={difficultyFilter}
            onChange={(v) => setDifficultyFilter(v as ExerciseDifficulty | 'all')}
            options={[['all', 'همه'], ...Object.entries(EXERCISE_DIFFICULTY_LABELS)]}
          />
          <FilterChips
            label="عضله"
            value={muscleFilter}
            onChange={setMuscleFilter}
            options={[['all', 'همه'], ...MUSCLE_OPTIONS.map((m) => [m, m] as [string, string])]}
          />
          <FilterChips
            label="تجهیزات"
            value={equipmentFilter}
            onChange={setEquipmentFilter}
            options={[['all', 'همه'], ...EQUIPMENT_OPTIONS.map((eq) => [eq, eq] as [string, string])]}
          />
          <button
            onClick={() => setShowFavoritesOnly((v) => !v)}
            className={`flex items-center gap-1.5 rounded-lg px-3 py-1.5 text-xs font-medium transition-colors ${
              showFavoritesOnly ? 'bg-amber-100 text-amber-700' : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-50'
            }`}
          >
            <Star size={14} className={showFavoritesOnly ? 'fill-amber-500 text-amber-500' : ''} />
            پرکاربرد
          </button>
        </div>
      </div>

      {loading ? (
        <div className="flex items-center justify-center py-16 text-gray-400">
          <Loader2 className="animate-spin" size={24} />
        </div>
      ) : filtered.length === 0 ? (
        <div className="mt-4 rounded-2xl border border-dashed border-gray-200 bg-white p-12 text-center">
          <Dumbbell className="mx-auto text-gray-300" size={32} />
          <p className="mt-3 text-sm text-gray-500">
            {query || typeFilter !== 'all' || difficultyFilter !== 'all' || muscleFilter !== 'all' || equipmentFilter !== 'all'
              ? 'حرکتی با این فیلترها یافت نشد.'
              : 'هنوز حرکتی ثبت نشده است.'}
          </p>
        </div>
      ) : (
        <div className="mt-4 grid grid-cols-2 gap-3">
          {filtered.map((e) => (
            <ExerciseCard
              key={e.id}
              exercise={e}
              onView={() => onView(e)}
              onEdit={() => onEdit(e)}
              onDelete={() => onDelete(e)}
              onToggleFavorite={() => onToggleFavorite(e)}
            />
          ))}
        </div>
      )}
    </div>
  );
}

function ExerciseCard({
  exercise,
  onView,
  onEdit,
  onDelete,
  onToggleFavorite,
}: {
  exercise: Exercise;
  onView: () => void;
  onEdit: () => void;
  onDelete: () => void;
  onToggleFavorite: () => void;
}) {
  const embedUrl = exercise.video_url ? getEmbedUrl(exercise.video_url) : null;

  return (
    <div className="rounded-2xl border border-gray-100 bg-white p-4 shadow-card hover:shadow-cardHover transition-all">
      <div className="flex items-start justify-between gap-2">
        <button onClick={onView} className="text-right flex-1 min-w-0">
          <h3 className="text-sm font-semibold text-gray-800 truncate hover:text-brand-700">
            {formatExerciseName(exercise)}
          </h3>
        </button>
        <button
          onClick={onToggleFavorite}
          className="shrink-0 p-1 rounded-lg text-gray-300 hover:text-amber-500 transition-colors"
          title={exercise.is_favorite ? 'حذف از پرکاربرد' : 'افزودن به پرکاربرد'}
        >
          <Star size={16} className={exercise.is_favorite ? 'fill-amber-500 text-amber-500' : ''} />
        </button>
      </div>

      <div className="mt-2 flex items-center gap-1.5 flex-wrap">
        <span className={`inline-flex rounded-full px-2.5 py-0.5 text-[10px] font-medium ${EXERCISE_TYPE_COLORS[exercise.exercise_type]}`}>
          {EXERCISE_TYPE_LABELS[exercise.exercise_type]}
        </span>
        <span className={`inline-flex rounded-full px-2.5 py-0.5 text-[10px] font-medium ${EXERCISE_DIFFICULTY_COLORS[exercise.difficulty]}`}>
          {EXERCISE_DIFFICULTY_LABELS[exercise.difficulty]}
        </span>
        {exercise.primary_muscles.slice(0, 2).map((m) => (
          <span key={m} className="inline-flex rounded-full bg-gray-100 px-2.5 py-0.5 text-[10px] font-medium text-gray-600">
            {m}
          </span>
        ))}
      </div>

      {exercise.instructions && (
        <p className="mt-2 text-xs leading-6 text-gray-500 line-clamp-2">{exercise.instructions}</p>
      )}

      <div className="mt-3 flex items-center justify-between">
        {embedUrl ? (
          <span className="flex items-center gap-1 text-xs text-blue-600">
            <Play size={12} />
            ویدئو
          </span>
        ) : (
          <span className="text-xs text-gray-300">بدون ویدئو</span>
        )}
        <div className="flex items-center gap-1">
          <button
            onClick={onEdit}
            className="p-1.5 rounded-lg text-gray-400 hover:text-brand-600 hover:bg-brand-50 transition-colors"
            title="ویرایش"
          >
            <Pencil size={15} />
          </button>
          <button
            onClick={onDelete}
            className="p-1.5 rounded-lg text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors"
            title="حذف"
          >
            <Trash2 size={15} />
          </button>
        </div>
      </div>
    </div>
  );
}

function FilterChips({
  label,
  value,
  onChange,
  options,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  options: [string, string][];
}) {
  const [open, setOpen] = useState(false);
  const selected = options.find((o) => o[0] === value);
  return (
    <div className="relative">
      <button
        onClick={() => setOpen((v) => !v)}
        className={`flex items-center gap-1.5 rounded-lg px-3 py-1.5 text-xs font-medium transition-colors ${
          value !== 'all' ? 'bg-brand-50 text-brand-700 border border-brand-200' : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-50'
        }`}
      >
        <span className="text-gray-400">{label}:</span>
        {selected?.[1] ?? 'همه'}
      </button>
      {open && (
        <>
          <div className="fixed inset-0 z-10" onClick={() => setOpen(false)} />
          <div className="absolute z-20 mt-1 max-h-60 overflow-auto rounded-xl border border-gray-200 bg-white p-1.5 shadow-lg">
            {options.map(([val, lbl]) => (
              <button
                key={val}
                onClick={() => {
                  onChange(val);
                  setOpen(false);
                }}
                className={`block w-full rounded-lg px-3 py-1.5 text-right text-xs font-medium transition-colors ${
                  value === val ? 'bg-brand-50 text-brand-700' : 'text-gray-600 hover:bg-gray-50'
                }`}
              >
                {lbl}
              </button>
            ))}
          </div>
        </>
      )}
    </div>
  );
}
