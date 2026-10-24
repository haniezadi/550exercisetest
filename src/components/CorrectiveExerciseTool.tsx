import { useEffect, useMemo, useState } from 'react';
import { Plus, Trash2, Loader2, X, Dumbbell, Check } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import type { CorrectiveIssue, CorrectiveIssueExercise, Exercise } from '@/lib/supabase';

export interface CorrectiveSaveData {
  approvedExerciseIds: string[];
}

export default function CorrectiveExerciseTool({
  exercises,
  onSave,
  saving,
}: {
  exercises: Exercise[];
  onSave: (exerciseIds: string[]) => void;
  saving: boolean;
}) {
  const [issues, setIssues] = useState<CorrectiveIssue[]>([]);
  const [issueExercises, setIssueExercises] = useState<CorrectiveIssueExercise[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedIssue, setSelectedIssue] = useState<string>('');
  const [suggestedIds, setSuggestedIds] = useState<Set<string>>(new Set());
  const [approvedIds, setApprovedIds] = useState<Set<string>>(new Set());
  const [rejectedIds, setRejectedIds] = useState<Set<string>>(new Set());

  const load = async () => {
    setLoading(true);
    const [iRes, ieRes] = await Promise.all([
      supabase.from('corrective_issues').select('*').eq('is_active', true).order('sort_order'),
      supabase.from('corrective_issue_exercises').select('*').order('sort_order'),
    ]);
    if (!iRes.error) setIssues(iRes.data ?? []);
    if (!ieRes.error) setIssueExercises(ieRes.data ?? []);
    setLoading(false);
  };

  useEffect(() => { load(); }, []);

  const exerciseById = useMemo(() => {
    const map = new Map<string, Exercise>();
    for (const e of exercises) map.set(e.id, e);
    return map;
  }, [exercises]);

  const handleSelectIssue = (issueId: string) => {
    setSelectedIssue(issueId);
    setSuggestedIds(new Set());
    setApprovedIds(new Set());
    setRejectedIds(new Set());
    if (!issueId) return;
    const linked = issueExercises.filter(ie => ie.issue_id === issueId);
    setSuggestedIds(new Set(linked.map(ie => ie.exercise_id)));
  };

  const approve = (id: string) => {
    setApprovedIds(prev => new Set(prev).add(id));
    setRejectedIds(prev => { const n = new Set(prev); n.delete(id); return n; });
  };
  const reject = (id: string) => {
    setRejectedIds(prev => new Set(prev).add(id));
    setApprovedIds(prev => { const n = new Set(prev); n.delete(id); return n; });
  };

  const handleSave = () => {
    onSave([...approvedIds]);
  };

  if (loading) {
    return <div className="flex items-center justify-center py-8 text-gray-400"><Loader2 className="animate-spin" size={20} /></div>;
  }

  const suggestedExercises = [...suggestedIds].map(id => exerciseById.get(id)).filter(Boolean) as Exercise[];

  return (
    <div className="rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
      <div className="flex items-center gap-2 mb-4">
        <Dumbbell size={18} className="text-brand-600" />
        <h3 className="text-base font-semibold text-gray-800">ابزار حرکات اصلاحی</h3>
      </div>
      <p className="text-xs text-gray-500 mb-4 leading-6">
        این ابزار کمکی است برای پیشنهاد حرکات بر اساس موارد ساختاری. تشخیص نهایی با مربی است و این ابزار تشخیص پزشکی انجام نمی‌دهد.
      </p>

      <div className="space-y-3">
        <div>
          <label className="text-xs font-medium text-gray-500 mb-1.5 block">انتخاب مورد ساختاری</label>
          <select value={selectedIssue} onChange={(e) => handleSelectIssue(e.target.value)}
            className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 bg-white">
            <option value="">— انتخاب کنید —</option>
            {issues.map(iss => (
              <option key={iss.id} value={iss.id}>{iss.name_fa}{iss.name_en ? ` (${iss.name_en})` : ''}</option>
            ))}
          </select>
        </div>

        {selectedIssue && suggestedExercises.length > 0 && (
          <div className="space-y-2">
            <p className="text-xs font-semibold text-gray-600">حرکات پیشنهادی ({suggestedExercises.length}):</p>
            {suggestedExercises.map(ex => {
              const isApproved = approvedIds.has(ex.id);
              const isRejected = rejectedIds.has(ex.id);
              return (
                <div key={ex.id} className={`rounded-lg border p-3 flex items-center justify-between ${isApproved ? 'border-emerald-200 bg-emerald-50/30' : isRejected ? 'border-gray-100 bg-gray-50/30 opacity-50' : 'border-gray-100'}`}>
                  <div className="flex items-center gap-2">
                    <Dumbbell size={14} className="text-gray-400" />
                    <div>
                      <p className="text-sm font-medium text-gray-700">{ex.name_fa}</p>
                      {ex.name_en && <p className="text-[10px] text-gray-400">{ex.name_en}</p>}
                    </div>
                  </div>
                  <div className="flex items-center gap-1">
                    {!isApproved && (
                      <button onClick={() => approve(ex.id)} className="rounded-lg bg-emerald-50 px-2.5 py-1.5 text-xs font-medium text-emerald-700 hover:bg-emerald-100">
                        <Check size={12} className="inline" /> تأیید
                      </button>
                    )}
                    {!isRejected && (
                      <button onClick={() => reject(ex.id)} className="rounded-lg bg-gray-100 px-2.5 py-1.5 text-xs font-medium text-gray-500 hover:bg-gray-200">
                        <X size={12} className="inline" /> رد
                      </button>
                    )}
                    {isApproved && <span className="text-xs font-medium text-emerald-700">تأیید شد</span>}
                  </div>
                </div>
              );
            })}
            {approvedIds.size > 0 && (
              <button onClick={handleSave} disabled={saving}
                className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2 text-sm font-medium text-white hover:bg-brand-700 disabled:opacity-50">
                {saving && <Loader2 size={15} className="animate-spin" />}
                افزودن {approvedIds.size} حرکت تأییدشده به برنامه
              </button>
            )}
          </div>
        )}

        {selectedIssue && suggestedExercises.length === 0 && (
          <p className="text-xs text-gray-400 py-2">حرکت پیشنهادی برای این مورد ثبت نشده است.</p>
        )}
      </div>
    </div>
  );
}
