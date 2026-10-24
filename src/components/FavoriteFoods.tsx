import { useEffect, useState } from 'react';
import { Plus, Trash2, Loader2, Heart } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import type { StudentFavoriteFood, FavoriteFoodCategory, Food } from '@/lib/supabase';
import { FAVORITE_FOOD_CATEGORY_LABELS } from '@/lib/supabase';

const CATEGORIES: FavoriteFoodCategory[] = ['breakfast', 'lunch', 'dinner', 'snack', 'pre_workout', 'post_workout'];

export default function FavoriteFoods({ studentId }: { studentId: string }) {
  const [favorites, setFavorites] = useState<StudentFavoriteFood[]>([]);
  const [foods, setFoods] = useState<Food[]>([]);
  const [loading, setLoading] = useState(true);
  const [adding, setAdding] = useState<FavoriteFoodCategory | null>(null);
  const [newName, setNewName] = useState('');
  const [newFoodId, setNewFoodId] = useState('');

  const load = async () => {
    setLoading(true);
    const [favRes, foodRes] = await Promise.all([
      supabase.from('student_favorite_foods').select('*').eq('student_id', studentId).order('sort_order'),
      supabase.from('foods').select('*').order('name').limit(500),
    ]);
    if (!favRes.error) setFavorites(favRes.data ?? []);
    if (!foodRes.error) setFoods(foodRes.data ?? []);
    setLoading(false);
  };

  useEffect(() => { load(); }, [studentId]);

  const addFavorite = async (category: FavoriteFoodCategory) => {
    if (!newName.trim() && !newFoodId) return;
    const existingInCat = favorites.filter(f => f.category === category);
    if (existingInCat.length >= 7) return;
    const foodId = newFoodId || null;
    const name = newFoodId ? (foods.find(f => f.id === newFoodId)?.name ?? newName) : newName;
    await supabase.from('student_favorite_foods').insert({
      student_id: studentId,
      category,
      food_name: name.trim(),
      food_id: foodId,
      sort_order: existingInCat.length,
    });
    setNewName('');
    setNewFoodId('');
    setAdding(null);
    await load();
  };

  const removeFavorite = async (id: string) => {
    await supabase.from('student_favorite_foods').delete().eq('id', id);
    await load();
  };

  if (loading) {
    return <div className="flex items-center justify-center py-4 text-gray-400"><Loader2 className="animate-spin" size={20} /></div>;
  }

  const favoritesByCategory = (cat: FavoriteFoodCategory) => favorites.filter(f => f.category === cat);

  return (
    <div className="rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
      <div className="flex items-center gap-2 mb-4">
        <Heart size={18} className="text-brand-600" />
        <h2 className="text-base font-semibold text-gray-800">غذاهای پرتکرار شاگرد</h2>
      </div>

      <div className="grid grid-cols-2 gap-4">
        {CATEGORIES.map(cat => {
          const items = favoritesByCategory(cat);
          return (
            <div key={cat} className="rounded-xl border border-gray-100 bg-gray-50/30 p-3">
              <div className="flex items-center justify-between mb-2">
                <span className="text-xs font-semibold text-gray-600">{FAVORITE_FOOD_CATEGORY_LABELS[cat]}</span>
                <span className="text-[10px] text-gray-400">{items.length}/۷</span>
              </div>
              <div className="space-y-1">
                {items.map(item => (
                  <div key={item.id} className="flex items-center justify-between rounded-lg bg-white border border-gray-100 px-2.5 py-1.5">
                    <span className="text-xs text-gray-700">{item.food_name}</span>
                    <button onClick={() => removeFavorite(item.id)} className="text-gray-300 hover:text-red-500">
                      <Trash2 size={12} />
                    </button>
                  </div>
                ))}
                {items.length < 7 && (
                  adding === cat ? (
                    <div className="space-y-1.5">
                      <select value={newFoodId} onChange={e => { setNewFoodId(e.target.value); if (e.target.value) setNewName(''); }} className="w-full rounded-lg border border-gray-200 px-2 py-1.5 text-xs outline-none focus:border-brand-500 bg-white">
                        <option value="">یا از بانک غذا...</option>
                        {foods.map(f => <option key={f.id} value={f.id}>{f.name}</option>)}
                      </select>
                      {!newFoodId && (
                        <input value={newName} onChange={e => setNewName(e.target.value)} placeholder="نام غذا" className="w-full rounded-lg border border-gray-200 px-2 py-1.5 text-xs outline-none focus:border-brand-500" />
                      )}
                      <div className="flex gap-1">
                        <button onClick={() => addFavorite(cat)} className="rounded-lg bg-brand-50 px-2.5 py-1 text-[10px] font-medium text-brand-700 hover:bg-brand-100">افزودن</button>
                        <button onClick={() => { setAdding(null); setNewName(''); setNewFoodId(''); }} className="rounded-lg bg-gray-100 px-2.5 py-1 text-[10px] text-gray-500">لغو</button>
                      </div>
                    </div>
                  ) : (
                    <button onClick={() => setAdding(cat)} className="flex items-center gap-1 text-[11px] text-brand-600 hover:text-brand-700 font-medium">
                      <Plus size={11} /> افزودن
                    </button>
                  )
                )}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
