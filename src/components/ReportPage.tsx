import { useEffect, useState } from 'react';
import { Loader2, CheckCircle, AlertCircle } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { todayInTehran, addDaysISO } from '@/lib/supabase';
import { formatJalaliShort } from '@/lib/jalali';

export default function ReportPage({ token }: { token: string }) {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [studentName, setStudentName] = useState('');
  const [linkId, setLinkId] = useState<string | null>(null);
  const [submitted, setSubmitted] = useState(false);

  // Report form state
  const [reportDate, setReportDate] = useState(todayInTehran());
  const [weight, setWeight] = useState('');
  const [dietAdherence, setDietAdherence] = useState('');
  const [workoutAdherence, setWorkoutAdherence] = useState('');
  const [hunger, setHunger] = useState('');
  const [energy, setEnergy] = useState('');
  const [sleep, setSleep] = useState('');
  const [performance, setPerformance] = useState('');
  const [pain, setPain] = useState('');
  const [notes, setNotes] = useState('');
  const [saving, setSaving] = useState(false);

  // Evaluation form state
  const [showEval, setShowEval] = useState(false);
  const [evalDate, setEvalDate] = useState(todayInTehran());
  const [evalWeight, setEvalWeight] = useState('');
  const [waist, setWaist] = useState('');
  const [hip, setHip] = useState('');
  const [chest, setChest] = useState('');
  const [arm, setArm] = useState('');
  const [thigh, setThigh] = useState('');

  useEffect(() => {
    (async () => {
      const { data: link, error: linkErr } = await supabase
        .from('report_links')
        .select('id, student_id, status, due_date, expires_at')
        .eq('token', token)
        .maybeSingle();
      if (linkErr || !link) {
        setError('لینک نامعتبر یا منقضی است.');
        setLoading(false);
        return;
      }
      if (link.status === 'revoked' || link.status === 'expired') {
        setError('این لینک لغو یا منقضی شده است.');
        setLoading(false);
        return;
      }
      if (link.expires_at && new Date(link.expires_at) < new Date()) {
        setError('این لینک منقضی شده است.');
        setLoading(false);
        return;
      }
      const { data: student } = await supabase
        .from('students')
        .select('name')
        .eq('id', link.student_id)
        .maybeSingle();
      setStudentName(student?.name ?? 'شاگرد');
      setLinkId(link.id);
      setLoading(false);
    })();
  }, [token]);

  const handleSubmitReport = async () => {
    if (!linkId) return;
    setSaving(true);
    const { data: link } = await supabase
      .from('report_links')
      .select('student_id')
      .eq('id', linkId)
      .maybeSingle();
    if (!link) { setSaving(false); return; }
    await supabase.from('progress_reports').insert({
      student_id: link.student_id,
      report_date: reportDate,
      period_label: `گزارش ${formatJalaliShort(reportDate)}`,
      weight_kg: weight ? Number(weight) : null,
      diet_adherence: dietAdherence,
      workout_adherence: workoutAdherence,
      hunger_level: hunger,
      energy_level: energy,
      sleep_quality: sleep,
      workout_performance: performance,
      pain_issues: pain,
      student_notes: notes,
      report_link_id: linkId,
    });
    setSaving(false);
    setSubmitted(true);
  };

  const handleSubmitEval = async () => {
    if (!linkId) return;
    setSaving(true);
    const { data: link } = await supabase
      .from('report_links')
      .select('student_id')
      .eq('id', linkId)
      .maybeSingle();
    if (!link) { setSaving(false); return; }
    await supabase.from('progress_evaluations').insert({
      student_id: link.student_id,
      evaluation_date: evalDate,
      period_label: `ارزیابی ${formatJalaliShort(evalDate)}`,
      weight_kg: evalWeight ? Number(evalWeight) : null,
      waist_cm: waist ? Number(waist) : null,
      hip_cm: hip ? Number(hip) : null,
      chest_cm: chest ? Number(chest) : null,
      arm_cm: arm ? Number(arm) : null,
      thigh_cm: thigh ? Number(thigh) : null,
      report_link_id: linkId,
    });
    await supabase.from('report_links').update({ status: 'used', used_at: new Date().toISOString() }).eq('id', linkId);
    setSaving(false);
    setSubmitted(true);
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-[#f6f7f9]" dir="rtl">
        <Loader2 className="animate-spin text-gray-400" size={28} />
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-[#f6f7f9] p-4" dir="rtl">
        <div className="max-w-md w-full bg-white rounded-2xl border border-red-100 shadow-card p-8 text-center">
          <AlertCircle className="mx-auto text-red-500" size={32} />
          <h1 className="mt-4 text-lg font-bold text-gray-800">{error}</h1>
          <p className="mt-2 text-sm text-gray-500">برای دریافت لینک جدید با مربی تماس بگیرید.</p>
        </div>
      </div>
    );
  }

  if (submitted) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-[#f6f7f9] p-4" dir="rtl">
        <div className="max-w-md w-full bg-white rounded-2xl border border-emerald-100 shadow-card p-8 text-center">
          <CheckCircle className="mx-auto text-emerald-600" size={32} />
          <h1 className="mt-4 text-lg font-bold text-gray-800">گزارش شما ثبت شد</h1>
          <p className="mt-2 text-sm text-gray-500">از همکاری شما سپاسگزاریم. مربی شما این گزارش را بررسی خواهد کرد.</p>
        </div>
      </div>
    );
  }

  const inputCls = 'w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100';
  const selectOpts = ['', 'ضعیف', 'متوسط', 'خوب', 'عالی'];

  return (
    <div className="min-h-screen bg-[#f6f7f9] py-8" dir="rtl">
      <div className="mx-auto max-w-2xl px-4">
        <div className="rounded-2xl bg-white border border-gray-100 shadow-card p-8">
          <div className="flex items-center gap-3 mb-6">
            <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-brand-600 text-white font-bold">
              ه
            </div>
            <div>
              <h1 className="text-lg font-bold text-gray-800">گزارش پیشرفت</h1>
              <p className="text-sm text-gray-500">{studentName}</p>
            </div>
          </div>

          <div className="flex items-center gap-2 border-b border-gray-100 mb-5">
            <button onClick={() => setShowEval(false)} className={`px-4 py-2 text-sm font-medium border-b-2 transition-colors ${!showEval ? 'border-brand-600 text-brand-700' : 'border-transparent text-gray-400'}`}>
              گزارش دو‌هفته‌ای
            </button>
            <button onClick={() => setShowEval(true)} className={`px-4 py-2 text-sm font-medium border-b-2 transition-colors ${showEval ? 'border-brand-600 text-brand-700' : 'border-transparent text-gray-400'}`}>
              ارزیابی ماهانه (اندازه‌گیری)
            </button>
          </div>

          {!showEval ? (
            <div className="space-y-3">
              <div className="grid grid-cols-2 gap-3">
                <div><label className="text-xs text-gray-500 mb-1 block">تاریخ</label><input type="date" value={reportDate} onChange={e => setReportDate(e.target.value)} className={inputCls} /></div>
                <div><label className="text-xs text-gray-500 mb-1 block">وزن (کیلوگرم)</label><input type="number" value={weight} onChange={e => setWeight(e.target.value)} className={inputCls} placeholder="مثال: ۷۵" /></div>
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div><label className="text-xs text-gray-500 mb-1 block">پایبندی به تغذیه</label><select value={dietAdherence} onChange={e => setDietAdherence(e.target.value)} className={inputCls}>{selectOpts.map(o => <option key={o} value={o}>{o || '—'}</option>)}</select></div>
                <div><label className="text-xs text-gray-500 mb-1 block">پایبندی به تمرین</label><select value={workoutAdherence} onChange={e => setWorkoutAdherence(e.target.value)} className={inputCls}>{selectOpts.map(o => <option key={o} value={o}>{o || '—'}</option>)}</select></div>
              </div>
              <div className="grid grid-cols-3 gap-3">
                <div><label className="text-xs text-gray-500 mb-1 block">گرسنگی</label><select value={hunger} onChange={e => setHunger(e.target.value)} className={inputCls}>{selectOpts.map(o => <option key={o} value={o}>{o || '—'}</option>)}</select></div>
                <div><label className="text-xs text-gray-500 mb-1 block">انرژی</label><select value={energy} onChange={e => setEnergy(e.target.value)} className={inputCls}>{selectOpts.map(o => <option key={o} value={o}>{o || '—'}</option>)}</select></div>
                <div><label className="text-xs text-gray-500 mb-1 block">خواب</label><select value={sleep} onChange={e => setSleep(e.target.value)} className={inputCls}>{selectOpts.map(o => <option key={o} value={o}>{o || '—'}</option>)}</select></div>
              </div>
              <div><label className="text-xs text-gray-500 mb-1 block">عملکرد تمرینی</label><input value={performance} onChange={e => setPerformance(e.target.value)} className={inputCls} placeholder="..." /></div>
              <div><label className="text-xs text-gray-500 mb-1 block">درد یا مشکل جدید</label><input value={pain} onChange={e => setPain(e.target.value)} className={inputCls} placeholder="..." /></div>
              <div><label className="text-xs text-gray-500 mb-1 block">توضیحات</label><textarea value={notes} onChange={e => setNotes(e.target.value)} rows={3} className={inputCls + ' resize-none'} /></div>
              <button onClick={handleSubmitReport} disabled={saving} className="w-full px-5 py-3 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 disabled:opacity-50">
                {saving ? 'در حال ثبت...' : 'ثبت گزارش'}
              </button>
            </div>
          ) : (
            <div className="space-y-3">
              <div><label className="text-xs text-gray-500 mb-1 block">تاریخ</label><input type="date" value={evalDate} onChange={e => setEvalDate(e.target.value)} className={inputCls} /></div>
              <div className="grid grid-cols-3 gap-3">
                <div><label className="text-xs text-gray-500 mb-1 block">وزن (کگ)</label><input type="number" value={evalWeight} onChange={e => setEvalWeight(e.target.value)} className={inputCls} /></div>
                <div><label className="text-xs text-gray-500 mb-1 block">کمر (سم)</label><input type="number" value={waist} onChange={e => setWaist(e.target.value)} className={inputCls} /></div>
                <div><label className="text-xs text-gray-500 mb-1 block">باسن (سم)</label><input type="number" value={hip} onChange={e => setHip(e.target.value)} className={inputCls} /></div>
                <div><label className="text-xs text-gray-500 mb-1 block">سینه (سم)</label><input type="number" value={chest} onChange={e => setChest(e.target.value)} className={inputCls} /></div>
                <div><label className="text-xs text-gray-500 mb-1 block">بازو (سم)</label><input type="number" value={arm} onChange={e => setArm(e.target.value)} className={inputCls} /></div>
                <div><label className="text-xs text-gray-500 mb-1 block">ران (سم)</label><input type="number" value={thigh} onChange={e => setThigh(e.target.value)} className={inputCls} /></div>
              </div>
              <button onClick={handleSubmitEval} disabled={saving} className="w-full px-5 py-3 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 disabled:opacity-50">
                {saving ? 'در حال ثبت...' : 'ثبت ارزیابی'}
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
