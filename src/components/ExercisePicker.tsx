import { useMemo, useState } from 'react';
import { Search, Star, Plus, X, Loader2, Dumbbell, Filter } from 'lucide-react';
import {
  type Exercise,
  type ExerciseType,
  type ExerciseDifficulty,
  type ExerciseLocation,
  EXERCISE_TYPE_LABELS,
  EXERCISE_DIFFICULTY_LABELS,
  EXERCISE_LOCATION_LABELS,
  MUSCLE_OPTIONS,
  EQUIPMENT_OPTIONS,
  formatExerciseName,
} from '@/lib/supabase';

export default function ExercisePicker({
  exercises,
  onPick,
  onClose,
  excludeIds = [],
  loading,
}: {
  exercises: Exercise[];
  onPick: (e: Exercise) => void;
  onClose: () => void;
  excludeIds?: string[];
  loading: boolean;
}) {
  const [query, setQuery] = useState('');
  const [typeFilter, setTypeFilter] = useState<ExerciseType | 'all'>('all');
  const [difficultyFilter, setDifficultyFilter] = useState<ExerciseDifficulty | 'all'>('all');
  const [muscleFilter, setMuscleFilter] = useState<string>('all');
  const [equipmentFilter, setEquipmentFilter] = useState<string>('all');
  const [locationFilter, setLocationFilter] = useState<ExerciseLocation | 'all'>('all');
  const [showInactive, setShowInactive] = useState(false);
  const [showFilters, setShowFilters] = useState(false);

  const filtered = useMemo(() => {
    let list = exercises.filter((e) => showInactive || e.is_active);
    if (excludeIds.length > 0) list = list.filter((e) => !excludeIds.includes(e.id));
    if (typeFilter !== 'all') list = list.filter((e) => e.exercise_type === typeFilter);
    if (difficultyFilter !== 'all') list = list.filter((e) => e.difficulty === difficultyFilter);
    if (muscleFilter !== 'all') list = list.filter((e) => e.primary_muscles.includes(muscleFilter) || e.secondary_muscles.includes(muscleFilter));
    if (equipmentFilter !== 'all') list = list.filter((e) => e.equipment.includes(equipmentFilter));
    if (locationFilter !== 'all') {
      list = list.filter((e) => e.location === locationFilter || e.location === 'both');
    }
    const q = query.trim().toLowerCase();
    if (q) {
      list = list.filter((e) =>
        e.name_fa.toLowerCase().includes(q) ||
        e.name_en.toLowerCase().includes(q) ||
        e.primary_muscles.some((m) => m.toLowerCase().includes(q)) ||
        e.tags.some((t) => t.toLowerCase().includes(q)),
      );
    }
    return [...list].sort((a, b) => {
      if (a.is_favorite !== b.is_favorite) return a.is_favorite ? -1 : 1;
      return (a.name_fa || a.name_en).localeCompare(b.name_fa || b.name_en, 'fa');
    });
  }, [exercises, query, typeFilter, difficultyFilter, muscleFilter, equipmentFilter, locationFilter, showInactive, excludeIds]);

  const activeFilterCount =
    (typeFilter !== 'all' ? 1 : 0) +
    (difficultyFilter !== 'all' ? 1 : 0) +
    (muscleFilter !== 'all' ? 1 : 0) +
    (equipmentFilter !== 'all' ? 1 : 0) +
    (locationFilter !== 'all' ? 1 : 0);

  const clearFilters = () => {
    setTypeFilter('all');
    setDifficultyFilter('all');
    setMuscleFilter('all');
    setEquipmentFilter('all');
    setLocationFilter('all');
  };

  return (
    <div className="flex flex-col gap-3">
      <div className="flex items-center justify-between">
        <h3 className="text-sm font-semibold text-gray-800">انتخاب حرکت از بانک</h3>
        <button onClick={onClose} className="p-1 rounded-lg text-gray-400 hover:text-gray-600 hover:bg-gray-50">
          <X size={18} />
        </button>
      </div>

      <div className="flex items-center gap-2">
        <div className="relative flex-1">
          <Search size={16} className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            autoFocus
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="جست‌وجوی نام حرکت..."
            className="w-full rounded-xl border border-gray-200 py-2.5 pr-10 pl-4 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
          />
        </div>
        <button
          onClick={() => setShowFilters((v) => !v)}
          className={`flex items-center gap-1.5 rounded-xl border px-3 py-2.5 text-xs font-medium transition-colors ${
            showFilters || activeFilterCount > 0
              ? 'border-brand-200 bg-brand-50 text-brand-700'
              : 'border-gray-200 bg-white text-gray-600 hover:bg-gray-50'
          }`}
        >
          <Filter size={14} />
          فیلتر
          {activeFilterCount > 0 && (
            <span className="inline-flex h-4 w-4 items-center justify-center rounded-full bg-brand-600 text-[10px] text-white">
              {activeFilterCount}
            </span>
          )}
        </button>
      </div>

      {showFilters && (
        <div className="rounded-xl border border-gray-100 bg-gray-50/60 p-3 space-y-2.5">
          <div className="flex items-center justify-between">
            <span className="text-xs font-medium text-gray-500">فیلترها</span>
            {activeFilterCount > 0 && (
              <button onClick={clearFilters} className="text-[10px] text-brand-600 hover:text-brand-700 font-medium">
                پاک کردن فیلترها
              </button>
            )}
          </div>
          <div className="flex items-center gap-1.5 flex-wrap">
            <FilterDropdown
              label="نوع"
              value={typeFilter}
              onChange={(v) => setTypeFilter(v as ExerciseType | 'all')}
              options={[['all', 'همه'], ...Object.entries(EXERCISE_TYPE_LABELS)]}
            />
            <FilterDropdown
              label="سطح"
              value={difficultyFilter}
              onChange={(v) => setDifficultyFilter(v as ExerciseDifficulty | 'all')}
              options={[['all', 'همه'], ...Object.entries(EXERCISE_DIFFICULTY_LABELS)]}
            />
            <FilterDropdown
              label="عضله"
              value={muscleFilter}
              onChange={setMuscleFilter}
              options={[['all', 'همه'], ...MUSCLE_OPTIONS.map((m) => [m, m] as [string, string])]}
            />
            <FilterDropdown
              label="تجهیزات"
              value={equipmentFilter}
              onChange={setEquipmentFilter}
              options={[['all', 'همه'], ...EQUIPMENT_OPTIONS.map((eq) => [eq, eq] as [string, string])]}
            />
            <FilterDropdown
              label="محل"
              value={locationFilter}
              onChange={(v) => setLocationFilter(v as ExerciseLocation | 'all')}
              options={[['all', 'همه'], ...Object.entries(EXERCISE_LOCATION_LABELS)]}
            />
          </div>
          <label className="flex items-center gap-2 cursor-pointer">
            <input
              type="checkbox"
              checked={showInactive}
              onChange={(e) => setShowInactive(e.target.checked)}
              className="h-4 w-4 rounded border-gray-300 text-brand-600 focus:ring-brand-500"
            />
            <span className="text-xs text-gray-600">نمایش حرکات غیرفعال</span>
          </label>
        </div>
      )}

      {loading ? (
        <div className="flex items-center justify-center py-8 text-gray-400">
          <Loader2 className="animate-spin" size={20} />
        </div>
      ) : filtered.length === 0 ? (
        <div className="rounded-xl border border-dashed border-gray-200 p-8 text-center">
          <Dumbbell className="mx-auto text-gray-300" size={24} />
          <p className="mt-2 text-xs text-gray-500">حرکتی یافت نشد.</p>
        </div>
      ) : (
        <div className="max-h-80 overflow-y-auto space-y-1.5">
          {filtered.map((e) => (
            <button
              key={e.id}
              onClick={() => onPick(e)}
              className="flex w-full items-center justify-between rounded-xl border border-gray-100 p-3 text-right hover:border-brand-300 hover:bg-brand-50/40 transition-all"
            >
              <div className="flex-1 min-w-0">
                <p className="text-sm font-medium text-gray-800 truncate">{formatExerciseName(e)}</p>
                <div className="mt-1 flex items-center gap-1.5 flex-wrap">
                  <span className="text-[10px] text-gray-400">{EXERCISE_TYPE_LABELS[e.exercise_type]}</span>
                  <span className="text-[10px] text-gray-400">·</span>
                  <span className="text-[10px] text-gray-400">{EXERCISE_DIFFICULTY_LABELS[e.difficulty]}</span>
                  {!e.is_active && <span className="text-[10px] text-red-400">· غیرفعال</span>}
                  {e.primary_muscles.slice(0, 2).map((m) => (
                    <span key={m} className="text-[10px] text-gray-400">· {m}</span>
                  ))}
                </div>
              </div>
              {e.is_favorite && <Star size={14} className="ml-2 shrink-0 fill-amber-500 text-amber-500" />}
              <Plus size={16} className="ml-2 shrink-0 text-brand-600" />
            </button>
          ))}
        </div>
      )}
    </div>
  );
}

function FilterDropdown({
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
