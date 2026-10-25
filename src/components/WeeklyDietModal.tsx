import { useEffect, useMemo, useState } from 'react';
import { Plus, Trash2, ChevronUp, ChevronDown, Utensils, Loader as Loader2, Copy, X, Apple } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import type { Food, WeeklyDietProgram, WeeklyDietMeal, WeeklyDietFoodItem, DayOfWeek, MealType, MealSubstitution, MealSubstitutionFoodItem } from '@/lib/supabase';
import { DAY_OF_WEEK_LABELS, MEAL_TYPE_LABELS, FAVORITE_FOOD_CATEGORY_LABELS, type FavoriteFoodCategory } from '@/lib/supabase';

const ALL_MEAL_TYPES: MealType[] = ['breakfast', 'lunch', 'dinner', 'snack', 'pre_workout', 'post_workout'];

let _seq = 0;
function tmpId() { _seq += 1; return `_tmp_${Date.now()}_${_seq}`; }

export interface WeeklyFoodItemDraft {
  id: string;
  food_id: string | null;
  name: string;
  amount: string;
  unit: string;
  household_unit: string;
  household_grams: string;
  is_raw: boolean;
  calories: string;
  protein_g: string;
  notes: string;
}

export interface WeeklyMealDraft {
  id: string;
  day_of_week: DayOfWeek;
  meal_type: MealType;
  meal_name: string;
  is_active: boolean;
  notes: string;
  foodItems: WeeklyFoodItemDraft[];
  substitutions: MealSubDraft[];
}

export interface MealSubDraft {
  id: string;
  substitution_name: string;
  notes: string;
  foodItems: WeeklyFoodItemDraft[];
}

export interface WeeklyDietSaveData {
  meals: WeeklyMealDraft[];
  targetCalories: number | null;
  targetProteinG: number | null;
  pattern: string | null;
  cheatMealEnabled: boolean;
  cheatMealName: string;
  cheatMealAmount: string;
  cheatMealPlacement: string;
  cheatMealNotes: string;
}

