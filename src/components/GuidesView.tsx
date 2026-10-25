import { useEffect, useState } from 'react';
import { BookOpen, Plus, Pencil, Trash2, FileDown, Loader as Loader2, X } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import type { Guide } from '@/lib/supabase';

export default function GuidesView() {
  const [guides, setGuides] = useState<Guide[]>([]);
  const [loading, setLoading] = useState(true);
  const [editingGuide, setEditingGuide] = useState<Guide | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [saving, setSaving] = useState(false);

  const load = async () => {
    setLoading(true);
    const { data, error } = await supabase.from('guides').select('*').order('sort_order');
    if (!error) setGuides(data ?? []);
    setLoading(false);
  };

  useEffect(() => { load(); }, []);

  const handleSave = async (guide: Partial<Guide>) => {
    setSaving(true);
    if (editingGuide) {
      await supabase.from('guides').update({ ...guide, updated_at: new Date().toISOString() }).eq('id', editingGuide.id);
    } else {
      await supabase.from('guides').insert(guide);
    }
    setSaving(false);
    setShowForm(false);
    setEditingGuide(null);
    await load();
  };

  const handleDelete = async (g: Guide) => {
    if (!confirm(`حذف راهنما «${g.title}»؟`)) return;
    await supabase.from('guides').delete().eq('id', g.id);
    await load();
  };

  const handlePrint = (g: Guide) => {
    const printWindow = window.open('', '_blank');
    if (!printWindow) return;
    printWindow.document.write(`
      <!DOCTYPE html><html dir="rtl" lang="fa"><head><meta charset="utf-8">
      <title>${g.title}</title>
      <style>
        @font-face { font-family: 'Vazirmatn'; }
        body { font-family: 'Vazirmatn', system-ui, sans-serif; padding: 2cm; color: #1f2937; line-height: 1.8; }
        h1 { color: #1c5a48; border-bottom: 2px solid #1c5a48; padding-bottom: 8px; }
        .content { white-space: pre-wrap; margin-top: 20px; font-size: 14px; }
        .brand { font-size: 12px; color: #66758b; text-align: center; margin-bottom: 30px; }
        @page { size: A4; margin: 2cm; }
      </style></head><body>
      <p class="brand">هانی ایزدی — راهنمای قابل ارسال به شاگرد</p>
      <h1>${g.title}</h1>
      <div class="content">${g.content || '<p style="color:#999">محتوای این راهنما هنوز تکمیل نشده است. برای ویرایش، روی دکمه ویرایش کلیک کنید.</p>'}</div>
      </body></html>
    `);
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
          <h1 className="text-2xl font-bold text-gray-800">راهنماهای قابل ارسال به شاگرد</h1>
          <p className="text-sm text-gray-500 mt-1">PDFهای مستقل برای ارسال جداگانه</p>
        </div>
        <button onClick={() => { setEditingGuide(null); setShowForm(true); }} className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-white text-sm font-medium hover:bg-brand-700">
          <Plus size={18} /> راهنمای جدید
        </button>
      </div>

      <div className="mt-6 space-y-3">
        {guides.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-gray-200 bg-white p-12 text-center">
            <BookOpen className="mx-auto text-gray-300" size={32} />
            <p className="mt-3 text-sm text-gray-500">هنوز راهنمایی ایجاد نشده است.</p>
          </div>
        ) : (
          guides.map((g) => (
            <div key={g.id} className="rounded-2xl border border-gray-100 bg-white p-5 shadow-card">
              <div className="flex items-start justify-between">
                <div className="flex items-center gap-3">
                  <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-brand-50 text-brand-700">
                    <BookOpen size={18} />
                  </div>
                  <div>
                    <h3 className="text-sm font-semibold text-gray-800">{g.title}</h3>
                    <p className="text-[10px] text-gray-400">{g.slug} — {g.content ? `${g.content.length} کاراکتر` : 'بدون محتوا'}</p>
                  </div>
                </div>
                <div className="flex items-center gap-1">
                  <button onClick={() => handlePrint(g)} className="flex items-center gap-1 rounded-lg bg-brand-50 px-3 py-1.5 text-xs font-medium text-brand-700 hover:bg-brand-100">
                    <FileDown size={13} /> دانلود PDF
                  </button>
                  <button onClick={() => { setEditingGuide(g); setShowForm(true); }} className="p-1.5 rounded-lg text-gray-400 hover:text-brand-600 hover:bg-brand-50">
                    <Pencil size={15} />
                  </button>
                  <button onClick={() => handleDelete(g)} className="p-1.5 rounded-lg text-gray-400 hover:text-red-600 hover:bg-red-50">
                    <Trash2 size={15} />
                  </button>
                </div>
              </div>
              {g.content && (
                <p className="mt-3 text-xs text-gray-500 leading-7 line-clamp-3 whitespace-pre-wrap">{g.content}</p>
              )}
              {!g.content && (
                <p className="mt-3 text-xs text-amber-600 leading-6">محتوای این راهنما هنوز تکمیل نشده است. روی ویرایش کلیک کنید.</p>
              )}
            </div>
          ))
        )}
      </div>

      {showForm && (
        <GuideFormModal guide={editingGuide} onClose={() => { setShowForm(false); setEditingGuide(null); }} onSave={handleSave} saving={saving} />
      )}
    </div>
  );
}

