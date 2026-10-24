import { useEffect, useMemo, useState } from 'react';
import {
  Plus,
  Trash2,
  Pencil,
  Copy,
  Search,
  Loader2,
  Dumbbell,
  Apple,
  Save,
  Lightbulb,
  ChevronUp,
  ChevronDown,
  Utensils,
  ClipboardList,
} from 'lucide-react';
import { supabase } from '@/lib/supabase';
import type {
  Template,
  Exercise,
  TemplateExercise,
  TemplateType,
  DietTemplateMeal,
  DietTemplateFoodItem,
  DietTip,
  DietTipCategory,
} from '@/lib/supabase';
import { DIET_TIP_CATEGORY_LABELS, DIET_PATTERNS } from '@/lib/supabase';
import { formatJalaliDateTime } from '@/lib/jalali';
import ExerciseListEditor, { type ExerciseAssignment } from './ExerciseListEditor';

interface TemplateEditorProps {
  templates: Template[];
  templateExercises: TemplateExercise[];
  exercises: Exercise[];
  onRefresh: () => Promise<void>;
}

let _seq = 0;
function tmpId() {
  _seq += 1;
  return `_tpl_${Date.now()}_${_seq}`;
}

export default function TemplateEditor({
  templates,
  templateExercises,
  exercises,
  onRefresh,
}: TemplateEditorProps) {
  const [activeType, setActiveType] = useState<TemplateType>('workout');
  const [query, setQuery] = useState('');
  const [editing, setEditing] = useState<Template | null>(null);
  const [creating, setCreating] = useState(false);
  const [deleteTarget, setDeleteTarget] = useState<Template | null>(null);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  // Diet template meals/food items loaded for editing
  const [dietTemplateMeals, setDietTemplateMeals] = useState<DietTemplateMeal[]>([]);
  const [dietTemplateFoodItems, setDietTemplateFoodItems] = useState<DietTemplateFoodItem[]>([]);
  const [dietTips, setDietTips] = useState<DietTip[]>([]);

  // Tips library management
  const [showTipsLibrary, setShowTipsLibrary] = useState(false);

  useEffect(() => {
    void supabase.from('diet_template_meals').select('*').order('sort_order').then(({ data }) => {
      if (data) setDietTemplateMeals(data as DietTemplateMeal[]);
    });
    void supabase.from('diet_tips').select('*').order('sort_order').then(({ data }) => {
      if (data) setDietTips(data as DietTip[]);
    });
  }, []);

  const refreshDietTemplateData = async () => {
    const [mRes, fRes] = await Promise.all([
      supabase.from('diet_template_meals').select('*').order('sort_order'),
      supabase.from('diet_template_food_items').select('*').order('sort_order'),
    ]);
    if (mRes.data) setDietTemplateMeals(mRes.data as DietTemplateMeal[]);
    if (fRes.data) setDietTemplateFoodItems(fRes.data as DietTemplateFoodItem[]);
  };

  const filtered = useMemo(() => {
    const q = query.trim();
    return templates
      .filter((t) => t.type === activeType)
      .filter((t) => !q || t.name.includes(q) || (t.description ?? '').includes(q))
      .sort((a, b) => b.created_at.localeCompare(a.created_at));
  }, [templates, activeType, query]);

  const exercisesForTemplate = (templateId: string) =>
    templateExercises
      .filter((te) => te.template_id === templateId)
      .sort((a, b) => a.sort_order - b.sort_order);

  const mealsForTemplate = (templateId: string) =>
    dietTemplateMeals
      .filter((m) => m.template_id === templateId)
      .sort((a, b) => a.sort_order - b.sort_order);

  const handleDelete = async () => {
    if (!deleteTarget) return;
    setSaving(true);
    setError(null);
    if (deleteTarget.type === 'diet') {
      // Delete diet template meals + food items first
      const meals = mealsForTemplate(deleteTarget.id);
      for (const m of meals) {
        await supabase.from('diet_template_food_items').delete().eq('meal_id', m.id);
      }
      await supabase.from('diet_template_meals').delete().eq('template_id', deleteTarget.id);
    } else {
      await supabase.from('template_exercises').delete().eq('template_id', deleteTarget.id);
    }
    const { error: tErr } = await supabase
      .from('templates')
      .delete()
      .eq('id', deleteTarget.id);
    setSaving(false);
    if (tErr) {
      setError('حذف قالب ناموفق بود');
      return;
    }
    setDeleteTarget(null);
    setSuccess('قالب حذف شد');
    setTimeout(() => setSuccess(null), 2500);
    await onRefresh();
    if (deleteTarget.type === 'diet') await refreshDietTemplateData();
  };

  const handleCopy = async (t: Template) => {
    setSaving(true);
    setError(null);
    const { data: newTpl, error: tplErr } = await supabase
      .from('templates')
      .insert({
        type: t.type,
        name: `${t.name} (کپی)`,
        description: t.description,
      })
      .select()
      .single();
    if (tplErr || !newTpl) {
      setError('کپی قالب ناموفق بود');
      setSaving(false);
      return;
    }
    if (t.type === 'workout') {
      const tExercises = exercisesForTemplate(t.id);
      if (tExercises.length > 0) {
        const rows = tExercises.map((te) => ({
          template_id: newTpl.id,
          exercise_id: te.exercise_id,
          sort_order: te.sort_order,
          sets: te.sets,
          reps: te.reps,
          rest_seconds: te.rest_seconds,
          rpe: te.rpe,
          day_label: te.day_label,
          coach_notes: te.coach_notes,
        }));
        await supabase.from('template_exercises').insert(rows);
      }
    } else {
      // Copy diet template meals + food items
      const meals = mealsForTemplate(t.id);
      for (const m of meals) {
        const { data: newMeal } = await supabase
          .from('diet_template_meals')
          .insert({
            template_id: newTpl.id,
            sort_order: m.sort_order,
            name: m.name,
            notes: m.notes,
            fasting_start: m.fasting_start,
            fasting_end: m.fasting_end,
          })
          .select()
          .single();
        if (newMeal) {
          const foods = dietTemplateFoodItems.filter((f) => f.meal_id === m.id);
          if (foods.length > 0) {
            await supabase.from('diet_template_food_items').insert(
              foods.map((f) => ({
                meal_id: newMeal.id,
                sort_order: f.sort_order,
                name: f.name,
                amount: f.amount,
                unit: f.unit,
                is_raw: f.is_raw,
                alternatives: f.alternatives,
                notes: f.notes,
              })),
            );
          }
        }
      }
    }
    setSaving(false);
    setSuccess('قالب با موفقیت کپی شد');
    setTimeout(() => setSuccess(null), 2500);
    await onRefresh();
    await refreshDietTemplateData();
  };

  const openEditTemplate = async (t: Template) => {
    if (t.type === 'diet') {
      await refreshDietTemplateData();
    }
    setEditing(t);
  };

  // --- Diet tips library CRUD ---
  const [editingTip, setEditingTip] = useState<DietTip | null>(null);
  const [tipFormOpen, setTipFormOpen] = useState(false);

  const handleSaveTip = async (vals: {
    category: DietTipCategory;
    title: string;
    body: string;
    is_active: boolean;
  }) => {
    setSaving(true);
    setError(null);
    if (editingTip) {
      const { error: updErr } = await supabase
        .from('diet_tips')
        .update({
          category: vals.category,
          title: vals.title.trim(),
          body: vals.body.trim(),
          is_active: vals.is_active,
          updated_at: new Date().toISOString(),
        })
        .eq('id', editingTip.id);
      if (updErr) setError('به‌روزرسانی نکته ناموفق بود');
    } else {
      const { error: insErr } = await supabase.from('diet_tips').insert({
        category: vals.category,
        title: vals.title.trim(),
        body: vals.body.trim(),
        is_active: vals.is_active,
        sort_order: dietTips.length,
      });
      if (insErr) setError('ساخت نکته ناموفق بود');
    }
    setSaving(false);
    if (!error) {
      setTipFormOpen(false);
      setEditingTip(null);
      const { data } = await supabase.from('diet_tips').select('*').order('sort_order');
      if (data) setDietTips(data as DietTip[]);
    }
  };

  const handleDeleteTip = async (tip: DietTip) => {
    setSaving(true);
    const { error: delErr } = await supabase.from('diet_tips').delete().eq('id', tip.id);
    setSaving(false);
    if (delErr) {
      setError('حذف نکته ناموفق بود');
      return;
    }
    const { data } = await supabase.from('diet_tips').select('*').order('sort_order');
    if (data) setDietTips(data as DietTip[]);
  };

  const handleCopyTip = async (tip: DietTip) => {
    setSaving(true);
    setError(null);
    const { error: insErr } = await supabase.from('diet_tips').insert({
      category: tip.category,
      title: `${tip.title} (کپی)`,
      body: tip.body,
      is_active: tip.is_active,
      sort_order: dietTips.length,
    });
    setSaving(false);
    if (insErr) {
      setError('کپی نکته ناموفق بود');
      return;
    }
    setSuccess('نکته کپی شد');
    setTimeout(() => setSuccess(null), 2500);
    const { data } = await supabase.from('diet_tips').select('*').order('sort_order');
    if (data) setDietTips(data as DietTip[]);
  };

  if (tipFormOpen) {
    return (
      <DietTipForm
        tip={editingTip}
        onSave={handleSaveTip}
        onCancel={() => {
          setTipFormOpen(false);
          setEditingTip(null);
        }}
        saving={saving}
        error={error}
      />
    );
  }

  if (showTipsLibrary) {
    return (
      <DietTipsLibrary
        tips={dietTips}
        onBack={() => setShowTipsLibrary(false)}
        onAdd={() => {
          setEditingTip(null);
          setTipFormOpen(true);
        }}
        onEdit={(tip) => {
          setEditingTip(tip);
          setTipFormOpen(true);
        }}
        onDelete={handleDeleteTip}
        onCopy={handleCopyTip}
        saving={saving}
      />
    );
  }

  if (creating || editing) {
    return (
      <TemplateForm
        template={editing}
        type={activeType}
        exercises={exercises}
        existingExercises={editing ? exercisesForTemplate(editing.id) : []}
        dietTemplateMeals={editing ? mealsForTemplate(editing.id) : []}
        dietTemplateFoodItems={dietTemplateFoodItems}
        onSave={async (name, description, assignments, dietMeals) => {
          setSaving(true);
          setError(null);
          try {
            let templateId = editing?.id;
            if (editing) {
              const { error: updErr } = await supabase
                .from('templates')
                .update({ name: name.trim(), description: description.trim() })
                .eq('id', editing.id);
              if (updErr) throw new Error('به‌روزرسانی قالب ناموفق بود');
              if (editing.type === 'workout') {
                await supabase.from('template_exercises').delete().eq('template_id', editing.id);
              } else {
                // Delete existing diet meals + food items
                const oldMeals = mealsForTemplate(editing.id);
                for (const m of oldMeals) {
                  await supabase.from('diet_template_food_items').delete().eq('meal_id', m.id);
                }
                await supabase.from('diet_template_meals').delete().eq('template_id', editing.id);
              }
            } else {
              const { data, error: insErr } = await supabase
                .from('templates')
                .insert({ type: activeType, name: name.trim(), description: description.trim() })
                .select()
                .single();
              if (insErr || !data) throw new Error('ساخت قالب ناموفق بود');
              templateId = data.id;
            }
            // Insert workout exercises
            if (activeType === 'workout' && templateId && assignments.length > 0) {
              const rows = assignments.map((a, i) => ({
                template_id: templateId,
                exercise_id: a.exercise_id,
                sort_order: i,
                sets: a.sets ? Number(a.sets) : null,
                reps: a.reps.trim(),
                rest_seconds: a.rest_seconds ? Number(a.rest_seconds) : null,
                rpe: a.rpe ? Number(a.rpe) : null,
                day_label: a.day_label.trim(),
                coach_notes: a.coach_notes.trim(),
              }));
              const { error: exErr } = await supabase.from('template_exercises').insert(rows);
              if (exErr) throw new Error('ذخیرهٔ حرکات قالب ناموفق بود');
            }
            // Insert diet meals + food items
            if (activeType === 'diet' && templateId && dietMeals && dietMeals.length > 0) {
              for (let mi = 0; mi < dietMeals.length; mi++) {
                const meal = dietMeals[mi];
                const { data: mealRow, error: mealErr } = await supabase
                  .from('diet_template_meals')
                  .insert({
                    template_id: templateId,
                    sort_order: mi,
                    name: meal.name.trim(),
                    notes: meal.notes.trim(),
                    fasting_start: meal.fasting_start.trim(),
                    fasting_end: meal.fasting_end.trim(),
                  })
                  .select()
                  .single();
                if (mealErr || !mealRow) continue;
                if (meal.foodItems.length > 0) {
                  const foodRows = meal.foodItems.map((f, fi) => ({
                    meal_id: mealRow.id,
                    sort_order: fi,
                    name: f.name.trim(),
                    amount: f.amount.trim(),
                    unit: f.unit.trim(),
                    is_raw: f.is_raw,
                    alternatives: f.alternatives.trim(),
                    notes: f.notes.trim(),
                  }));
                  await supabase.from('diet_template_food_items').insert(foodRows);
                }
              }
            }
            setSuccess(editing ? 'قالب به‌روزرسانی شد' : 'قالب جدید ساخته شد');
            setTimeout(() => setSuccess(null), 2500);
            setEditing(null);
            setCreating(false);
            await onRefresh();
            await refreshDietTemplateData();
          } catch (e) {
            setError(e instanceof Error ? e.message : 'ذخیره ناموفق بود');
          }
          setSaving(false);
        }}
        onCancel={() => {
          setEditing(null);
          setCreating(false);
          setError(null);
        }}
        saving={saving}
        error={error}
      />
    );
  }

  return (
    <div>
      <div className="flex items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">قالب‌های آماده</h1>
          <p className="text-sm text-gray-500 mt-1">قالب‌های تمرینی و غذایی قابل انتساب به شاگردها</p>
        </div>
        <div className="flex items-center gap-2">
          <button
            onClick={() => setShowTipsLibrary(true)}
            className="flex items-center gap-2 rounded-xl border border-amber-200 bg-amber-50 px-4 py-2.5 text-amber-700 text-sm font-medium hover:bg-amber-100 transition-colors"
          >
            <Lightbulb size={18} />
            نکات اجرایی رژیم
          </button>
          <button
            onClick={() => setCreating(true)}
            className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-white text-sm font-medium hover:bg-brand-700 transition-colors shadow-sm"
          >
            <Plus size={18} />
            قالب جدید
          </button>
        </div>
      </div>

      {/* Type tabs */}
      <div className="mt-5 flex items-center gap-2">
        <button
          onClick={() => setActiveType('workout')}
          className={`flex items-center gap-1.5 rounded-xl px-4 py-2 text-sm font-medium transition-colors ${
            activeType === 'workout'
              ? 'bg-brand-600 text-white'
              : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-50'
          }`}
        >
          <Dumbbell size={16} />
          قالب‌های تمرینی
        </button>
        <button
          onClick={() => setActiveType('diet')}
          className={`flex items-center gap-1.5 rounded-xl px-4 py-2 text-sm font-medium transition-colors ${
            activeType === 'diet'
              ? 'bg-brand-600 text-white'
              : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-50'
          }`}
        >
          <Apple size={16} />
          قالب‌های غذایی
        </button>
      </div>

      {/* Search */}
      <div className="relative mt-4">
        <Search size={18} className="absolute right-3.5 top-1/2 -translate-y-1/2 text-gray-400" />
        <input
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="جست‌وجو در قالب‌ها..."
          className="w-full rounded-xl border border-gray-200 bg-white py-2.5 pr-11 pl-4 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
        />
      </div>

      {error && (
        <div className="mt-3 rounded-xl border border-red-200 bg-red-50 px-4 py-2.5 text-sm text-red-700">
          {error}
          <button onClick={() => setError(null)} className="text-red-400 hover:text-red-600 mr-3">بستن</button>
        </div>
      )}
      {success && (
        <div className="mt-3 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-2.5 text-sm text-emerald-700">
          {success}
        </div>
      )}

      {/* Template list */}
      {filtered.length === 0 ? (
        <div className="mt-4 rounded-2xl border border-dashed border-gray-200 bg-white p-12 text-center">
          {activeType === 'workout' ? <Dumbbell className="mx-auto text-gray-300" size={32} /> : <Apple className="mx-auto text-gray-300" size={32} />}
          <p className="mt-3 text-sm text-gray-500">
            {query ? 'نتیجه‌ای یافت نشد.' : `هنوز قالب ${activeType === 'workout' ? 'تمرینی' : 'غذایی'} ساخته نشده است.`}
          </p>
        </div>
      ) : (
        <div className="mt-4 grid grid-cols-2 gap-4">
          {filtered.map((t) => {
            const tExercises = exercisesForTemplate(t.id);
            const tMeals = mealsForTemplate(t.id);
            const dayCount = new Set(tExercises.map((te) => te.day_label).filter(Boolean)).size;
            return (
              <div
                key={t.id}
                className="rounded-2xl border border-gray-100 bg-white p-5 shadow-card hover:shadow-cardHover transition-all"
              >
                <div className="flex items-start justify-between gap-2">
                  <h3 className="text-sm font-semibold text-gray-800">{t.name}</h3>
                  <div className="flex items-center gap-1 shrink-0">
                    <button
                      onClick={() => openEditTemplate(t)}
                      className="p-1.5 rounded-lg text-gray-400 hover:text-brand-600 hover:bg-brand-50 transition-colors"
                      title="ویرایش"
                    >
                      <Pencil size={15} />
                    </button>
                    <button
                      onClick={() => handleCopy(t)}
                      disabled={saving}
                      className="p-1.5 rounded-lg text-gray-400 hover:text-blue-600 hover:bg-blue-50 transition-colors disabled:opacity-50"
                      title="کپی"
                    >
                      <Copy size={15} />
                    </button>
                    <button
                      onClick={() => setDeleteTarget(t)}
                      className="p-1.5 rounded-lg text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors"
                      title="حذف"
                    >
                      <Trash2 size={15} />
                    </button>
                  </div>
                </div>
                {t.description && (
                  <p className="mt-2 text-sm leading-7 text-gray-500">{t.description}</p>
                )}
                {t.type === 'workout' && tExercises.length > 0 && (
                  <div className="mt-3 flex items-center gap-2 flex-wrap">
                    <span className="inline-flex items-center gap-1 rounded-full bg-brand-50 px-2.5 py-0.5 text-[10px] font-medium text-brand-700">
                      <Dumbbell size={10} />
                      {tExercises.length} حرکت
                    </span>
                    {dayCount > 0 && (
                      <span className="inline-flex items-center gap-1 rounded-full bg-blue-50 px-2.5 py-0.5 text-[10px] font-medium text-blue-700">
                        {dayCount} روز تمرین
                      </span>
                    )}
                  </div>
                )}
                {t.type === 'diet' && tMeals.length > 0 && (
                  <div className="mt-3 flex items-center gap-2 flex-wrap">
                    <span className="inline-flex items-center gap-1 rounded-full bg-emerald-50 px-2.5 py-0.5 text-[10px] font-medium text-emerald-700">
                      <Utensils size={10} />
                      {tMeals.length} وعده
                    </span>
                  </div>
                )}
                <p className="mt-3 text-[10px] text-gray-400">
                  ایجاد: {formatJalaliDateTime(t.created_at)}
                </p>
              </div>
            );
          })}
        </div>
      )}

      {/* Delete confirm */}
      {deleteTarget && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/30 p-4" onClick={() => setDeleteTarget(null)}>
          <div className="max-w-sm w-full bg-white rounded-2xl shadow-cardHover p-6" onClick={(e) => e.stopPropagation()}>
            <h3 className="text-base font-semibold text-gray-800">حذف قالب</h3>
            <p className="mt-2 text-sm text-gray-600 leading-7">
              آیا از حذف قالب «{deleteTarget.name}» مطمئن هستید؟ برنامه‌های قبلی شاگردها که از این قالب ساخته شده‌اند حذف نمی‌شوند.
            </p>
            <div className="mt-4 flex justify-start gap-2">
              <button
                onClick={handleDelete}
                disabled={saving}
                className="px-5 py-2.5 rounded-xl bg-red-600 text-white text-sm font-medium hover:bg-red-700 transition-colors disabled:opacity-50"
              >
                {saving ? 'در حال حذف...' : 'حذف کن'}
              </button>
              <button
                onClick={() => setDeleteTarget(null)}
                className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200 transition-colors"
              >
                انصراف
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

// --- Diet meal draft types (shared) ---

interface MealDraft {
  id: string;
  name: string;
  notes: string;
  fasting_start: string;
  fasting_end: string;
  foodItems: FoodItemDraft[];
}

interface FoodItemDraft {
  id: string;
  name: string;
  amount: string;
  unit: string;
  is_raw: boolean | null;
  alternatives: string;
  notes: string;
}

// --- Template form (create / edit) ---

function TemplateForm({
  template,
  type,
  exercises,
  existingExercises,
  dietTemplateMeals,
  dietTemplateFoodItems,
  onSave,
  onCancel,
  saving,
  error,
}: {
  template: Template | null;
  type: TemplateType;
  exercises: Exercise[];
  existingExercises: TemplateExercise[];
  dietTemplateMeals: DietTemplateMeal[];
  dietTemplateFoodItems: DietTemplateFoodItem[];
  onSave: (
    name: string,
    description: string,
    assignments: ExerciseAssignment[],
    dietMeals?: MealDraft[],
  ) => void;
  onCancel: () => void;
  saving: boolean;
  error: string | null;
}) {
  const [name, setName] = useState(template?.name ?? '');
  const [description, setDescription] = useState(template?.description ?? '');
  const [assignments, setAssignments] = useState<ExerciseAssignment[]>(
    existingExercises.map((te) => {
      const ex = exercises.find((e) => e.id === te.exercise_id);
      return {
        exercise_id: te.exercise_id,
        exercise_name_fa: ex?.name_fa ?? '',
        exercise_name_en: ex?.name_en ?? '',
        exercise_video_url: ex?.video_url ?? '',
        source_template_id: null,
        sort_order: te.sort_order,
        sets: te.sets != null ? String(te.sets) : '',
        reps: te.reps,
        rest_seconds: te.rest_seconds != null ? String(te.rest_seconds) : '',
        rpe: te.rpe != null ? String(te.rpe) : '',
        day_label: te.day_label || 'روز ۱',
        coach_notes: te.coach_notes,
      };
    }),
  );

  // Diet meals state
  const [meals, setMeals] = useState<MealDraft[]>(() => {
    if (type !== 'diet' || !template) return [];
    return dietTemplateMeals.map((m) => ({
      id: m.id,
      name: m.name,
      notes: m.notes,
      fasting_start: m.fasting_start,
      fasting_end: m.fasting_end,
      foodItems: dietTemplateFoodItems
        .filter((f) => f.meal_id === m.id)
        .sort((a, b) => a.sort_order - b.sort_order)
        .map((f) => ({
          id: f.id,
          name: f.name,
          amount: f.amount,
          unit: f.unit,
          is_raw: f.is_raw,
          alternatives: f.alternatives,
          notes: f.notes,
        })),
    }));
  });

  const addMeal = () => {
    setMeals((prev) => [
      ...prev,
      { id: tmpId(), name: '', notes: '', fasting_start: '', fasting_end: '', foodItems: [] },
    ]);
  };
  const updateMeal = (id: string, patch: Partial<MealDraft>) => {
    setMeals((prev) => prev.map((m) => (m.id === id ? { ...m, ...patch } : m)));
  };
  const removeMeal = (id: string) => {
    setMeals((prev) => prev.filter((m) => m.id !== id));
  };
  const moveMeal = (index: number, dir: -1 | 1) => {
    setMeals((prev) => {
      const arr = [...prev];
      const ni = index + dir;
      if (ni < 0 || ni >= arr.length) return arr;
      [arr[index], arr[ni]] = [arr[ni], arr[index]];
      return arr;
    });
  };
  const addFoodItem = (mealId: string) => {
    setMeals((prev) =>
      prev.map((m) =>
        m.id === mealId
          ? {
              ...m,
              foodItems: [
                ...m.foodItems,
                { id: tmpId(), name: '', amount: '', unit: '', is_raw: null, alternatives: '', notes: '' },
              ],
            }
          : m,
      ),
    );
  };
  const updateFoodItem = (mealId: string, foodId: string, patch: Partial<FoodItemDraft>) => {
    setMeals((prev) =>
      prev.map((m) =>
        m.id === mealId
          ? { ...m, foodItems: m.foodItems.map((f) => (f.id === foodId ? { ...f, ...patch } : f)) }
          : m,
      ),
    );
  };
  const removeFoodItem = (mealId: string, foodId: string) => {
    setMeals((prev) =>
      prev.map((m) =>
        m.id === mealId ? { ...m, foodItems: m.foodItems.filter((f) => f.id !== foodId) } : m,
      ),
    );
  };
  const moveFoodItem = (mealId: string, index: number, dir: -1 | 1) => {
    setMeals((prev) =>
      prev.map((m) => {
        if (m.id !== mealId) return m;
        const arr = [...m.foodItems];
        const ni = index + dir;
        if (ni < 0 || ni >= arr.length) return m;
        [arr[index], arr[ni]] = [arr[ni], arr[index]];
        return { ...m, foodItems: arr };
      }),
    );
  };

  const handleSubmit = () => {
    if (!name.trim()) return;
    onSave(name, description, assignments, type === 'diet' ? meals : undefined);
  };

  return (
    <div>
      <button
        onClick={onCancel}
        className="flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-700 mb-4"
      >
        بازگشت به فهرست قالب‌ها
      </button>

      <h1 className="text-2xl font-bold text-gray-800">
        {template ? 'ویرایش قالب' : 'قالب جدید'}
        <span className="text-sm font-normal text-gray-400 mr-2">
          ({type === 'workout' ? 'تمرینی' : 'غذایی'})
        </span>
      </h1>

      {error && (
        <div className="mt-3 rounded-xl border border-red-200 bg-red-50 px-4 py-2.5 text-sm text-red-700">
          {error}
        </div>
      )}

      <div className="mt-5 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
        <div className="flex flex-col gap-4">
          <div className="flex flex-col gap-1.5">
            <label className="text-sm font-medium text-gray-600">نام قالب</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder={type === 'workout' ? 'مثال: برنامه فول‌بادی ۳ روزه' : 'مثال: رژیم معمولی کاهش وزن'}
              className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
            />
          </div>
          <div className="flex flex-col gap-1.5">
            <label className="text-sm font-medium text-gray-600">توضیحات (اختیاری)</label>
            <textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="توضیحات قالب..."
              rows={3}
              className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-6"
            />
          </div>
        </div>
      </div>

      {type === 'workout' && (
        <div className="mt-4 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
          <ExerciseListEditor
            exercises={exercises}
            assignments={assignments}
            onChange={setAssignments}
            loading={false}
          />
        </div>
      )}

      {type === 'diet' && (
        <DietMealEditor
          meals={meals}
          pattern={null}
          onAddMeal={addMeal}
          onUpdateMeal={updateMeal}
          onRemoveMeal={removeMeal}
          onMoveMeal={moveMeal}
          onAddFood={addFoodItem}
          onUpdateFood={updateFoodItem}
          onRemoveFood={removeFoodItem}
          onMoveFood={moveFoodItem}
        />
      )}

      <div className="mt-4 flex justify-start gap-2">
        <button
          onClick={handleSubmit}
          disabled={saving || !name.trim()}
          className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 transition-colors disabled:opacity-50"
        >
          {saving ? <Loader2 size={16} className="animate-spin" /> : <Save size={16} />}
          {saving ? 'در حال ذخیره...' : 'ذخیره قالب'}
        </button>
        <button
          onClick={onCancel}
          className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200 transition-colors"
        >
          انصراف
        </button>
      </div>
    </div>
  );
}

// --- Shared diet meal editor (used in template form) ---

function DietMealEditor({
  meals,
  pattern,
  onAddMeal,
  onUpdateMeal,
  onRemoveMeal,
  onMoveMeal,
  onAddFood,
  onUpdateFood,
  onRemoveFood,
  onMoveFood,
}: {
  meals: MealDraft[];
  pattern: string | null;
  onAddMeal: () => void;
  onUpdateMeal: (id: string, patch: Partial<MealDraft>) => void;
  onRemoveMeal: (id: string) => void;
  onMoveMeal: (index: number, dir: -1 | 1) => void;
  onAddFood: (mealId: string) => void;
  onUpdateFood: (mealId: string, foodId: string, patch: Partial<FoodItemDraft>) => void;
  onRemoveFood: (mealId: string, foodId: string) => void;
  onMoveFood: (mealId: string, index: number, dir: -1 | 1) => void;
}) {
  return (
    <div className="mt-4 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center gap-1.5">
          <Utensils size={15} className="text-gray-500" />
          <span className="text-sm font-semibold text-gray-700">وعده‌های غذایی قالب</span>
        </div>
        <button
          type="button"
          onClick={onAddMeal}
          className="flex items-center gap-1 rounded-lg bg-brand-50 px-2.5 py-1.5 text-xs font-medium text-brand-700 hover:bg-brand-100 transition-colors"
        >
          <Plus size={13} />
          وعده جدید
        </button>
      </div>

      {meals.length === 0 ? (
        <p className="text-xs text-gray-400 rounded-lg bg-gray-50 p-4 text-center">
          هنوز وعده‌ای اضافه نشده است.
        </p>
      ) : (
        <div className="space-y-3">
          {meals.map((meal, mi) => (
            <div key={meal.id} className="rounded-xl border border-gray-200 bg-gray-50/40 p-3">
              <div className="flex items-center gap-2">
                <input
                  type="text"
                  value={meal.name}
                  onChange={(e) => onUpdateMeal(meal.id, { name: e.target.value })}
                  placeholder="نام وعده (مثال: صبحانه)"
                  className="flex-1 rounded-lg border border-gray-200 px-3 py-2 text-sm font-medium outline-none focus:border-brand-500 focus:ring-1 focus:ring-brand-100"
                />
                <div className="flex items-center gap-0.5">
                  <button type="button" onClick={() => onMoveMeal(mi, -1)} disabled={mi === 0} className="p-1 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                    <ChevronUp size={16} />
                  </button>
                  <button type="button" onClick={() => onMoveMeal(mi, 1)} disabled={mi === meals.length - 1} className="p-1 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                    <ChevronDown size={16} />
                  </button>
                  <button type="button" onClick={() => onRemoveMeal(meal.id)} className="p-1 rounded text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors">
                    <Trash2 size={15} />
                  </button>
                </div>
              </div>

              {pattern === 'فستینگ متناوب' && (
                <div className="mt-2 grid grid-cols-2 gap-2">
                  <input
                    type="text"
                    value={meal.fasting_start}
                    onChange={(e) => onUpdateMeal(meal.id, { fasting_start: e.target.value })}
                    placeholder="شروع بازه ناشتایی"
                    className="rounded-lg border border-gray-200 px-3 py-1.5 text-xs outline-none focus:border-brand-500"
                  />
                  <input
                    type="text"
                    value={meal.fasting_end}
                    onChange={(e) => onUpdateMeal(meal.id, { fasting_end: e.target.value })}
                    placeholder="پایان بازه ناشتایی"
                    className="rounded-lg border border-gray-200 px-3 py-1.5 text-xs outline-none focus:border-brand-500"
                  />
                </div>
              )}

              <input
                type="text"
                value={meal.notes}
                onChange={(e) => onUpdateMeal(meal.id, { notes: e.target.value })}
                placeholder="نکات وعده (اختیاری)"
                className="mt-2 w-full rounded-lg border border-gray-200 px-3 py-1.5 text-xs outline-none focus:border-brand-500"
              />

              <div className="mt-2 space-y-1.5">
                {meal.foodItems.map((f, fi) => (
                  <div key={f.id} className="rounded-lg border border-gray-100 bg-white p-2.5">
                    <div className="flex items-center gap-2">
                      <input
                        type="text"
                        value={f.name}
                        onChange={(e) => onUpdateFood(meal.id, f.id, { name: e.target.value })}
                        placeholder="نام ماده غذایی"
                        className="flex-1 rounded-md border border-gray-200 px-2.5 py-1.5 text-xs outline-none focus:border-brand-500"
                      />
                      <div className="flex items-center gap-0.5">
                        <button type="button" onClick={() => onMoveFood(meal.id, fi, -1)} disabled={fi === 0} className="p-0.5 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                          <ChevronUp size={14} />
                        </button>
                        <button type="button" onClick={() => onMoveFood(meal.id, fi, 1)} disabled={fi === meal.foodItems.length - 1} className="p-0.5 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                          <ChevronDown size={14} />
                        </button>
                        <button type="button" onClick={() => onRemoveFood(meal.id, f.id)} className="p-0.5 rounded text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors">
                          <Trash2 size={14} />
                        </button>
                      </div>
                    </div>
                    <div className="mt-1.5 flex items-center gap-2">
                      <input
                        type="text"
                        value={f.amount}
                        onChange={(e) => onUpdateFood(meal.id, f.id, { amount: e.target.value })}
                        placeholder="مقدار"
                        className="w-20 rounded-md border border-gray-200 px-2 py-1 text-xs outline-none focus:border-brand-500"
                      />
                      <input
                        type="text"
                        value={f.unit}
                        onChange={(e) => onUpdateFood(meal.id, f.id, { unit: e.target.value })}
                        placeholder="واحد"
                        className="w-28 rounded-md border border-gray-200 px-2 py-1 text-xs outline-none focus:border-brand-500"
                      />
                      <select
                        value={f.is_raw === null ? '' : f.is_raw ? 'raw' : 'cooked'}
                        onChange={(e) =>
                          onUpdateFood(meal.id, f.id, {
                            is_raw: e.target.value === '' ? null : e.target.value === 'raw',
                          })
                        }
                        className="rounded-md border border-gray-200 px-2 py-1 text-xs outline-none focus:border-brand-500 bg-white"
                      >
                        <option value="">خام/پخته؟</option>
                        <option value="raw">خام</option>
                        <option value="cooked">پخته</option>
                      </select>
                    </div>
                    <input
                      type="text"
                      value={f.alternatives}
                      onChange={(e) => onUpdateFood(meal.id, f.id, { alternatives: e.target.value })}
                      placeholder="جایگزین‌ها (اختیاری)"
                      className="mt-1.5 w-full rounded-md border border-gray-200 px-2.5 py-1 text-xs outline-none focus:border-brand-500"
                    />
                    <input
                      type="text"
                      value={f.notes}
                      onChange={(e) => onUpdateFood(meal.id, f.id, { notes: e.target.value })}
                      placeholder="نکته (اختیاری)"
                      className="mt-1 w-full rounded-md border border-gray-200 px-2.5 py-1 text-xs outline-none focus:border-brand-500"
                    />
                  </div>
                ))}
                <button
                  type="button"
                  onClick={() => onAddFood(meal.id)}
                  className="flex items-center gap-1 text-[11px] text-brand-600 hover:text-brand-700 font-medium"
                >
                  <Plus size={12} />
                  ماده غذایی
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
      <p className="mt-3 text-[10px] text-gray-400 leading-5">
        قالب‌های غذایی مستقل از برنامه‌های قبلی شاگردان هستند. تغییر یا حذف قالب، برنامه‌های ذخیره‌شده را تغییر نمی‌دهد.
      </p>
    </div>
  );
}

// --- Diet tips library ---

function DietTipsLibrary({
  tips,
  onBack,
  onAdd,
  onEdit,
  onDelete,
  onCopy,
  saving,
}: {
  tips: DietTip[];
  onBack: () => void;
  onAdd: () => void;
  onEdit: (tip: DietTip) => void;
  onDelete: (tip: DietTip) => void;
  onCopy: (tip: DietTip) => void;
  saving: boolean;
}) {
  const [query, setQuery] = useState('');
  const [categoryFilter, setCategoryFilter] = useState<string>('all');
  const [deleteTarget, setDeleteTarget] = useState<DietTip | null>(null);

  const filtered = useMemo(() => {
    const q = query.trim();
    return tips
      .filter((t) => categoryFilter === 'all' || t.category === categoryFilter)
      .filter((t) => !q || t.title.includes(q) || t.body.includes(q))
      .sort((a, b) => a.sort_order - b.sort_order);
  }, [tips, query, categoryFilter]);

  return (
    <div>
      <button
        onClick={onBack}
        className="flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-700 mb-4"
      >
        بازگشت به قالب‌ها
      </button>

      <div className="flex items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800 flex items-center gap-2">
            <Lightbulb size={22} className="text-amber-500" />
            نکات اجرایی رژیم
          </h1>
          <p className="text-sm text-gray-500 mt-1">کتابخانه نکات آماده برای استفاده در برنامه‌های غذایی</p>
        </div>
        <button
          onClick={onAdd}
          className="flex items-center gap-2 rounded-xl bg-amber-500 px-4 py-2.5 text-white text-sm font-medium hover:bg-amber-600 transition-colors shadow-sm"
        >
          <Plus size={18} />
          نکته جدید
        </button>
      </div>

      {/* Filters */}
      <div className="mt-5 flex items-center gap-3">
        <div className="relative flex-1">
          <Search size={18} className="absolute right-3.5 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="جست‌وجو در نکات..."
            className="w-full rounded-xl border border-gray-200 bg-white py-2.5 pr-11 pl-4 text-sm outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-100"
          />
        </div>
        <select
          value={categoryFilter}
          onChange={(e) => setCategoryFilter(e.target.value)}
          className="rounded-xl border border-gray-200 bg-white px-3.5 py-2.5 text-sm outline-none focus:border-amber-500"
        >
          <option value="all">همه دسته‌ها</option>
          {(Object.keys(DIET_TIP_CATEGORY_LABELS) as DietTipCategory[]).map((c) => (
            <option key={c} value={c}>{DIET_TIP_CATEGORY_LABELS[c]}</option>
          ))}
        </select>
      </div>

      {/* Tips list */}
      {filtered.length === 0 ? (
        <div className="mt-4 rounded-2xl border border-dashed border-gray-200 bg-white p-12 text-center">
          <Lightbulb className="mx-auto text-gray-300" size={32} />
          <p className="mt-3 text-sm text-gray-500">
            {query || categoryFilter !== 'all' ? 'نتیجه‌ای یافت نشد.' : 'هنوز نکته‌ای ساخته نشده است.'}
          </p>
        </div>
      ) : (
        <div className="mt-4 space-y-3">
          {filtered.map((tip) => (
            <div key={tip.id} className="rounded-2xl border border-gray-100 bg-white p-5 shadow-card">
              <div className="flex items-start justify-between gap-2">
                <div className="flex-1">
                  <div className="flex items-center gap-2 flex-wrap">
                    <span className="inline-flex rounded-full bg-amber-50 px-2.5 py-0.5 text-[10px] font-medium text-amber-700">
                      {DIET_TIP_CATEGORY_LABELS[tip.category as DietTipCategory] ?? tip.category}
                    </span>
                    {!tip.is_active && (
                      <span className="inline-flex rounded-full bg-gray-100 px-2.5 py-0.5 text-[10px] font-medium text-gray-500">
                        غیرفعال
                      </span>
                    )}
                    <h3 className="text-sm font-semibold text-gray-800">{tip.title}</h3>
                  </div>
                  <p className="mt-1.5 text-sm leading-7 text-gray-600 whitespace-pre-wrap">{tip.body}</p>
                </div>
                <div className="flex items-center gap-1 shrink-0">
                  <button
                    onClick={() => onEdit(tip)}
                    className="p-1.5 rounded-lg text-gray-400 hover:text-amber-600 hover:bg-amber-50 transition-colors"
                    title="ویرایش"
                  >
                    <Pencil size={15} />
                  </button>
                  <button
                    onClick={() => onCopy(tip)}
                    disabled={saving}
                    className="p-1.5 rounded-lg text-gray-400 hover:text-blue-600 hover:bg-blue-50 transition-colors disabled:opacity-50"
                    title="کپی"
                  >
                    <Copy size={15} />
                  </button>
                  <button
                    onClick={() => setDeleteTarget(tip)}
                    className="p-1.5 rounded-lg text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors"
                    title="حذف"
                  >
                    <Trash2 size={15} />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {deleteTarget && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/30 p-4" onClick={() => setDeleteTarget(null)}>
          <div className="max-w-sm w-full bg-white rounded-2xl shadow-cardHover p-6" onClick={(e) => e.stopPropagation()}>
            <h3 className="text-base font-semibold text-gray-800">حذف نکته</h3>
            <p className="mt-2 text-sm text-gray-600 leading-7">
              آیا از حذف نکته «{deleteTarget.title}» مطمئن هستید؟ نکات قبلاً انتخاب‌شده در برنامه‌های شاگردان حذف نمی‌شوند.
            </p>
            <div className="mt-4 flex justify-start gap-2">
              <button
                onClick={() => {
                  onDelete(deleteTarget);
                  setDeleteTarget(null);
                }}
                disabled={saving}
                className="px-5 py-2.5 rounded-xl bg-red-600 text-white text-sm font-medium hover:bg-red-700 transition-colors disabled:opacity-50"
              >
                {saving ? 'در حال حذف...' : 'حذف کن'}
              </button>
              <button
                onClick={() => setDeleteTarget(null)}
                className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200 transition-colors"
              >
                انصراف
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

// --- Diet tip form ---

function DietTipForm({
  tip,
  onSave,
  onCancel,
  saving,
  error,
}: {
  tip: DietTip | null;
  onSave: (vals: { category: DietTipCategory; title: string; body: string; is_active: boolean }) => void;
  onCancel: () => void;
  saving: boolean;
  error: string | null;
}) {
  const [category, setCategory] = useState<DietTipCategory>(tip?.category as DietTipCategory ?? 'daily');
  const [title, setTitle] = useState(tip?.title ?? '');
  const [body, setBody] = useState(tip?.body ?? '');
  const [isActive, setIsActive] = useState(tip?.is_active ?? true);

  return (
    <div>
      <button
        onClick={onCancel}
        className="flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-700 mb-4"
      >
        بازگشت به کتابخانه نکات
      </button>

      <h1 className="text-2xl font-bold text-gray-800">
        {tip ? 'ویرایش نکته' : 'نکته جدید'}
      </h1>

      {error && (
        <div className="mt-3 rounded-xl border border-red-200 bg-red-50 px-4 py-2.5 text-sm text-red-700">
          {error}
        </div>
      )}

      <div className="mt-5 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
        <div className="flex flex-col gap-4">
          <div className="flex flex-col gap-1.5">
            <label className="text-sm font-medium text-gray-600">دسته‌بندی</label>
            <select
              value={category}
              onChange={(e) => setCategory(e.target.value as DietTipCategory)}
              className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-100 bg-white"
            >
              {(Object.keys(DIET_TIP_CATEGORY_LABELS) as DietTipCategory[]).map((c) => (
                <option key={c} value={c}>{DIET_TIP_CATEGORY_LABELS[c]}</option>
              ))}
            </select>
          </div>
          <div className="flex flex-col gap-1.5">
            <label className="text-sm font-medium text-gray-600">عنوان</label>
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="عنوان کوتاه نکته"
              className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-100"
            />
          </div>
          <div className="flex flex-col gap-1.5">
            <label className="text-sm font-medium text-gray-600">متن نکته</label>
            <textarea
              value={body}
              onChange={(e) => setBody(e.target.value)}
              placeholder="متن کامل نکته اجرایی..."
              rows={5}
              className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-100 resize-none leading-7"
            />
          </div>
          <label className="flex items-center gap-2 cursor-pointer">
            <input
              type="checkbox"
              checked={isActive}
              onChange={(e) => setIsActive(e.target.checked)}
              className="rounded border-gray-300 text-amber-500 focus:ring-amber-200"
            />
            <span className="text-sm text-gray-600">فعال (قابل انتخاب در برنامه‌ها)</span>
          </label>
        </div>
      </div>

      <div className="mt-4 flex justify-start gap-2">
        <button
          onClick={() => onSave({ category, title, body, is_active: isActive })}
          disabled={saving || !title.trim() || !body.trim()}
          className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-amber-500 text-white text-sm font-medium hover:bg-amber-600 transition-colors disabled:opacity-50"
        >
          {saving ? <Loader2 size={16} className="animate-spin" /> : <Save size={16} />}
          {saving ? 'در حال ذخیره...' : 'ذخیره نکته'}
        </button>
        <button
          onClick={onCancel}
          className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200 transition-colors"
        >
          انصراف
        </button>
      </div>
    </div>
  );
}
