import { useEffect, useMemo, useState } from 'react';
import { Plus, Search, Pencil, Trash2, Utensils, Loader2, X } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import type { Food, FoodCategory } from '@/lib/supabase';
import { FOOD_CATEGORY_LABELS } from '@/lib/supabase';

const CATEGORIES = Object.keys(FOOD_CATEGORY_LABELS) as FoodCategory[];

export default function FoodBankView() {
  const [foods, setFoods] = useState<Food[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState('');
  const [categoryFilter, setCategoryFilter] = useState<string>('');
  const [editingFood, setEditingFood] = useState<Food | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [saving, setSaving] = useState(false);
  const [deleteTarget, setDeleteTarget] = useState<Food | null>(null);

  const loadFoods = async () => {
    setLoading(true);
    const { data, error } = await supabase.from('foods').select('*').order('name');
    if (!error) setFoods(data ?? []);
    setLoading(false);
  };

  useEffect(() => { loadFoods(); }, []);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    return foods.filter((f) => {
      if (categoryFilter && f.category !== categoryFilter) return false;
      if (q && !f.name.toLowerCase().includes(q)) return false;
      return true;
    });
  }, [foods, query, categoryFilter]);

  const handleSave = async (food: Partial<Food>) => {
    setSaving(true);
    if (editingFood) {
      const { error } = await supabase.from('foods').update({ ...food, updated_at: new Date().toISOString() }).eq('id', editingFood.id);
      if (error) { setSaving(false); return; }
    } else {
      const { error } = await supabase.from('foods').insert(food);
      if (error) { setSaving(false); return; }
    }
    setSaving(false);
    setShowForm(false);
    setEditingFood(null);
    await loadFoods();
  };

  const handleDelete = async () => {
    if (!deleteTarget) return;
    setSaving(true);
    await supabase.from('foods').delete().eq('id', deleteTarget.id);
    setSaving(false);
    setDeleteTarget(null);
    await loadFoods();
  };

  if (loading) {
    return <div className="flex items-center justify-center py-24 text-gray-400"><Loader2 className="animate-spin" size={28} /></div>;
  }

  return (
    <div>
      <div className="flex items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">بانک غذاها</h1>
          <p className="text-sm text-gray-500 mt-1">{foods.length.toLocaleString('fa-IR')} ماده غذایی ثبت شده</p>
        </div>
        <button
          onClick={() => { setEditingFood(null); setShowForm(true); }}
          className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-white text-sm font-medium hover:bg-brand-700 transition-colors"
        >
          <Plus size={18} />
          غذای جدید
        </button>
      </div>

      <div className="mt-5 flex items-center gap-3">
        <div className="relative flex-1">
          <Search size={18} className="absolute right-3.5 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="جست‌وجوی غذا..."
            className="w-full rounded-xl border border-gray-200 bg-white py-2.5 pr-11 pl-4 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
          />
        </div>
        <select
          value={categoryFilter}
          onChange={(e) => setCategoryFilter(e.target.value)}
          className="rounded-xl border border-gray-200 bg-white px-3 py-2.5 text-sm outline-none focus:border-brand-500"
        >
          <option value="">همه دسته‌ها</option>
          {CATEGORIES.map((c) => <option key={c} value={c}>{FOOD_CATEGORY_LABELS[c]}</option>)}
        </select>
      </div>

      {filtered.length === 0 ? (
        <div className="mt-6 rounded-2xl border border-dashed border-gray-200 bg-white p-12 text-center">
          <Utensils className="mx-auto text-gray-300" size={32} />
          <p className="mt-3 text-sm text-gray-500">
            {query || categoryFilter ? 'نتیجه‌ای یافت نشد.' : 'هنوز غذایی ثبت نشده است.'}
          </p>
        </div>
      ) : (
        <div className="mt-4 overflow-hidden rounded-2xl border border-gray-100 bg-white shadow-card">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-gray-100 bg-gray-50/60 text-gray-500 text-xs">
                <th className="px-4 py-3 text-right font-medium">نام غذا</th>
                <th className="px-4 py-3 text-right font-medium">دسته</th>
                <th className="px-4 py-3 text-right font-medium">کالری/۱۰۰گ</th>
                <th className="px-4 py-3 text-right font-medium">پروتئین/۱۰۰گ</th>
                <th className="px-4 py-3 text-right font-medium">واحد خانگی</th>
                <th className="px-4 py-3 text-right font-medium">خام/پخته</th>
                <th className="px-4 py-3 text-left font-medium">عملیات</th>
              </tr>
            </thead>
            <tbody>
              {filtered.map((f) => (
                <tr key={f.id} className="border-b border-gray-50 last:border-0 hover:bg-gray-50/50">
                  <td className="px-4 py-3 font-medium text-gray-800">{f.name}</td>
                  <td className="px-4 py-3 text-gray-600">{FOOD_CATEGORY_LABELS[f.category]}</td>
                  <td className="px-4 py-3 text-gray-600">{f.calories_per_100g != null ? `${f.calories_per_100g}` : '—'}</td>
                  <td className="px-4 py-3 text-gray-600">{f.protein_per_100g != null ? `${f.protein_per_100g}` : '—'}</td>
                  <td className="px-4 py-3 text-gray-600">
                    {f.household_unit ? `${f.household_unit}${f.household_unit_grams != null ? ` (${f.household_unit_grams}گ)` : ''}` : '—'}
                  </td>
                  <td className="px-4 py-3">
                    <span className={`inline-flex rounded-full px-2 py-0.5 text-[10px] font-medium ${f.is_raw ? 'bg-amber-50 text-amber-700' : 'bg-blue-50 text-blue-700'}`}>
                      {f.is_raw ? 'خام' : 'پخته'}
                    </span>
                  </td>
                  <td className="px-4 py-3">
                    <div className="flex items-center justify-end gap-1">
                      <button onClick={() => { setEditingFood(f); setShowForm(true); }} className="p-1.5 rounded-lg text-gray-400 hover:text-brand-600 hover:bg-brand-50 transition-colors">
                        <Pencil size={15} />
                      </button>
                      <button onClick={() => setDeleteTarget(f)} className="p-1.5 rounded-lg text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors">
                        <Trash2 size={15} />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {showForm && (
        <FoodFormModal
          food={editingFood}
          onClose={() => { setShowForm(false); setEditingFood(null); }}
          onSave={handleSave}
          saving={saving}
        />
      )}

      {deleteTarget && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40" onClick={() => setDeleteTarget(null)}>
          <div className="rounded-2xl bg-white p-6 max-w-sm w-full mx-4" onClick={(e) => e.stopPropagation()}>
            <h3 className="text-sm font-bold text-gray-800">حذف غذا</h3>
            <p className="mt-2 text-sm text-gray-600 leading-7">آیا از حذف «{deleteTarget.name}» مطمئن هستید؟</p>
            <div className="mt-4 flex justify-start gap-2">
              <button onClick={handleDelete} disabled={saving} className="px-5 py-2.5 rounded-xl bg-red-600 text-white text-sm font-medium hover:bg-red-700 disabled:opacity-50">
                {saving ? 'در حال حذف...' : 'حذف کن'}
              </button>
              <button onClick={() => setDeleteTarget(null)} className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200">انصراف</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

function FoodFormModal({ food, onClose, onSave, saving }: {
  food: Food | null;
  onClose: () => void;
  onSave: (food: Partial<Food>) => void;
  saving: boolean;
}) {
  const [name, setName] = useState(food?.name ?? '');
  const [category, setCategory] = useState<FoodCategory>(food?.category ?? 'other');
  const [calories, setCalories] = useState(food?.calories_per_100g != null ? String(food.calories_per_100g) : '');
  const [protein, setProtein] = useState(food?.protein_per_100g != null ? String(food.protein_per_100g) : '');
  const [carbs, setCarbs] = useState(food?.carbs_per_100g != null ? String(food.carbs_per_100g) : '');
  const [fat, setFat] = useState(food?.fat_per_100g != null ? String(food.fat_per_100g) : '');
  const [defaultUnit, setDefaultUnit] = useState(food?.default_unit ?? 'گرم');
  const [householdUnit, setHouseholdUnit] = useState(food?.household_unit ?? '');
  const [householdGrams, setHouseholdGrams] = useState(food?.household_unit_grams != null ? String(food.household_unit_grams) : '');
  const [isRaw, setIsRaw] = useState(food?.is_raw ?? true);
  const [notes, setNotes] = useState(food?.notes ?? '');

  const handleSubmit = () => {
    if (!name.trim()) return;
    onSave({
      name: name.trim(),
      category,
      calories_per_100g: calories ? Number(calories) : null,
      protein_per_100g: protein ? Number(protein) : null,
      carbs_per_100g: carbs ? Number(carbs) : null,
      fat_per_100g: fat ? Number(fat) : null,
      default_unit: defaultUnit,
      household_unit: householdUnit.trim() || null,
      household_unit_grams: householdGrams ? Number(householdGrams) : null,
      is_raw: isRaw,
      notes: notes.trim(),
      is_active: true,
    });
  };

  const inputCls = 'w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100';

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40" onClick={onClose}>
      <div className="rounded-2xl bg-white p-6 max-w-lg w-full mx-4 max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-sm font-bold text-gray-800">{food ? 'ویرایش غذا' : 'غذای جدید'}</h3>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600"><X size={18} /></button>
        </div>
        <div className="space-y-3">
          <div>
            <label className="text-xs font-medium text-gray-500 mb-1.5 block">نام غذا</label>
            <input value={name} onChange={(e) => setName(e.target.value)} className={inputCls} placeholder="مثال: سینه مرغ" />
          </div>
          <div>
            <label className="text-xs font-medium text-gray-500 mb-1.5 block">دسته غذایی</label>
            <select value={category} onChange={(e) => setCategory(e.target.value as FoodCategory)} className={inputCls}>
              {CATEGORIES.map((c) => <option key={c} value={c}>{FOOD_CATEGORY_LABELS[c]}</option>)}
            </select>
          </div>
          <div className="grid grid-cols-3 gap-3">
            <div>
              <label className="text-xs font-medium text-gray-500 mb-1.5 block">کالری/۱۰۰گ</label>
              <input type="number" value={calories} onChange={(e) => setCalories(e.target.value)} className={inputCls} placeholder="مثال: ۱۶۵" />
            </div>
            <div>
              <label className="text-xs font-medium text-gray-500 mb-1.5 block">پروتئین/۱۰۰گ</label>
              <input type="number" value={protein} onChange={(e) => setProtein(e.target.value)} className={inputCls} placeholder="مثال: ۳۱" />
            </div>
            <div>
              <label className="text-xs font-medium text-gray-500 mb-1.5 block">کربو/۱۰۰گ</label>
              <input type="number" value={carbs} onChange={(e) => setCarbs(e.target.value)} className={inputCls} placeholder="مثال: ۰" />
            </div>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="text-xs font-medium text-gray-500 mb-1.5 block">چربی/۱۰۰گ</label>
              <input type="number" value={fat} onChange={(e) => setFat(e.target.value)} className={inputCls} placeholder="مثال: ۳.۶" />
            </div>
            <div>
              <label className="text-xs font-medium text-gray-500 mb-1.5 block">واحد پیش‌فرض</label>
              <input value={defaultUnit} onChange={(e) => setDefaultUnit(e.target.value)} className={inputCls} placeholder="گرم" />
            </div>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="text-xs font-medium text-gray-500 mb-1.5 block">واحد خانگی</label>
              <input value={householdUnit} onChange={(e) => setHouseholdUnit(e.target.value)} className={inputCls} placeholder="مثال: پیمانه" />
            </div>
            <div>
              <label className="text-xs font-medium text-gray-500 mb-1.5 block">معادل گرم</label>
              <input type="number" value={householdGrams} onChange={(e) => setHouseholdGrams(e.target.value)} className={inputCls} placeholder="مثال: ۱۵۰" />
            </div>
          </div>
          <div>
            <label className="text-xs font-medium text-gray-500 mb-1.5 block">وضعیت</label>
            <select value={isRaw ? 'raw' : 'cooked'} onChange={(e) => setIsRaw(e.target.value === 'raw')} className={inputCls}>
              <option value="raw">خام</option>
              <option value="cooked">پخته</option>
            </select>
          </div>
          <div>
            <label className="text-xs font-medium text-gray-500 mb-1.5 block">یادداشت</label>
            <textarea value={notes} onChange={(e) => setNotes(e.target.value)} rows={2} className={inputCls + ' resize-none'} placeholder="نکات اختیاری..." />
          </div>
        </div>
        <div className="mt-5 flex justify-start gap-2">
          <button onClick={handleSubmit} disabled={saving} className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 disabled:opacity-50">
            {saving && <Loader2 size={16} className="animate-spin" />}
            {saving ? 'در حال ذخیره...' : food ? 'به‌روزرسانی' : 'ثبت غذا'}
          </button>
          <button onClick={onClose} className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200">انصراف</button>
        </div>
      </div>
    </div>
  );
}
