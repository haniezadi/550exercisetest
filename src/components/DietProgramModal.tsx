import { useEffect, useMemo, useState } from 'react';
import { Apple, Plus, Trash2, ChevronUp, ChevronDown, Utensils, Lightbulb, Loader2 } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import type {
  Template,
  DietTemplateMeal,
  DietProgramMeal,
  DietProgramFoodItem,
  DietProgramTip,
  DietTip,
} from '@/lib/supabase';
import { DIET_PATTERNS, DIET_TIP_CATEGORY_LABELS, type DietTipCategory, type DietTipPdfMode } from '@/lib/supabase';

const PDF_MODE_LABELS: Record<DietTipPdfMode, string> = {
  full: 'PDF کامل + نکات',
  tips_only: 'فقط PDF نکات',
  none: 'بدون PDF',
};

export interface MealDraft {
  id: string; // temp or real uuid
  name: string;
  notes: string;
  fasting_start: string;
  fasting_end: string;
  foodItems: FoodItemDraft[];
}

export interface FoodItemDraft {
  id: string;
  name: string;
  amount: string;
  unit: string;
  is_raw: boolean | null;
  alternatives: string;
  notes: string;
}

export interface ProgramTipDraft {
  id: string;
  tip_id: string | null;
  custom_text: string;
  category: string;
  title: string;
  pdf_mode: DietTipPdfMode;
}

export interface DietSaveData {
  templateId: string | null;
  description: string;
  targetCalories: number | null;
  targetProteinG: number | null;
  pattern: string | null;
  meals: MealDraft[];
  tips: ProgramTipDraft[];
}

let _seq = 0;
function tmpId() {
  _seq += 1;
  return `_tmp_${Date.now()}_${_seq}`;
}