export default function WeeklyDietModal({
  open,
  programId,
  existingProgram,
  existingMeals,
  existingFoodItemsByMeal,
  existingSubstitutionsByMeal,
  existingSubFoodItemsBySub,
  existingCheatMeal,
  foods,
  favoriteFoods,
  existingTargetCalories,
  existingTargetProteinG,
  existingPattern,
  onSave,
  onClose,
  saving,
}: {
  open: boolean;
  programId: string | null;
  existingProgram: WeeklyDietProgram | null;
  existingMeals: WeeklyDietMeal[];
  existingFoodItemsByMeal: Map<string, WeeklyDietFoodItem[]>;
  existingSubstitutionsByMeal: Map<string, MealSubstitution[]>;
  existingSubFoodItemsBySub: Map<string, MealSubstitutionFoodItem[]>;
  existingCheatMeal: { is_enabled: boolean; food_name: string; amount: string; placement: string; notes: string } | null;
  foods: Food[];
  favoriteFoods: { category: FavoriteFoodCategory; food_name: string }[];
  existingTargetCalories: number | null;
  existingTargetProteinG: number | null;
  existingPattern: string | null;
  onSave: (data: WeeklyDietSaveData) => void;
  onClose: () => void;
  saving: boolean;
}) {
  const [meals, setMeals] = useState<WeeklyMealDraft[]>([]);
  const [targetCalories, setTargetCalories] = useState('');
  const [targetProteinG, setTargetProteinG] = useState('');
  const [pattern, setPattern] = useState<string | null>(null);
  const [activeMealTypes, setActiveMealTypes] = useState<Set<MealType>>(new Set(['breakfast', 'lunch', 'dinner']));
  const [cheatEnabled, setCheatEnabled] = useState(false);
  const [cheatName, setCheatName] = useState('');
  const [cheatAmount, setCheatAmount] = useState('');
  const [cheatPlacement, setCheatPlacement] = useState('');
  const [cheatNotes, setCheatNotes] = useState('');
  const [copySource, setCopySource] = useState<string>('');
  const [copyTarget, setCopyTarget] = useState<string>('');

  useEffect(() => {
    if (!open || !programId) return;
    setTargetCalories(existingTargetCalories != null ? String(existingTargetCalories) : '');
    setTargetProteinG(existingTargetProteinG != null ? String(existingTargetProteinG) : '');
    setPattern(existingPattern ?? null);
    setCheatEnabled(existingCheatMeal?.is_enabled ?? false);
    setCheatName(existingCheatMeal?.food_name ?? '');
    setCheatAmount(existingCheatMeal?.amount ?? '');
    setCheatPlacement(existingCheatMeal?.placement ?? '');
    setCheatNotes(existingCheatMeal?.notes ?? '');

    // Build meal drafts from existing data
    const mealTypes = new Set<MealType>();
    const drafts: WeeklyMealDraft[] = [];
    for (const day of DAY_OF_WEEK_LABELS) {
      for (const mt of ALL_MEAL_TYPES) {
        const existing = existingMeals.find(m => m.day_of_week === day && m.meal_type === mt);
        if (existing) {
          mealTypes.add(mt);
          const foods = existingFoodItemsByMeal.get(existing.id) ?? [];
          const subs = existingSubstitutionsByMeal.get(existing.id) ?? [];
          drafts.push({
            id: existing.id,
            day_of_week: day,
            meal_type: mt,
            meal_name: existing.meal_name,
            is_active: existing.is_active,
            notes: existing.notes,
            foodItems: foods.map(f => ({
              id: f.id, food_id: f.food_id, name: f.name, amount: f.amount,
              unit: f.unit, household_unit: f.household_unit,
              household_grams: f.household_grams != null ? String(f.household_grams) : '',
              is_raw: f.is_raw, calories: f.calories != null ? String(f.calories) : '',
              protein_g: f.protein_g != null ? String(f.protein_g) : '', notes: f.notes,
            })),
            substitutions: subs.map(s => ({
              id: s.id, substitution_name: s.substitution_name, notes: s.notes,
              foodItems: (existingSubFoodItemsBySub.get(s.id) ?? []).map(f => ({
                id: f.id, food_id: f.food_id, name: f.name, amount: f.amount,
                unit: f.unit, household_unit: f.household_unit,
                household_grams: f.household_grams != null ? String(f.household_grams) : '',
                is_raw: f.is_raw, calories: f.calories != null ? String(f.calories) : '',
                protein_g: f.protein_g != null ? String(f.protein_g) : '', notes: f.notes,
              })),
            })),
          });
        }
      }
    }
    setActiveMealTypes(mealTypes.size > 0 ? mealTypes : new Set(['breakfast', 'lunch', 'dinner']));
    setMeals(drafts);
  }, [open, programId, existingMeals, existingFoodItemsByMeal, existingSubstitutionsByMeal, existingSubFoodItemsBySub, existingCheatMeal, existingTargetCalories, existingTargetProteinG, existingPattern]);

  // Ensure meals exist for all active types x all days
  useEffect(() => {
    if (!open) return;
    setMeals(prev => {
      const next = [...prev];
      for (const day of DAY_OF_WEEK_LABELS) {
        for (const mt of activeMealTypes) {
          if (!next.find(m => m.day_of_week === day && m.meal_type === mt)) {
            next.push({
              id: tmpId(), day_of_week: day, meal_type: mt,
              meal_name: MEAL_TYPE_LABELS[mt], is_active: true, notes: '',
              foodItems: [], substitutions: [],
            });
          }
        }
      }
      return next.filter(m => activeMealTypes.has(m.meal_type));
    });
  }, [open, activeMealTypes]);

  const toggleMealType = (mt: MealType) => {
    setActiveMealTypes(prev => {
      const next = new Set(prev);
      if (next.has(mt)) next.delete(mt);
      else next.add(mt);
      return next;
    });
  };

  const updateMeal = (id: string, patch: Partial<WeeklyMealDraft>) => {
    setMeals(prev => prev.map(m => m.id === id ? { ...m, ...patch } : m));
  };

  const addFoodItem = (mealId: string) => {
    setMeals(prev => prev.map(m => m.id === mealId ? {
      ...m, foodItems: [...m.foodItems, { id: tmpId(), food_id: null, name: '', amount: '', unit: 'گرم', household_unit: '', household_grams: '', is_raw: true, calories: '', protein_g: '', notes: '' }],
    } : m));
  };

  const updateFoodItem = (mealId: string, foodId: string, patch: Partial<WeeklyFoodItemDraft>) => {
    setMeals(prev => prev.map(m => {
      if (m.id !== mealId) return m;
      return { ...m, foodItems: m.foodItems.map(f => f.id === foodId ? { ...f, ...patch } : f) };
    }));
  };

  const removeFoodItem = (mealId: string, foodId: string) => {
    setMeals(prev => prev.map(m => m.id === mealId ? { ...m, foodItems: m.foodItems.filter(f => f.id !== foodId) } : m));
  };

  const moveFoodItem = (mealId: string, index: number, dir: -1 | 1) => {
    setMeals(prev => prev.map(m => {
      if (m.id !== mealId) return m;
      const arr = [...m.foodItems];
      const ni = index + dir;
      if (ni < 0 || ni >= arr.length) return m;
      [arr[index], arr[ni]] = [arr[ni], arr[index]];
      return { ...m, foodItems: arr };
    }));
  };

  // Food selection from bank
  const selectFoodFromBank = (mealId: string, foodId: string) => {
    const food = foods.find(f => f.id === foodId);
    if (!food) return;
    updateFoodItem(mealId, mealId, {});
    // Add new item with food data
    setMeals(prev => prev.map(m => m.id === mealId ? {
      ...m, foodItems: [...m.foodItems, {
        id: tmpId(), food_id: food.id, name: food.name, amount: '100', unit: food.default_unit,
        household_unit: food.household_unit ?? '', household_grams: food.household_unit_grams != null ? String(food.household_unit_grams) : '',
        is_raw: food.is_raw, calories: food.calories_per_100g != null ? String(food.calories_per_100g) : '',
        protein_g: food.protein_per_100g != null ? String(food.protein_per_100g) : '', notes: '',
      }],
    } : m));
  };

  // Substitution handlers
  const addSubstitution = (mealId: string) => {
    setMeals(prev => prev.map(m => m.id === mealId ? {
      ...m, substitutions: [...m.substitutions, { id: tmpId(), substitution_name: '', notes: '', foodItems: [] }],
    } : m));
  };

  const updateSubstitution = (mealId: string, subId: string, patch: Partial<MealSubDraft>) => {
    setMeals(prev => prev.map(m => m.id !== mealId ? m : {
      ...m, substitutions: m.substitutions.map(s => s.id === subId ? { ...s, ...patch } : s),
    }));
  };

  const removeSubstitution = (mealId: string, subId: string) => {
    setMeals(prev => prev.map(m => m.id !== mealId ? m : { ...m, substitutions: m.substitutions.filter(s => s.id !== subId) }));
  };

  const addSubFoodItem = (mealId: string, subId: string) => {
    setMeals(prev => prev.map(m => {
      if (m.id !== mealId) return m;
      return { ...m, substitutions: m.substitutions.map(s => s.id === subId ? {
        ...s, foodItems: [...s.foodItems, { id: tmpId(), food_id: null, name: '', amount: '', unit: 'گرم', household_unit: '', household_grams: '', is_raw: true, calories: '', protein_g: '', notes: '' }],
      } : s) };
    }));
  };

  const updateSubFoodItem = (mealId: string, subId: string, foodId: string, patch: Partial<WeeklyFoodItemDraft>) => {
    setMeals(prev => prev.map(m => {
      if (m.id !== mealId) return m;
      return { ...m, substitutions: m.substitutions.map(s => s.id !== subId ? s : {
        ...s, foodItems: s.foodItems.map(f => f.id === foodId ? { ...f, ...patch } : f),
      }) };
    }));
  };

  const removeSubFoodItem = (mealId: string, subId: string, foodId: string) => {
    setMeals(prev => prev.map(m => {
      if (m.id !== mealId) return m;
      return { ...m, substitutions: m.substitutions.map(s => s.id !== subId ? s : {
        ...s, foodItems: s.foodItems.filter(f => f.id !== foodId),
      }) };
    }));
  };

  // Copy day or meal
  const doCopy = () => {
    if (!copySource || !copyTarget) return;
    // Source can be "day:شنبه" or "meal:شنبه:breakfast"
    if (copySource.startsWith('day:') && copyTarget.startsWith('day:')) {
      const srcDay = copySource.split(':')[1] as DayOfWeek;
      const tgtDay = copyTarget.split(':')[1] as DayOfWeek;
      setMeals(prev => {
        const srcMeals = prev.filter(m => m.day_of_week === srcDay);
        return prev.map(m => {
          if (m.day_of_week !== tgtDay) return m;
          const src = srcMeals.find(s => s.meal_type === m.meal_type);
          return src ? { ...m, foodItems: src.foodItems.map(f => ({ ...f, id: tmpId() })), substitutions: src.substitutions.map(s => ({ ...s, id: tmpId(), foodItems: s.foodItems.map(f => ({ ...f, id: tmpId() })) })), meal_name: src.meal_name, notes: src.notes } : m;
        });
      });
    }
    setCopySource('');
    setCopyTarget('');
  };

  // Calculate daily calorie/protein sums
  const dayTotals = useMemo(() => {
    const totals: Record<string, { calories: number; protein: number }> = {};
    for (const day of DAY_OF_WEEK_LABELS) {
      let cal = 0, prot = 0;
      for (const meal of meals.filter(m => m.day_of_week === day && m.is_active)) {
        for (const f of meal.foodItems) {
          if (f.calories && f.amount) {
            const amt = Number(f.amount) || 0;
            const calPer100 = Number(f.calories) || 0;
            cal += (calPer100 * amt) / 100;
          }
          if (f.protein_g && f.amount) {
            const amt = Number(f.amount) || 0;
            const protPer100 = Number(f.protein_g) || 0;
            prot += (protPer100 * amt) / 100;
          }
        }
      }
      totals[day] = { calories: Math.round(cal), protein: Math.round(prot) };
    }
    return totals;
  }, [meals]);

  if (!open) return null;

  const targetCal = targetCalories ? Number(targetCalories) : null;
  const targetProt = targetProteinG ? Number(targetProteinG) : null;

  return (
    <div className="flex flex-col gap-4">
      <div className="flex items-center gap-2">
        <Apple size={18} className="text-brand-600" />
        <h3 className="text-sm font-semibold text-gray-800">برنامه غذایی هفتگی</h3>
      </div>

      {/* Targets */}
      <div className="grid grid-cols-3 gap-3">
        <div>
          <label className="text-xs font-medium text-gray-500 mb-1.5 block">کالری هدف روزانه</label>
          <input type="number" value={targetCalories} onChange={(e) => setTargetCalories(e.target.value)} placeholder="مثال: ۱۸۰۰" className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500" />
        </div>
        <div>
          <label className="text-xs font-medium text-gray-500 mb-1.5 block">پروتئین هدف (گرم)</label>
          <input type="number" value={targetProteinG} onChange={(e) => setTargetProteinG(e.target.value)} placeholder="مثال: ۱۵۰" className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500" />
        </div>
        <div>
          <label className="text-xs font-medium text-gray-500 mb-1.5 block">الگوی رژیم</label>
          <select value={pattern ?? ''} onChange={(e) => setPattern(e.target.value || null)} className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 bg-white">
            <option value="">— انتخاب —</option>
            <option value="معمولی و انعطاف‌پذیر">معمولی و انعطاف‌پذیر</option>
            <option value="فستینگ متناوب">فستینگ متناوب</option>
            <option value="کربوسایکلینگ">کربوسایکلینگ</option>
            <option value="پروتئین بالا">پروتئین بالا</option>
            <option value="سفارشی">سفارشی</option>
          </select>
        </div>
      </div>

      {/* Meal type toggles */}
      <div>
        <label className="text-xs font-medium text-gray-500 mb-2 block">وعده‌های فعال</label>
        <div className="flex flex-wrap gap-2">
          {ALL_MEAL_TYPES.map((mt) => (
            <button key={mt} type="button" onClick={() => toggleMealType(mt)}
              className={`rounded-lg px-3 py-1.5 text-xs font-medium transition-colors ${activeMealTypes.has(mt) ? 'bg-brand-100 text-brand-700' : 'bg-gray-100 text-gray-400'}`}>
              {MEAL_TYPE_LABELS[mt]}
            </button>
          ))}
        </div>
      </div>

      {/* Copy feature */}
      <div className="flex items-center gap-2 rounded-xl border border-gray-100 bg-gray-50/40 p-3">
        <Copy size={14} className="text-gray-400" />
        <select value={copySource} onChange={(e) => setCopySource(e.target.value)} className="rounded-lg border border-gray-200 bg-white px-2.5 py-1.5 text-xs outline-none focus:border-brand-500">
          <option value="">کپی از...</option>
          {DAY_OF_WEEK_LABELS.map(d => <option key={d} value={`day:${d}`}>روز {d}</option>)}
        </select>
        <span className="text-gray-400 text-xs">→</span>
        <select value={copyTarget} onChange={(e) => setCopyTarget(e.target.value)} className="rounded-lg border border-gray-200 bg-white px-2.5 py-1.5 text-xs outline-none focus:border-brand-500">
          <option value="">به...</option>
          {DAY_OF_WEEK_LABELS.map(d => <option key={d} value={`day:${d}`}>روز {d}</option>)}
        </select>
        <button type="button" onClick={doCopy} disabled={!copySource || !copyTarget} className="rounded-lg bg-brand-50 px-3 py-1.5 text-xs font-medium text-brand-700 hover:bg-brand-100 disabled:opacity-40 transition-colors">
          کپی کن
        </button>
      </div>

      {/* Weekly grid */}
      <div className="space-y-3 max-h-[50vh] overflow-y-auto">
        {DAY_OF_WEEK_LABELS.map((day) => {
          const dayMeals = meals.filter(m => m.day_of_week === day).sort((a, b) => ALL_MEAL_TYPES.indexOf(a.meal_type) - ALL_MEAL_TYPES.indexOf(b.meal_type));
          if (dayMeals.length === 0) return null;
          const totals = dayTotals[day] ?? { calories: 0, protein: 0 };
          return (
            <div key={day} className="rounded-xl border border-gray-200 bg-gray-50/30 p-3">
              <div className="flex items-center justify-between mb-2">
                <h4 className="text-sm font-bold text-gray-700">{day}</h4>
                <div className="flex items-center gap-3 text-[11px]">
                  <span className={totals.calories > 0 && targetCal && Math.abs(totals.calories - targetCal) > 100 ? 'text-amber-600' : 'text-gray-500'}>
                    کالری: {totals.calories.toLocaleString('fa-IR')}
                  </span>
                  <span className={totals.protein > 0 && targetProt && Math.abs(totals.protein - targetProt) > 20 ? 'text-amber-600' : 'text-gray-500'}>
                    پروتئین: {totals.protein.toLocaleString('fa-IR')}گ
                  </span>
                  {targetCal && (
                    <span className="text-[10px] text-gray-400">
                      (هدف: {targetCal.toLocaleString('fa-IR')}ک / {targetProt?.toLocaleString('fa-IR') ?? '—'}گ)
                    </span>
                  )}
                </div>
              </div>
              <div className="space-y-2">
                {dayMeals.map((meal) => (
                  <WeeklyMealCard
                    key={meal.id}
                    meal={meal}
                    foods={foods}
                    favoriteFoods={favoriteFoods.filter(f => {
                      const mealCat: Record<MealType, FavoriteFoodCategory> = { breakfast: 'breakfast', lunch: 'lunch', dinner: 'dinner', snack: 'snack', pre_workout: 'pre_workout', post_workout: 'post_workout' };
                      return f.category === mealCat[meal.meal_type];
                    })}
                    onUpdateMeal={(patch) => updateMeal(meal.id, patch)}
                    onAddFood={() => addFoodItem(meal.id)}
                    onUpdateFood={(fid, patch) => updateFoodItem(meal.id, fid, patch)}
                    onRemoveFood={(fid) => removeFoodItem(meal.id, fid)}
                    onMoveFood={(idx, dir) => moveFoodItem(meal.id, idx, dir)}
                    onSelectFromBank={(fid) => selectFoodFromBank(meal.id, fid)}
                    onAddSub={() => addSubstitution(meal.id)}
                    onUpdateSub={(sid, patch) => updateSubstitution(meal.id, sid, patch)}
                    onRemoveSub={(sid) => removeSubstitution(meal.id, sid)}
                    onAddSubFood={(sid) => addSubFoodItem(meal.id, sid)}
                    onUpdateSubFood={(sid, fid, patch) => updateSubFoodItem(meal.id, sid, fid, patch)}
                    onRemoveSubFood={(sid, fid) => removeSubFoodItem(meal.id, sid, fid)}
                  />
                ))}
              </div>
            </div>
          );
        })}
      </div>

      {/* Cheat meal */}
      <div className="rounded-xl border border-gray-100 bg-amber-50/20 p-4">
        <label className="flex items-center gap-2 cursor-pointer">
          <input type="checkbox" checked={cheatEnabled} onChange={(e) => setCheatEnabled(e.target.checked)} className="rounded" />
          <span className="text-sm font-semibold text-gray-700">وعده انعطاف‌پذیر (چیت‌میل)</span>
        </label>
        {cheatEnabled && (
          <div className="mt-3 grid grid-cols-2 gap-3">
            <input value={cheatName} onChange={(e) => setCheatName(e.target.value)} placeholder="نام غذا" className="rounded-lg border border-gray-200 px-3 py-2 text-xs outline-none focus:border-brand-500" />
            <input value={cheatAmount} onChange={(e) => setCheatAmount(e.target.value)} placeholder="مقدار" className="rounded-lg border border-gray-200 px-3 py-2 text-xs outline-none focus:border-brand-500" />
            <input value={cheatPlacement} onChange={(e) => setCheatPlacement(e.target.value)} placeholder="جایگاه در برنامه (مثال: وعده آخر شنبه)" className="rounded-lg border border-gray-200 px-3 py-2 text-xs outline-none focus:border-brand-500" />
            <input value={cheatNotes} onChange={(e) => setCheatNotes(e.target.value)} placeholder="توضیحات" className="rounded-lg border border-gray-200 px-3 py-2 text-xs outline-none focus:border-brand-500" />
          </div>
        )}
      </div>

      {/* Actions */}
      <div className="flex justify-start gap-2 pt-2 border-t border-gray-100">
        <button type="button" onClick={() => onSave({ meals, targetCalories: targetCal, targetProteinG: targetProt, pattern, cheatMealEnabled: cheatEnabled, cheatMealName: cheatName, cheatMealAmount: cheatAmount, cheatMealPlacement: cheatPlacement, cheatMealNotes: cheatNotes })} disabled={saving}
          className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 disabled:opacity-50">
          {saving && <Loader2 size={16} className="animate-spin" />}
          {saving ? 'در حال ذخیره...' : 'ذخیره برنامه هفتگی'}
        </button>
        <button type="button" onClick={onClose} className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200">انصراف</button>
      </div>
    </div>
  );
}

