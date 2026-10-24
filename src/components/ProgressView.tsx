import { useEffect, useMemo, useState } from 'react';
import { TrendingUp, Plus, Loader2, Copy, Link2, Camera, Ruler, Activity } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import type { ProgressReport, ProgressEvaluation, ReportLink, Student } from '@/lib/supabase';
import { REPORT_LINK_STATUS_LABELS, REPORT_LINK_STATUS_COLORS } from '@/lib/supabase';
import { formatJalaliShort, toPersianDigits } from '@/lib/jalali';
import { todayInTehran, addDaysISO, daysBetween } from '@/lib/supabase';

export default function ProgressView({ student }: { student: Student }) {
  const [reports, setReports] = useState<ProgressReport[]>([]);
  const [evaluations, setEvaluations] = useState<ProgressEvaluation[]>([]);
  const [reportLinks, setReportLinks] = useState<ReportLink[]>([]);
  const [loading, setLoading] = useState(true);
  const [tab, setTab] = useState<'reports' | 'evaluations' | 'links'>('reports');
  const [showReportForm, setShowReportForm] = useState(false);
  const [showEvalForm, setShowEvalForm] = useState(false);
  const [saving, setSaving] = useState(false);
  const [copiedLink, setCopiedLink] = useState<string | null>(null);

  const load = async () => {
    setLoading(true);
    const [rRes, eRes, lRes] = await Promise.all([
      supabase.from('progress_reports').select('*').eq('student_id', student.id).order('report_date', { ascending: false }),
      supabase.from('progress_evaluations').select('*').eq('student_id', student.id).order('evaluation_date', { ascending: false }),
      supabase.from('report_links').select('*').eq('student_id', student.id).order('created_at', { ascending: false }),
    ]);
    if (!rRes.error) setReports(rRes.data ?? []);
    if (!eRes.error) setEvaluations(eRes.data ?? []);
    if (!lRes.error) setReportLinks(lRes.data ?? []);
    setLoading(false);
  };

  useEffect(() => { load(); }, [student.id]);

  // Weight chart data from evaluations
  const weightHistory = useMemo(() => {
    const points = evaluations
      .filter(e => e.weight_kg != null)
      .map(e => ({ date: e.evaluation_date, weight: e.weight_kg! }))
      .reverse();
    return points;
  }, [evaluations]);

  const nextReportDue = useMemo(() => {
    const lastReport = reports[0];
    if (!lastReport) return todayInTehran();
    return addDaysISO(lastReport.report_date, 14);
  }, [reports]);

  const nextEvalDue = useMemo(() => {
    const lastEval = evaluations[0];
    if (!lastEval) return todayInTehran();
    return addDaysISO(lastEval.evaluation_date, 28);
  }, [evaluations]);

  const today = todayInTehran();
  const reportStatus = daysBetween(today, nextReportDue);
  const evalStatus = daysBetween(today, nextEvalDue);

  const handleCreateLink = async () => {
    setSaving(true);
    const dueDate = addDaysISO(today, 28);
    const { data, error } = await supabase.from('report_links').insert({
      student_id: student.id,
      link_type: 'monthly',
      due_date: dueDate,
      status: 'active',
      title: `گزارش ماهانه - ${student.name}`,
    }).select().single();
    setSaving(false);
    if (!error && data) {
      await load();
    }
  };

  const handleCopyLink = (link: ReportLink) => {
    const url = `${window.location.origin}/#/report/${link.token}`;
    navigator.clipboard.writeText(url).then(() => {
      setCopiedLink(link.id);
      setTimeout(() => setCopiedLink(null), 2000);
    });
  };

  const handleRevokeLink = async (link: ReportLink) => {
    await supabase.from('report_links').update({ status: 'revoked' }).eq('id', link.id);
    await load();
  };

  if (loading) {
    return <div className="flex items-center justify-center py-12 text-gray-400"><Loader2 className="animate-spin" size={24} /></div>;
  }

  return (
    <div className="mt-6 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <TrendingUp size={18} className="text-brand-600" />
          <h2 className="text-base font-semibold text-gray-800">پیگیری پیشرفت</h2>
        </div>
      </div>

      {/* Status badges */}
      <div className="mt-4 flex flex-wrap gap-3">
        <div className={`rounded-xl border px-4 py-2.5 ${reportStatus < 0 ? 'border-red-200 bg-red-50/40' : reportStatus <= 3 ? 'border-amber-200 bg-amber-50/40' : 'border-emerald-200 bg-emerald-50/40'}`}>
          <p className="text-[10px] text-gray-500">گزارش دو‌هفته‌ای</p>
          <p className="text-sm font-semibold text-gray-700">
            {reportStatus < 0 ? `${toPersianDigits(Math.abs(reportStatus))} روز عقب افتاده` : reportStatus === 0 ? 'امروز' : `${toPersianDigits(reportStatus)} روز تا موعد`}
          </p>
          <p className="text-[10px] text-gray-400">{formatJalaliShort(nextReportDue)}</p>
        </div>
        <div className={`rounded-xl border px-4 py-2.5 ${evalStatus < 0 ? 'border-red-200 bg-red-50/40' : evalStatus <= 7 ? 'border-amber-200 bg-amber-50/40' : 'border-emerald-200 bg-emerald-50/40'}`}>
          <p className="text-[10px] text-gray-500">ارزیابی ماهانه</p>
          <p className="text-sm font-semibold text-gray-700">
            {evalStatus < 0 ? `${toPersianDigits(Math.abs(evalStatus))} روز عقب افتاده` : evalStatus === 0 ? 'امروز' : `${toPersianDigits(evalStatus)} روز تا موعد`}
          </p>
          <p className="text-[10px] text-gray-400">{formatJalaliShort(nextEvalDue)}</p>
        </div>
      </div>

      {/* Tabs */}
      <div className="mt-4 flex items-center gap-2 border-b border-gray-100">
        <TabButton active={tab === 'reports'} onClick={() => setTab('reports')} icon={<Activity size={14} />} label="گزارش‌های دو‌هفته‌ای" count={reports.length} />
        <TabButton active={tab === 'evaluations'} onClick={() => setTab('evaluations')} icon={<Ruler size={14} />} label="ارزیابی‌های ماهانه" count={evaluations.length} />
        <TabButton active={tab === 'links'} onClick={() => setTab('links')} icon={<Link2 size={14} />} label="لینک گزارش" count={reportLinks.length} />
      </div>

      {/* Reports tab */}
      {tab === 'reports' && (
        <div className="mt-4">
          <button onClick={() => setShowReportForm(true)} className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2 text-sm font-medium text-white hover:bg-brand-700">
            <Plus size={15} /> ثبت گزارش جدید
          </button>
          {reports.length === 0 ? (
            <p className="mt-4 text-sm text-gray-500">هنوز گزارشی ثبت نشده است.</p>
          ) : (
            <div className="mt-4 space-y-2">
              {reports.map((r) => (
                <div key={r.id} className="rounded-xl border border-gray-100 bg-gray-50/40 p-4">
                  <div className="flex items-center justify-between">
                    <span className="text-sm font-semibold text-gray-700">{formatJalaliShort(r.report_date)}</span>
                    {r.period_label && <span className="text-[10px] text-gray-400">{r.period_label}</span>}
                  </div>
                  <div className="mt-2 grid grid-cols-3 gap-2 text-xs text-gray-600">
                    {r.weight_kg != null && <div>وزن: {toPersianDigits(r.weight_kg)} کگ</div>}
                    {r.diet_adherence && <div>پایبندی تغذیه: {r.diet_adherence}</div>}
                    {r.workout_adherence && <div>پایبندی تمرین: {r.workout_adherence}</div>}
                    {r.hunger_level && <div>گرسنگی: {r.hunger_level}</div>}
                    {r.energy_level && <div>انرژی: {r.energy_level}</div>}
                    {r.sleep_quality && <div>خواب: {r.sleep_quality}</div>}
                  </div>
                  {r.student_notes && <p className="mt-2 text-xs text-gray-500 leading-6">{r.student_notes}</p>}
                  {r.coach_private_notes && <p className="mt-1 text-xs text-amber-600 leading-6">یادداشت مربی: {r.coach_private_notes}</p>}
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {/* Evaluations tab */}
      {tab === 'evaluations' && (
        <div className="mt-4">
          <button onClick={() => setShowEvalForm(true)} className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2 text-sm font-medium text-white hover:bg-brand-700">
            <Plus size={15} /> ثبت ارزیابی جدید
          </button>
          {weightHistory.length > 1 && (
            <div className="mt-4 rounded-xl border border-gray-100 bg-gray-50/40 p-4">
              <p className="text-xs font-semibold text-gray-600 mb-3">نمودار تغییرات وزن</p>
              <WeightChart points={weightHistory} />
            </div>
          )}
          {evaluations.length === 0 ? (
            <p className="mt-4 text-sm text-gray-500">هنوز ارزیابی ثبت نشده است.</p>
          ) : (
            <div className="mt-4 overflow-hidden rounded-xl border border-gray-100">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-gray-100 bg-gray-50/60 text-gray-500 text-xs">
                    <th className="px-3 py-2.5 text-right font-medium">تاریخ</th>
                    <th className="px-3 py-2.5 text-right font-medium">وزن</th>
                    <th className="px-3 py-2.5 text-right font-medium">کمر</th>
                    <th className="px-3 py-2.5 text-right font-medium">باسن</th>
                    <th className="px-3 py-2.5 text-right font-medium">سینه</th>
                    <th className="px-3 py-2.5 text-right font-medium">بازو</th>
                    <th className="px-3 py-2.5 text-right font-medium">ران</th>
                  </tr>
                </thead>
                <tbody>
                  {evaluations.map((e, i) => {
                    const prev = evaluations[i + 1];
                    return (
                      <tr key={e.id} className="border-b border-gray-50 last:border-0">
                        <td className="px-3 py-2.5 text-gray-700 font-medium">{formatJalaliShort(e.evaluation_date)}</td>
                        <td className="px-3 py-2.5">
                          {e.weight_kg != null ? toPersianDigits(e.weight_kg) : '—'}
                          {prev?.weight_kg != null && e.weight_kg != null && (
                            <span className={`text-[10px] mr-1 ${e.weight_kg < prev.weight_kg ? 'text-emerald-600' : e.weight_kg > prev.weight_kg ? 'text-red-500' : 'text-gray-400'}`}>
                              ({e.weight_kg < prev.weight_kg ? '−' : e.weight_kg > prev.weight_kg ? '+' : ''}{toPersianDigits(Math.abs(e.weight_kg - prev.weight_kg))})
                            </span>
                          )}
                        </td>
                        <td className="px-3 py-2.5 text-gray-600">{e.waist_cm != null ? toPersianDigits(e.waist_cm) : '—'}</td>
                        <td className="px-3 py-2.5 text-gray-600">{e.hip_cm != null ? toPersianDigits(e.hip_cm) : '—'}</td>
                        <td className="px-3 py-2.5 text-gray-600">{e.chest_cm != null ? toPersianDigits(e.chest_cm) : '—'}</td>
                        <td className="px-3 py-2.5 text-gray-600">{e.arm_cm != null ? toPersianDigits(e.arm_cm) : '—'}</td>
                        <td className="px-3 py-2.5 text-gray-600">{e.thigh_cm != null ? toPersianDigits(e.thigh_cm) : '—'}</td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}

      {/* Links tab */}
      {tab === 'links' && (
        <div className="mt-4">
          <button onClick={handleCreateLink} disabled={saving} className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2 text-sm font-medium text-white hover:bg-brand-700 disabled:opacity-50">
            <Plus size={15} /> ایجاد لینک گزارش جدید
          </button>
          {reportLinks.length === 0 ? (
            <p className="mt-4 text-sm text-gray-500">هنوز لینک گزارشی ایجاد نشده است.</p>
          ) : (
            <div className="mt-4 space-y-2">
              {reportLinks.map((link) => (
                <div key={link.id} className="rounded-xl border border-gray-100 bg-gray-50/40 p-4">
                  <div className="flex items-center justify-between">
                    <div>
                      <span className={`inline-flex rounded-full px-2.5 py-0.5 text-[10px] font-medium ${REPORT_LINK_STATUS_COLORS[link.status]}`}>
                        {REPORT_LINK_STATUS_LABELS[link.status]}
                      </span>
                      {link.due_date && <span className="mr-2 text-xs text-gray-500">موعد: {formatJalaliShort(link.due_date)}</span>}
                    </div>
                    <div className="flex items-center gap-1">
                      <button onClick={() => handleCopyLink(link)} className="flex items-center gap-1 rounded-lg bg-brand-50 px-2.5 py-1.5 text-xs font-medium text-brand-700 hover:bg-brand-100">
                        <Copy size={12} /> {copiedLink === link.id ? 'کپی شد!' : 'کپی لینک'}
                      </button>
                      {link.status === 'active' && (
                        <button onClick={() => handleRevokeLink(link)} className="rounded-lg bg-red-50 px-2.5 py-1.5 text-xs font-medium text-red-700 hover:bg-red-100">لغو</button>
                      )}
                    </div>
                  </div>
                  <p className="mt-1.5 text-[10px] text-gray-400" dir="ltr">{window.location.origin}/#/report/{link.token}</p>
                </div>
              ))}
            </div>
          )}
          <div className="mt-3 rounded-xl border border-amber-100 bg-amber-50/30 p-3">
            <p className="text-[11px] text-amber-700 leading-6">
              <Camera size={12} className="inline ml-1" />
              ذخیره‌سازی عکس‌های پیشرفت نیازمند Supabase Storage با باکت خصوصی است. در حال حاضر زیرساخت آپلود عکس پیاده‌سازی نشده است. عکس‌ها باید پس از راه‌اندازی Storage اضافه شوند.
            </p>
          </div>
        </div>
      )}

      {/* Report form modal */}
      {showReportForm && (
        <ReportFormModal studentId={student.id} onClose={() => setShowReportForm(false)} onSaved={load} />
      )}
      {showEvalForm && (
        <EvalFormModal studentId={student.id} onClose={() => setShowEvalForm(false)} onSaved={load} />
      )}
    </div>
  );
}

function TabButton({ active, onClick, icon, label, count }: { active: boolean; onClick: () => void; icon: React.ReactNode; label: string; count: number }) {
  return (
    <button onClick={onClick} className={`flex items-center gap-1.5 px-3 py-2 text-sm font-medium border-b-2 transition-colors ${active ? 'border-brand-600 text-brand-700' : 'border-transparent text-gray-400 hover:text-gray-600'}`}>
      {icon}
      {label}
      {count > 0 && <span className="rounded-full bg-gray-100 px-1.5 text-[10px] text-gray-500">{toPersianDigits(count)}</span>}
    </button>
  );
}

function WeightChart({ points }: { points: { date: string; weight: number }[] }) {
  if (points.length < 2) return null;
  const weights = points.map(p => p.weight);
  const minW = Math.min(...weights);
  const maxW = Math.max(...weights);
  const range = maxW - minW || 1;
  const w = 300;
  const h = 80;
  const step = w / (points.length - 1);
  const pathData = points.map((p, i) => {
    const x = i * step;
    const y = h - ((p.weight - minW) / range) * (h - 10) - 5;
    return `${i === 0 ? 'M' : 'L'}${x},${y}`;
  }).join(' ');
  return (
    <svg viewBox={`0 0 ${w} ${h}`} className="w-full" style={{ height: h }}>
      <polyline points={pathData.replace(/M|L/g, '').split(' ').map((p, i) => `${i * step},${h - ((points[i].weight - minW) / range) * (h - 10) - 5}`).join(' ')} fill="none" stroke="#227058" strokeWidth="2" />
      {points.map((p, i) => {
        const x = i * step;
        const y = h - ((p.weight - minW) / range) * (h - 10) - 5;
        return <circle key={i} cx={x} cy={y} r="3" fill="#227058" />;
      })}
    </svg>
  );
}

function ReportFormModal({ studentId, onClose, onSaved }: { studentId: string; onClose: () => void; onSaved: () => void }) {
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
  const [coachNotes, setCoachNotes] = useState('');
  const [saving, setSaving] = useState(false);

  const handleSave = async () => {
    setSaving(true);
    await supabase.from('progress_reports').insert({
      student_id: studentId,
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
      coach_private_notes: coachNotes,
    });
    setSaving(false);
    onClose();
    onSaved();
  };

  const inputCls = 'w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100';
  const selectOpts = ['', 'ضعیف', 'متوسط', 'خوب', 'عالی'];

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40" onClick={onClose}>
      <div className="rounded-2xl bg-white p-6 max-w-lg w-full mx-4 max-h-[90vh] overflow-y-auto" onClick={e => e.stopPropagation()}>
        <h3 className="text-sm font-bold text-gray-800 mb-4">گزارش دو‌هفته‌ای جدید</h3>
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
            <div><label className="text-xs text-gray-500 mb-1 block">کیفیت خواب</label><select value={sleep} onChange={e => setSleep(e.target.value)} className={inputCls}>{selectOpts.map(o => <option key={o} value={o}>{o || '—'}</option>)}</select></div>
          </div>
          <div><label className="text-xs text-gray-500 mb-1 block">وضعیت عملکرد تمرینی</label><input value={performance} onChange={e => setPerformance(e.target.value)} className={inputCls} placeholder="..." /></div>
          <div><label className="text-xs text-gray-500 mb-1 block">درد یا مشکل جدید</label><input value={pain} onChange={e => setPain(e.target.value)} className={inputCls} placeholder="..." /></div>
          <div><label className="text-xs text-gray-500 mb-1 block">توضیحات شاگرد</label><textarea value={notes} onChange={e => setNotes(e.target.value)} rows={2} className={inputCls + ' resize-none'} /></div>
          <div><label className="text-xs text-gray-500 mb-1 block">یادداشت خصوصی مربی</label><textarea value={coachNotes} onChange={e => setCoachNotes(e.target.value)} rows={2} className={inputCls + ' resize-none'} /></div>
        </div>
        <div className="mt-4 flex justify-start gap-2">
          <button onClick={handleSave} disabled={saving} className="px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 disabled:opacity-50">{saving ? 'ذخیره...' : 'ثبت گزارش'}</button>
          <button onClick={onClose} className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200">انصراف</button>
        </div>
      </div>
    </div>
  );
}

function EvalFormModal({ studentId, onClose, onSaved }: { studentId: string; onClose: () => void; onSaved: () => void }) {
  const [evalDate, setEvalDate] = useState(todayInTehran());
  const [weight, setWeight] = useState('');
  const [waist, setWaist] = useState('');
  const [hip, setHip] = useState('');
  const [chest, setChest] = useState('');
  const [arm, setArm] = useState('');
  const [thigh, setThigh] = useState('');
  const [notes, setNotes] = useState('');
  const [saving, setSaving] = useState(false);

  const handleSave = async () => {
    setSaving(true);
    await supabase.from('progress_evaluations').insert({
      student_id: studentId,
      evaluation_date: evalDate,
      period_label: `ارزیابی ${formatJalaliShort(evalDate)}`,
      weight_kg: weight ? Number(weight) : null,
      waist_cm: waist ? Number(waist) : null,
      hip_cm: hip ? Number(hip) : null,
      chest_cm: chest ? Number(chest) : null,
      arm_cm: arm ? Number(arm) : null,
      thigh_cm: thigh ? Number(thigh) : null,
      notes: notes,
    });
    setSaving(false);
    onClose();
    onSaved();
  };

  const inputCls = 'w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100';

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40" onClick={onClose}>
      <div className="rounded-2xl bg-white p-6 max-w-lg w-full mx-4" onClick={e => e.stopPropagation()}>
        <h3 className="text-sm font-bold text-gray-800 mb-4">ارزیابی ماهانه جدید</h3>
        <div className="space-y-3">
          <div><label className="text-xs text-gray-500 mb-1 block">تاریخ</label><input type="date" value={evalDate} onChange={e => setEvalDate(e.target.value)} className={inputCls} /></div>
          <div className="grid grid-cols-3 gap-3">
            <div><label className="text-xs text-gray-500 mb-1 block">وزن (کگ)</label><input type="number" value={weight} onChange={e => setWeight(e.target.value)} className={inputCls} /></div>
            <div><label className="text-xs text-gray-500 mb-1 block">کمر (سم)</label><input type="number" value={waist} onChange={e => setWaist(e.target.value)} className={inputCls} /></div>
            <div><label className="text-xs text-gray-500 mb-1 block">باسن (سم)</label><input type="number" value={hip} onChange={e => setHip(e.target.value)} className={inputCls} /></div>
            <div><label className="text-xs text-gray-500 mb-1 block">سینه (سم)</label><input type="number" value={chest} onChange={e => setChest(e.target.value)} className={inputCls} /></div>
            <div><label className="text-xs text-gray-500 mb-1 block">بازو (سم)</label><input type="number" value={arm} onChange={e => setArm(e.target.value)} className={inputCls} /></div>
            <div><label className="text-xs text-gray-500 mb-1 block">ران (سم)</label><input type="number" value={thigh} onChange={e => setThigh(e.target.value)} className={inputCls} /></div>
          </div>
          <div><label className="text-xs text-gray-500 mb-1 block">یادداشت</label><textarea value={notes} onChange={e => setNotes(e.target.value)} rows={2} className={inputCls + ' resize-none'} /></div>
        </div>
        <div className="mt-4 flex justify-start gap-2">
          <button onClick={handleSave} disabled={saving} className="px-5 py-2.5 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 disabled:opacity-50">{saving ? 'ذیره...' : 'ثبت ارزیابی'}</button>
          <button onClick={onClose} className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200">انصراف</button>
        </div>
      </div>
    </div>
  );
}
