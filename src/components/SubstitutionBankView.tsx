import { useEffect, useMemo, useState } from 'react';
import { Plus, Trash2, Loader2, X, ArrowUpDown, FileDown } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import type { FoodSubstitutionGroup, FoodSubstitutionItem } from '@/lib/supabase';

export default function SubstitutionBankView() {
  const [groups, setGroups] = useState<FoodSubstitutionGroup[]>([]);
  const [items, setItems] = useState<FoodSubstitutionItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [showGroupForm, setShowGroupForm] = useState(false);
  const [editingGroup, setEditingGroup] = useState<FoodSubstitutionGroup | null>(null);
  const [expandedGroup, setExpandedGroup] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);

  const load = async () => {
    setLoading(true);
    const [gRes, iRes] = await Promise.all([
      supabase.from('food_substitution_groups').select('*').order('sort_order'),
      supabase.from('food_substitution_items').select('*').order('sort_order'),
    ]);
    if (!gRes.error) setGroups(gRes.data ?? []);
    if (!iRes.error) setItems(iRes.data ?? []);
    setLoading(false);
  };

  useEffect(() => { load(); }, []);

  const itemsByGroup = useMemo(() => {
    const map = new Map<string, FoodSubstitutionItem[]>();
    for (const item of items) {
      const arr = map.get(item.group_id) ?? [];
      arr.push(item);
      map.set(item.group_id, arr);
    }
    return map;
  }, [items]);

  const handleSaveGroup = async (name: string) => {
    setSaving(true);
    if (editingGroup) {
      await supabase.from('food_substitution_groups').update({ name, updated_at: new Date().toISOString() }).eq('id', editingGroup.id);
    } else {
      const maxOrder = groups.reduce((mx, g) => Math.max(mx, g.sort_order), 0);
      await supabase.from('food_substitution_groups').insert({ name, sort_order: maxOrder + 1 });
    }
    setSaving(false);
    setShowGroupForm(false);
    setEditingGroup(null);
    await load();
  };

  const handleDeleteGroup = async (g: FoodSubstitutionGroup) => {
    if (!confirm(`حذف گروه جایگزینی «${g.name}» و تمام موارد آن؟`)) return;
    await supabase.from('food_substitution_items').delete().eq('group_id', g.id);
    await supabase.from('food_substitution_groups').delete().eq('id', g.id);
    await load();
  };

  const handleAddItem = async (groupId: string) => {
    const groupItems = itemsByGroup.get(groupId) ?? [];
    const maxOrder = groupItems.reduce((mx, it) => Math.max(mx, it.sort_order), 0);
    await supabase.from('food_substitution_items').insert({
      group_id: groupId,
      food_name: '',
      amount: '',
      unit: 'گرم',
      equivalent_note: '',
      sort_order: maxOrder + 1,
    });
    await load();
  };

  const handleUpdateItem = async (item: FoodSubstitutionItem, patch: Partial<FoodSubstitutionItem>) => {
    await supabase.from('food_substitution_items').update(patch).eq('id', item.id);
    await load();
  };

  const handleDeleteItem = async (item: FoodSubstitutionItem) => {
    await supabase.from('food_substitution_items').delete().eq('id', item.id);
    await load();
  };

  const handlePrintAll = () => {
    const printWindow = window.open('', '_blank');
    if (!printWindow) return;
    const body = groups.map(g => {
      const its = itemsByGroup.get(g.id) ?? [];
      const rows = its.map(it => `<tr><td>${it.food_name || '—'}</td><td>${it.amount || ''} ${it.unit || ''}</td><td>${it.equivalent_note || ''}</td></tr>`).join('');
      return `<h2>${g.name}</h2><table><thead><tr><th>غذا</th><th>مقدار</th><th>یادداشت</th></tr></thead><tbody>${rows}</tbody></table>`;
    }).join('');
    printWindow.document.write(`<!DOCTYPE html><html dir="rtl" lang="fa"><head><meta charset="utf-8"><title>راهنمای عمومی جایگزین‌های غذایی</title><style>body{font-family:system-ui,sans-serif;padding:2cm;color:#1f2937;line-height:1.8}h1{color:#1c5a48;border-bottom:2px solid #1c5a48;padding-bottom:8px}h2{color:#1c5a48;margin-top:24px}table{width:100%;border-collapse:collapse;margin:8px 0 16px}th,td{border:1px solid #e5e7eb;padding:6px 10px;text-align:right;font-size:13px}th{background:#f0faf5}@page{size:A4;margin:2cm}</style></head><body><h1>راهنمای عمومی جایگزین‌های غذایی</h1>${body}</body></html>`);
    printWindow.document.close();
    setTimeout(() => printWindow.print(), 300);
  };

  if (loading) {
    return <div className="flex items-center justify-center py-24 text-gray-400"><Loader2 className="animate-spin" size={28} /></div>;
  }

  return (
    <div>
      <div className="flex items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">بانک جایگزین‌های عمومی</h1>
          <p className="text-sm text-gray-500 mt-1">گروه‌های جایگزینی برای ارسال به‌عنوان راهنمای مستقل</p>
        </div>
        <div className="flex items-center gap-2">
          <button onClick={handlePrintAll} className="flex items-center gap-2 rounded-xl border border-gray-200 bg-white px-4 py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-50">
            <FileDown size={18} /> PDF راهنمای جایگزین‌ها
          </button>
          <button onClick={() => { setEditingGroup(null); setShowGroupForm(true); }} className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-white text-sm font-medium hover:bg-brand-700">
            <Plus size={18} /> گروه جدید
          </button>
        </div>
      </div>

      {groups.length === 0 ? (
        <div className="mt-6 rounded-2xl border border-dashed border-gray-200 bg-white p-12 text-center">
          <ArrowUpDown className="mx-auto text-gray-300" size={32} />
          <p className="mt-3 text-sm text-gray-500">هنوز گروه جایگزینی ثبت نشده است.</p>
        </div>
      ) : (
        <div className="mt-5 space-y-3">
          {groups.map((g) => {
            const groupItems = itemsByGroup.get(g.id) ?? [];
            const isExpanded = expandedGroup === g.id;
            return (
              <div key={g.id} className="rounded-2xl border border-gray-100 bg-white shadow-card overflow-hidden">
                <div className="flex items-center justify-between p-4">
                  <button onClick={() => setExpandedGroup(isExpanded ? null : g.id)} className="flex items-center gap-2 text-right flex-1">
                    <ArrowUpDown size={16} className="text-brand-600" />
                    <span className="text-sm font-semibold text-gray-800">{g.name}</span>
                    <span className="text-[10px] text-gray-400">({groupItems.length} مورد)</span>
                  </button>
                  <div className="flex items-center gap-1">
                    <button onClick={() => handleDeleteGroup(g)} className="p-1.5 rounded-lg text-gray-400 hover:text-red-600 hover:bg-red-50">
                      <Trash2 size={15} />
                    </button>
                  </div>
                </div>
                {isExpanded && (
                  <div className="border-t border-gray-50 px-4 py-3 bg-gray-50/30">
                    {groupItems.length === 0 ? (
                      <p className="text-xs text-gray-400 py-2">موردی ثبت نشده.</p>
                    ) : (
                      <div className="space-y-1.5">
                        {groupItems.map((it) => (
                          <div key={it.id} className="flex items-center gap-2">
                            <input
                              value={it.food_name}
                              onChange={(e) => handleUpdateItem(it, { food_name: e.target.value })}
                              className="flex-1 rounded-lg border border-gray-200 px-3 py-1.5 text-xs"
                              placeholder="نام غذا"
                            />
                            <input
                              value={it.amount}
                              onChange={(e) => handleUpdateItem(it, { amount: e.target.value })}
                              className="w-20 rounded-lg border border-gray-200 px-2 py-1.5 text-xs"
                              placeholder="مقدار"
                            />
                            <input
                              value={it.unit}
                              onChange={(e) => handleUpdateItem(it, { unit: e.target.value })}
                              className="w-20 rounded-lg border border-gray-200 px-2 py-1.5 text-xs"
                              placeholder="واحد"
                            />
                            <input
                              value={it.equivalent_note}
                              onChange={(e) => handleUpdateItem(it, { equivalent_note: e.target.value })}
                              className="flex-1 rounded-lg border border-gray-200 px-3 py-1.5 text-xs"
                              placeholder="یادداشت معادل"
                            />
                            <button onClick={() => handleDeleteItem(it)} className="p-1 rounded text-gray-400 hover:text-red-600">
                              <Trash2 size={13} />
                            </button>
                          </div>
                        ))}
                      </div>
                    )}
                    <button onClick={() => handleAddItem(g.id)} className="mt-2 flex items-center gap-1 text-xs font-medium text-brand-700 hover:text-brand-800">
                      <Plus size={13} /> افزودن مورد
                    </button>
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}

      {showGroupForm && (
        <GroupFormModal group={editingGroup} onClose={() => { setShowGroupForm(false); setEditingGroup(null); }} onSave={handleSaveGroup} saving={saving} />
      )}
    </div>
  );
}

function GroupFormModal({ group, onClose, onSave, saving }: {
  group: FoodSubstitutionGroup | null;
  onClose: () => void;
  onSave: (name: string) => void;
  saving: boolean;
}) {
  const [name, setName] = useState(group?.name ?? '');
  const inputCls = 'w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100';
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40" onClick={onClose}>
      <div className="rounded-2xl bg-white p-6 max-w-md w-full mx-4" onClick={e => e.stopPropagation()}>
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-sm font-bold text-gray-800">{group ? 'ویرایش گروه' : 'گروه جایگزینی جدید'}</h3>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600"><X size={18} /></button>
        </div>
        <label className="text-xs font-medium text-gray-500 mb-1.5 block">نام گروه</label>
        <input value={name} onChange={(e) => setName(e.target.value)} className={inputCls} placeholder="مثال: انواع نان" autoFocus />
        <div className="mt-5 flex justify-start gap-2">
          <button onClick={() => name.trim() && onSave(name.trim())} disabled={saving} className="px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 disabled:opacity-50">
            {saving ? 'در حال ذخیره...' : group ? 'به‌روزرسانی' : 'ایجاد گروه'}
          </button>
          <button onClick={onClose} className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200">انصراف</button>
        </div>
      </div>
    </div>
  );
}