function WeeklyMealCard({
  meal, foods, favoriteFoods,
  onUpdateMeal, onAddFood, onUpdateFood, onRemoveFood, onMoveFood, onSelectFromBank,
  onAddSub, onUpdateSub, onRemoveSub, onAddSubFood, onUpdateSubFood, onRemoveSubFood,
}: {
  meal: WeeklyMealDraft;
  foods: Food[];
  favoriteFoods: { category: FavoriteFoodCategory; food_name: string }[];
  onUpdateMeal: (patch: Partial<WeeklyMealDraft>) => void;
  onAddFood: () => void;
  onUpdateFood: (fid: string, patch: Partial<WeeklyFoodItemDraft>) => void;
  onRemoveFood: (fid: string) => void;
  onMoveFood: (idx: number, dir: -1 | 1) => void;
  onSelectFromBank: (foodId: string) => void;
  onAddSub: () => void;
  onUpdateSub: (sid: string, patch: Partial<MealSubDraft>) => void;
  onRemoveSub: (sid: string) => void;
  onAddSubFood: (sid: string) => void;
  onUpdateSubFood: (sid: string, fid: string, patch: Partial<WeeklyFoodItemDraft>) => void;
  onRemoveSubFood: (sid: string, fid: string) => void;
}) {
  const [showFoodPicker, setShowFoodPicker] = useState(false);
  const mealCal = meal.foodItems.reduce((sum, f) => {
    if (f.calories && f.amount) return sum + (Number(f.calories) * Number(f.amount)) / 100;
    return sum;
  }, 0);

  return (
    <div className={`rounded-lg border bg-white p-2.5 ${meal.is_active ? 'border-gray-200' : 'border-gray-100 opacity-50'}`}>
      <div className="flex items-center gap-2">
        <label className="flex items-center gap-1.5 cursor-pointer">
          <input type="checkbox" checked={meal.is_active} onChange={(e) => onUpdateMeal({ is_active: e.target.checked })} className="rounded" />
        </label>
        <span className="text-[10px] rounded-full bg-brand-50 px-2 py-0.5 text-brand-700 font-medium">{MEAL_TYPE_LABELS[meal.meal_type]}</span>
        <input value={meal.meal_name} onChange={(e) => onUpdateMeal({ meal_name: e.target.value })} placeholder="نام وعده" className="flex-1 rounded-md border border-gray-200 px-2 py-1 text-xs outline-none focus:border-brand-500" />
        {mealCal > 0 && <span className="text-[10px] text-gray-400 shrink-0">{mealCal.toLocaleString('fa-IR', { maximumFractionDigits: 0 })} کالری</span>}
      </div>

      {/* Food items */}
      <div className="mt-2 space-y-1.5">
        {meal.foodItems.map((f, fi) => (
          <div key={f.id} className="rounded-md border border-gray-100 bg-gray-50/40 p-2">
            <div className="flex items-center gap-2">
              <input value={f.name} onChange={(e) => onUpdateFood(f.id, { name: e.target.value })} placeholder="نام ماده غذایی" className="flex-1 rounded-md border border-gray-200 px-2 py-1 text-xs outline-none focus:border-brand-500" />
              <div className="flex items-center gap-0.5">
                <button type="button" onClick={() => onMoveFood(fi, -1)} disabled={fi === 0} className="p-0.5 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30"><ChevronUp size={12} /></button>
                <button type="button" onClick={() => onMoveFood(fi, 1)} disabled={fi === meal.foodItems.length - 1} className="p-0.5 rounded text-gray-400 hover:text-gray-700 disabled:opacity-30"><ChevronDown size={12} /></button>
                <button type="button" onClick={() => onRemoveFood(f.id)} className="p-0.5 rounded text-gray-400 hover:text-red-600 hover:bg-red-50"><Trash2 size={12} /></button>
              </div>
            </div>
            <div className="mt-1 flex items-center gap-1.5">
              <input value={f.amount} onChange={(e) => onUpdateFood(f.id, { amount: e.target.value })} placeholder="مقدار" className="w-16 rounded-md border border-gray-200 px-1.5 py-0.5 text-[11px] outline-none focus:border-brand-500" />
              <input value={f.unit} onChange={(e) => onUpdateFood(f.id, { unit: e.target.value })} placeholder="واحد" className="w-20 rounded-md border border-gray-200 px-1.5 py-0.5 text-[11px] outline-none focus:border-brand-500" />
              {f.household_unit && <span className="text-[10px] text-gray-400">{f.household_unit}{f.household_grams ? ` (${f.household_grams}گ)` : ''}</span>}
              <select value={f.is_raw ? 'raw' : 'cooked'} onChange={(e) => onUpdateFood(f.id, { is_raw: e.target.value === 'raw' })} className="rounded-md border border-gray-200 px-1 py-0.5 text-[10px] outline-none focus:border-brand-500 bg-white">
                <option value="raw">خام</option>
                <option value="cooked">پخته</option>
              </select>
            </div>
          </div>
        ))}
        <div className="flex items-center gap-2">
          <button type="button" onClick={onAddFood} className="flex items-center gap-1 text-[11px] text-brand-600 hover:text-brand-700 font-medium">
            <Plus size={11} /> ماده غذایی
          </button>
          <button type="button" onClick={() => setShowFoodPicker(v => !v)} className="flex items-center gap-1 text-[11px] text-gray-500 hover:text-gray-700 font-medium">
            <Utensils size={11} /> از بانک غذا
          </button>
          {favoriteFoods.length > 0 && (
            <span className="text-[10px] text-gray-400">| غذاهای پرتکرار: {favoriteFoods.map(f => f.food_name).join('، ')}</span>
          )}
        </div>
        {showFoodPicker && (
          <div className="max-h-32 overflow-y-auto rounded-md border border-gray-200 bg-white p-1.5 space-y-0.5">
            {foods.length === 0 ? <p className="text-[11px] text-gray-400 p-2 text-center">بانک غذا خالی است.</p> :
              foods.map(f => (
                <button key={f.id} type="button" onClick={() => { onSelectFromBank(f.id); setShowFoodPicker(false); }} className="w-full text-right rounded p-1.5 hover:bg-brand-50 text-[11px]">
                  <span className="font-medium text-gray-700">{f.name}</span>
                  <span className="text-gray-400 mr-2">{f.calories_per_100g ?? '?'}ک/۱۰۰گ</span>
                </button>
              ))
            }
          </div>
        )}
      </div>

      {/* Substitutions */}
      {meal.substitutions.length > 0 && (
        <div className="mt-2 space-y-1.5 border-t border-gray-100 pt-2">
          <p className="text-[10px] font-semibold text-gray-500">جایگزین‌های این وعده</p>
          {meal.substitutions.map((sub) => (
            <div key={sub.id} className="rounded-md border border-amber-100 bg-amber-50/20 p-2">
              <div className="flex items-center gap-2">
                <input value={sub.substitution_name} onChange={(e) => onUpdateSub(sub.id, { substitution_name: e.target.value })} placeholder="نام جایگزین (مثال: ماکارونی)" className="flex-1 rounded-md border border-gray-200 px-2 py-1 text-[11px] outline-none focus:border-brand-500" />
                <button type="button" onClick={() => onRemoveSub(sub.id)} className="p-0.5 rounded text-gray-400 hover:text-red-600"><Trash2 size={11} /></button>
              </div>
              {sub.foodItems.map((f) => (
                <div key={f.id} className="mt-1 flex items-center gap-1.5">
                  <input value={f.name} onChange={(e) => onUpdateSubFood(sub.id, f.id, { name: e.target.value })} placeholder="ماده" className="flex-1 rounded-md border border-gray-200 px-1.5 py-0.5 text-[10px] outline-none" />
                  <input value={f.amount} onChange={(e) => onUpdateSubFood(sub.id, f.id, { amount: e.target.value })} placeholder="مقدار" className="w-14 rounded-md border border-gray-200 px-1 py-0.5 text-[10px] outline-none" />
                  <button type="button" onClick={() => onRemoveSubFood(sub.id, f.id)} className="text-gray-400 hover:text-red-600"><X size={11} /></button>
                </div>
              ))}
              <button type="button" onClick={() => onAddSubFood(sub.id)} className="mt-1 text-[10px] text-brand-600 hover:text-brand-700"><Plus size={9} className="inline" /> ماده</button>
            </div>
          ))}
        </div>
      )}
      <button type="button" onClick={onAddSub} className="mt-1.5 flex items-center gap-1 text-[10px] text-amber-600 hover:text-amber-700 font-medium">
        <Plus size={9} /> جایگزین برای این وعده
      </button>
    </div>
  );
}