export default function DietProgramModal({
  open,
  templates,
  dietTemplateMeals,
  dietTips,
  existingProgramId,
  existingTemplateId,
  existingDescription,
  existingTargetCalories,
  existingTargetProteinG,
  existingPattern,
  existingMeals,
  existingFoodItemsByMeal,
  existingTips,
  onSave,
  onClose,
  saving,
}: {
  open: boolean;
  templates: Template[];
  dietTemplateMeals: DietTemplateMeal[];
  dietTips: DietTip[];
  existingProgramId: string | null;
  existingTemplateId: string | null;
  existingDescription: string;
  existingTargetCalories: number | null;
  existingTargetProteinG: number | null;
  existingPattern: string | null;
  existingMeals: DietProgramMeal[];
  existingFoodItemsByMeal: Map<string, DietProgramFoodItem[]>;
  existingTips: DietProgramTip[];
  onSave: (data: DietSaveData) => void;
  onClose: () => void;
  saving: boolean;
}) {
  const [selectedTemplateId, setSelectedTemplateId] = useState<string | null>(null);
  const [description, setDescription] = useState('');
  const [targetCalories, setTargetCalories] = useState('');
  const [targetProteinG, setTargetProteinG] = useState('');
  const [pattern, setPattern] = useState<string | null>(null);
  const [meals, setMeals] = useState<MealDraft[]>([]);
  const [tips, setTips] = useState<ProgramTipDraft[]>([]);
  const [showTipPicker, setShowTipPicker] = useState(false);

  useEffect(() => {
    if (!open) return;
    setSelectedTemplateId(existingTemplateId);
    setDescription(existingDescription);
    setTargetCalories(existingTargetCalories != null ? String(existingTargetCalories) : '');
    setTargetProteinG(existingTargetProteinG != null ? String(existingTargetProteinG) : '');
    setPattern(existingPattern ?? null);
    setMeals(
      existingMeals.map((m) => ({
        id: m.id,
        name: m.name,
        notes: m.notes,
        fasting_start: m.fasting_start,
        fasting_end: m.fasting_end,
        foodItems: (existingFoodItemsByMeal.get(m.id) ?? []).map((f) => ({
          id: f.id,
          name: f.name,
          amount: f.amount,
          unit: f.unit,
          is_raw: f.is_raw,
          alternatives: f.alternatives,
          notes: f.notes,
        })),
      })),
    );
    setTips(
      existingTips.map((t) => {
        const tip = dietTips.find((d) => d.id === t.tip_id);
        return {
          id: t.id,
          tip_id: t.tip_id,
          custom_text: t.custom_text,
          category: tip?.category ?? 'custom',
          title: tip?.title ?? '',
          pdf_mode: t.pdf_mode ?? 'full',
        };
      }),
    );
  }, [open, existingTemplateId, existingDescription, existingTargetCalories, existingTargetProteinG, existingPattern, existingMeals, existingFoodItemsByMeal, existingTips, dietTips]);

  const loadTemplate = (templateId: string) => {
    const tplMeals = dietTemplateMeals
      .filter((m) => m.template_id === templateId)
      .sort((a, b) => a.sort_order - b.sort_order);
    // We need to fetch template food items — but we don't have them in props.
    // The parent (App) will pass them via a callback. For now, load meals only;
    // food items will be fetched and loaded through the onSave flow.
    // Actually, we need to load food items here. Let's fetch them.
    // But to keep it simple, we'll load meals and empty food items, then
    // the parent's handleDietSave will handle persistence. The coach can
    // add food items manually. But that's not ideal...
    //
    // Better approach: the parent passes a function to fetch template food items.
    // But that complicates the interface. Instead, let's fetch them here.
    void supabase
      .from('diet_template_food_items')
      .select('*, meal_id')
      .in('meal_id', tplMeals.map((m) => m.id))
      .order('sort_order', { ascending: true })
      .then(({ data }: { data: DietTemplateMealFoodItemRow[] | null }) => {
        const foodByMeal = new Map<string, FoodItemDraft[]>();
        for (const f of data ?? []) {
          const arr = foodByMeal.get(f.meal_id) ?? [];
          arr.push({
            id: tmpId(),
            name: f.name,
            amount: f.amount,
            unit: f.unit,
            is_raw: f.is_raw,
            alternatives: f.alternatives,
            notes: f.notes,
          });
          foodByMeal.set(f.meal_id, arr);
        }
        setMeals(
          tplMeals.map((m) => ({
            id: tmpId(),
            name: m.name,
            notes: m.notes,
            fasting_start: m.fasting_start,
            fasting_end: m.fasting_end,
            foodItems: foodByMeal.get(m.id) ?? [],
          })),
        );
      });
  };

  const handleSelectTemplate = (templateId: string | null) => {
    setSelectedTemplateId(templateId === selectedTemplateId ? null : templateId);
    if (templateId && templateId !== selectedTemplateId) {
      const tpl = templates.find((t) => t.id === templateId);
      if (tpl?.description && !description) setDescription(tpl.description);
      loadTemplate(templateId);
    }
  };

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

  const addTipToProgram = (tip: DietTip) => {
    setTips((prev) => [
      ...prev,
      {
        id: tmpId(),
        tip_id: tip.id,
        custom_text: tip.body,
        category: tip.category,
        title: tip.title,
        pdf_mode: 'full' as DietTipPdfMode,
      },
    ]);
    setShowTipPicker(false);
  };

  const updateTipPdfMode = (id: string, mode: DietTipPdfMode) => {
    setTips((prev) => prev.map((t) => (t.id === id ? { ...t, pdf_mode: mode } : t)));
  };

  const updateProgramTip = (id: string, text: string) => {
    setTips((prev) => prev.map((t) => (t.id === id ? { ...t, custom_text: text } : t)));
  };

  const removeProgramTip = (id: string) => {
    setTips((prev) => prev.filter((t) => t.id !== id));
  };

  const moveProgramTip = (index: number, dir: -1 | 1) => {
    setTips((prev) => {
      const arr = [...prev];
      const ni = index + dir;
      if (ni < 0 || ni >= arr.length) return arr;
      [arr[index], arr[ni]] = [arr[ni], arr[index]];
      return arr;
    });
  };

  const handleSave = () => {
    onSave({
      templateId: selectedTemplateId,
      description: description.trim(),
      targetCalories: targetCalories ? Number(targetCalories) : null,
      targetProteinG: targetProteinG ? Number(targetProteinG) : null,
      pattern,
      meals,
      tips,
    });
  };

  const activeTips = useMemo(() => dietTips.filter((t) => t.is_active), [dietTips]);

  if (!open) return null;

  return (
    <div className="flex flex-col gap-4">
      <div className="flex items-center gap-2">
        <Apple size={18} className="text-brand-600" />
        <h3 className="text-sm font-semibold text-gray-800">برنامه غذایی</h3>
      </div>

      {/* Diet pattern selector */}
      <div>
        <label className="text-xs font-medium text-gray-500 mb-1.5 block">الگوی رژیم</label>
        <select
          value={pattern ?? ''}
          onChange={(e) => setPattern(e.target.value || null)}
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 bg-white"
        >
          <option value="">— انتخاب الگو —</option>
          {DIET_PATTERNS.map((p) => (
            <option key={p} value={p}>{p}</option>
          ))}
        </select>
      </div>

      {/* Target calories & protein */}
      <div className="grid grid-cols-2 gap-3">
        <div>
          <label className="text-xs font-medium text-gray-500 mb-1.5 block">کالری هدف روزانه</label>
          <input
            type="number"
            value={targetCalories}
            onChange={(e) => setTargetCalories(e.target.value)}
            placeholder="مثال: ۱۸۰۰"
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
          />
        </div>
        <div>
          <label className="text-xs font-medium text-gray-500 mb-1.5 block">پروتئین هدف (گرم)</label>
          <input
            type="number"
            value={targetProteinG}
            onChange={(e) => setTargetProteinG(e.target.value)}
            placeholder="مثال: ۱۵۰"
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
          />
        </div>
      </div>

      {/* Template selector */}
      <div>
        <label className="text-xs font-medium text-gray-500 mb-2 block">انتخاب از قالب‌های غذایی (نقطه شروع)</label>
        {templates.length === 0 ? (
          <p className="text-xs text-gray-400 rounded-lg bg-gray-50 p-3">قالب غذایی موجود نیست.</p>
        ) : (
          <div className="space-y-2 max-h-40 overflow-y-auto">
            {templates.map((t) => {
              const mealCount = dietTemplateMeals.filter((m) => m.template_id === t.id).length;
              return (
                <button
                  key={t.id}
                  type="button"
                  onClick={() => handleSelectTemplate(t.id)}
                  className={`w-full text-right rounded-xl border p-3 transition-all ${
                    selectedTemplateId === t.id
                      ? 'border-brand-500 bg-brand-50 ring-2 ring-brand-100'
                      : 'border-gray-200 bg-white hover:border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <div className="flex items-start justify-between gap-2">
                    <div>
                      <h4 className="text-sm font-semibold text-gray-800">{t.name}</h4>
                      {mealCount > 0 && (
                        <span className="text-[10px] text-brand-600">{mealCount} وعده</span>
                      )}
                    </div>
                  </div>
                  {t.description && (
                    <p className="mt-1 text-xs leading-6 text-gray-500">{t.description}</p>
                  )}
                </button>
              );
            })}
          </div>
        )}
        <p className="mt-1.5 text-[10px] text-gray-400 leading-5">
          انتخاب قالب فقط نقطه شروع است. می‌توانید وعده‌ها، غذاها، کالری و نکات را برای هر شاگرد تغییر دهید. تغییر قالب برنامه قبلی شاگردان را تغییر نمی‌دهد.
        </p>
      </div>

      {/* Meals section */}
      <div className="border-t border-gray-100 pt-4">
        <div className="flex items-center justify-between mb-3">
          <div className="flex items-center gap-1.5">
            <Utensils size={15} className="text-gray-500" />
            <span className="text-sm font-semibold text-gray-700">وعده‌های غذایی</span>
          </div>
          <button
            type="button"
            onClick={addMeal}
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
                    onChange={(e) => updateMeal(meal.id, { name: e.target.value })}
                    placeholder="نام وعده (مثال: صبحانه)"
                    className="flex-1 rounded-lg border border-gray-200 px-3 py-2 text-sm font-medium outline-none focus:border-brand-500 focus:ring-1 focus:ring-brand-100"
                  />
                  <div className="flex items-center gap-0.5">
                    <button type="button" onClick={() => moveMeal(mi, -1)} disabled={mi === 0} className="p-1 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                      <ChevronUp size={16} />
                    </button>
                    <button type="button" onClick={() => moveMeal(mi, 1)} disabled={mi === meals.length - 1} className="p-1 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                      <ChevronDown size={16} />
                    </button>
                    <button type="button" onClick={() => removeMeal(meal.id)} className="p-1 rounded text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors">
                      <Trash2 size={15} />
                    </button>
                  </div>
                </div>

                {/* Fasting window (only show if pattern is fasting) */}
                {pattern === 'فستینگ متناوب' && (
                  <div className="mt-2 grid grid-cols-2 gap-2">
                    <input
                      type="text"
                      value={meal.fasting_start}
                      onChange={(e) => updateMeal(meal.id, { fasting_start: e.target.value })}
                      placeholder="شروع بازه ناشتایی (مثال: ۲۲:۰۰)"
                      className="rounded-lg border border-gray-200 px-3 py-1.5 text-xs outline-none focus:border-brand-500"
                    />
                    <input
                      type="text"
                      value={meal.fasting_end}
                      onChange={(e) => updateMeal(meal.id, { fasting_end: e.target.value })}
                      placeholder="پایان بازه ناشتایی (مثال: ۱۴:۰۰)"
                      className="rounded-lg border border-gray-200 px-3 py-1.5 text-xs outline-none focus:border-brand-500"
                    />
                  </div>
                )}

                <input
                  type="text"
                  value={meal.notes}
                  onChange={(e) => updateMeal(meal.id, { notes: e.target.value })}
                  placeholder="نکات وعده (اختیاری)"
                  className="mt-2 w-full rounded-lg border border-gray-200 px-3 py-1.5 text-xs outline-none focus:border-brand-500"
                />

                {/* Food items */}
                <div className="mt-2 space-y-1.5">
                  {meal.foodItems.map((f, fi) => (
                    <div key={f.id} className="rounded-lg border border-gray-100 bg-white p-2.5">
                      <div className="flex items-center gap-2">
                        <input
                          type="text"
                          value={f.name}
                          onChange={(e) => updateFoodItem(meal.id, f.id, { name: e.target.value })}
                          placeholder="نام ماده غذایی"
                          className="flex-1 rounded-md border border-gray-200 px-2.5 py-1.5 text-xs outline-none focus:border-brand-500"
                        />
                        <div className="flex items-center gap-0.5">
                          <button type="button" onClick={() => moveFoodItem(meal.id, fi, -1)} disabled={fi === 0} className="p-0.5 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                            <ChevronUp size={14} />
                          </button>
                          <button type="button" onClick={() => moveFoodItem(meal.id, fi, 1)} disabled={fi === meal.foodItems.length - 1} className="p-0.5 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                            <ChevronDown size={14} />
                          </button>
                          <button type="button" onClick={() => removeFoodItem(meal.id, f.id)} className="p-0.5 rounded text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors">
                            <Trash2 size={14} />
                          </button>
                        </div>
                      </div>
                      <div className="mt-1.5 flex items-center gap-2">
                        <input
                          type="text"
                          value={f.amount}
                          onChange={(e) => updateFoodItem(meal.id, f.id, { amount: e.target.value })}
                          placeholder="مقدار"
                          className="w-20 rounded-md border border-gray-200 px-2 py-1 text-xs outline-none focus:border-brand-500"
                        />
                        <input
                          type="text"
                          value={f.unit}
                          onChange={(e) => updateFoodItem(meal.id, f.id, { unit: e.target.value })}
                          placeholder="واحد (گرم، پیمانه...)"
                          className="w-28 rounded-md border border-gray-200 px-2 py-1 text-xs outline-none focus:border-brand-500"
                        />
                        <select
                          value={f.is_raw === null ? '' : f.is_raw ? 'raw' : 'cooked'}
                          onChange={(e) =>
                            updateFoodItem(meal.id, f.id, {
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
                        onChange={(e) => updateFoodItem(meal.id, f.id, { alternatives: e.target.value })}
                        placeholder="جایگزین‌ها (اختیاری)"
                        className="mt-1.5 w-full rounded-md border border-gray-200 px-2.5 py-1 text-xs outline-none focus:border-brand-500"
                      />
                      <input
                        type="text"
                        value={f.notes}
                        onChange={(e) => updateFoodItem(meal.id, f.id, { notes: e.target.value })}
                        placeholder="نکته (اختیاری)"
                        className="mt-1 w-full rounded-md border border-gray-200 px-2.5 py-1 text-xs outline-none focus:border-brand-500"
                      />
                    </div>
                  ))}
                  <button
                    type="button"
                    onClick={() => addFoodItem(meal.id)}
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
      </div>

      {/* Diet tips section */}
      <div className="border-t border-gray-100 pt-4">
        <div className="flex items-center justify-between mb-3">
          <div className="flex items-center gap-1.5">
            <Lightbulb size={15} className="text-amber-500" />
            <span className="text-sm font-semibold text-gray-700">نکات اجرایی</span>
          </div>
          <button
            type="button"
            onClick={() => setShowTipPicker((v) => !v)}
            className="flex items-center gap-1 rounded-lg bg-amber-50 px-2.5 py-1.5 text-xs font-medium text-amber-700 hover:bg-amber-100 transition-colors"
          >
            <Plus size={13} />
            افزودن نکته
          </button>
        </div>

        {showTipPicker && (
          <div className="mb-3 max-h-48 overflow-y-auto rounded-xl border border-gray-200 bg-white p-2 space-y-1">
            {activeTips.length === 0 ? (
              <p className="text-xs text-gray-400 p-3 text-center">نکته‌ای در کتابخانه موجود نیست.</p>
            ) : (
              activeTips.map((tip) => (
                <button
                  key={tip.id}
                  type="button"
                  onClick={() => addTipToProgram(tip)}
                  className="w-full text-right rounded-lg p-2 hover:bg-amber-50 transition-colors"
                >
                  <span className="text-[10px] text-amber-600 font-medium">
                    {DIET_TIP_CATEGORY_LABELS[tip.category as DietTipCategory] ?? tip.category}
                  </span>
                  <p className="text-xs font-medium text-gray-700">{tip.title}</p>
                  <p className="text-[10px] text-gray-400 leading-5 line-clamp-2">{tip.body}</p>
                </button>
              ))
            )}
          </div>
        )}

        {tips.length === 0 ? (
          <p className="text-xs text-gray-400 rounded-lg bg-gray-50 p-3 text-center">
            نکته‌ای انتخاب نشده است.
          </p>
        ) : (
          <div className="space-y-2">
            {tips.map((t, ti) => (
              <div key={t.id} className="rounded-lg border border-gray-100 bg-white p-3">
                <div className="flex items-center justify-between gap-2 mb-1.5">
                  <div className="flex items-center gap-2">
                    <span className="text-[10px] rounded-full bg-amber-50 px-2 py-0.5 text-amber-700 font-medium">
                      {DIET_TIP_CATEGORY_LABELS[t.category as DietTipCategory] ?? t.category}
                    </span>
                    {t.title && <span className="text-xs font-semibold text-gray-700">{t.title}</span>}
                  </div>
                  <div className="flex items-center gap-0.5">
                    <button type="button" onClick={() => moveProgramTip(ti, -1)} disabled={ti === 0} className="p-0.5 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                      <ChevronUp size={14} />
                    </button>
                    <button type="button" onClick={() => moveProgramTip(ti, 1)} disabled={ti === tips.length - 1} className="p-0.5 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30">
                      <ChevronDown size={14} />
                    </button>
                    <button type="button" onClick={() => removeProgramTip(t.id)} className="p-0.5 rounded text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors">
                      <Trash2 size={14} />
                    </button>
                  </div>
                </div>
                <textarea
                  value={t.custom_text}
                  onChange={(e) => updateProgramTip(t.id, e.target.value)}
                  rows={2}
                  className="w-full rounded-md border border-gray-200 px-2.5 py-1.5 text-xs leading-6 outline-none focus:border-brand-500 resize-none"
                />
                <div className="mt-1.5 flex items-center gap-1.5">
                  <span className="text-[10px] text-gray-400 shrink-0">نمایش در PDF:</span>
                  <select
                    value={t.pdf_mode}
                    onChange={(e) => updateTipPdfMode(t.id, e.target.value as DietTipPdfMode)}
                    className="rounded-md border border-gray-200 px-2 py-0.5 text-[10px] outline-none focus:border-brand-500 bg-white"
                  >
                    {(Object.keys(PDF_MODE_LABELS) as DietTipPdfMode[]).map((m) => (
                      <option key={m} value={m}>{PDF_MODE_LABELS[m]}</option>
                    ))}
                  </select>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Free-text description (preserved from old system) */}
      <div>
        <label className="text-xs font-medium text-gray-500 mb-1.5 block">توضیحات تکمیلی برنامه غذایی</label>
        <textarea
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="توضیحات اختصاصی مربی..."
          rows={3}
          className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100 resize-none leading-7"
        />
      </div>

      {/* Actions */}
      <div className="flex justify-start gap-2 pt-2 border-t border-gray-100">
        <button
          type="button"
          onClick={handleSave}
          disabled={saving}
          className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 transition-colors disabled:opacity-50"
        >
          {saving ? <Loader2 size={16} className="animate-spin" /> : null}
          {saving ? 'در حال ذخیره...' : 'ذخیره برنامه غذایی'}
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

interface DietTemplateMealFoodItemRow {
  id: string;
  meal_id: string;
  sort_order: number;
  name: string;
  amount: string;
  unit: string;
  is_raw: boolean | null;
  alternatives: string;
  notes: string;
}