function GuideFormModal({ guide, onClose, onSave, saving }: {
  guide: Guide | null;
  onClose: () => void;
  onSave: (g: Partial<Guide>) => void;
  saving: boolean;
}) {
  const [title, setTitle] = useState(guide?.title ?? '');
  const [slug, setSlug] = useState(guide?.slug ?? '');
  const [content, setContent] = useState(guide?.content ?? '');
  const [category, setCategory] = useState(guide?.category ?? 'general');

  const handleSubmit = () => {
    if (!title.trim()) return;
    onSave({
      title: title.trim(),
      slug: slug.trim() || title.trim().replace(/\s+/g, '_').toLowerCase(),
      content: content,
      category: category as 'food' | 'general',
      is_active: true,
      sort_order: guide?.sort_order ?? 0,
    });
  };

  const inputCls = 'w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100';

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40" onClick={onClose}>
      <div className="rounded-2xl bg-white p-6 max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto" onClick={e => e.stopPropagation()}>
        <div className="flex items-center justify-between mb-4">
          <h3 className="text-sm font-bold text-gray-800">{guide ? 'ویرایش راهنما' : 'راهنمای جدید'}</h3>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600"><X size={18} /></button>
        </div>
        <div className="space-y-3">
          <div><label className="text-xs text-gray-500 mb-1 block">عنوان</label><input value={title} onChange={e => setTitle(e.target.value)} className={inputCls} placeholder="مثال: راهنمای تغذیه در سفر" /></div>
          <div className="grid grid-cols-2 gap-3">
            <div><label className="text-xs text-gray-500 mb-1 block">شناسه (slug)</label><input value={slug} onChange={e => setSlug(e.target.value)} className={inputCls} placeholder="travel_nutrition" dir="ltr" /></div>
            <div><label className="text-xs text-gray-500 mb-1 block">دسته</label><select value={category} onChange={e => setCategory(e.target.value as 'food' | 'general')} className={inputCls}><option value="food">تغذیه</option><option value="general">عمومی</option></select></div>
          </div>
          <div><label className="text-xs text-gray-500 mb-1 block">محتوا</label><textarea value={content} onChange={e => setContent(e.target.value)} rows={12} className={inputCls + ' resize-none leading-7'} placeholder="متن راهنما..." /></div>
        </div>
        <div className="mt-4 flex justify-start gap-2">
          <button onClick={handleSubmit} disabled={saving} className="px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 disabled:opacity-50">{saving ? 'ذخیره...' : guide ? 'به‌روزرسانی' : 'ایجاد راهنما'}</button>
          <button onClick={onClose} className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200">انصراف</button>
        </div>
      </div>
    </div>
  );
}
