import { useState, useCallback, useRef } from 'react';
import { supabase } from '@/lib/supabase';
import { Database, Download, Upload, AlertCircle, Loader2, CheckCircle2 } from 'lucide-react';

const BACKUP_TABLES = [
  'students', 'intake_requests', 'student_plans', 'measurements', 'reminders',
  'exercises', 'templates', 'template_exercises', 'assigned_programs',
  'program_exercises', 'diet_template_meals', 'diet_template_food_items',
  'diet_program_meals', 'diet_program_food_items', 'diet_tips', 'diet_program_tips',
  'foods', 'student_favorite_foods', 'food_substitution_groups',
  'food_substitution_items', 'weekly_diet_programs', 'weekly_diet_meals',
  'weekly_diet_food_items', 'meal_substitutions', 'meal_substitution_food_items',
  'cheat_meal_config', 'report_links', 'progress_reports', 'progress_evaluations',
  'progress_photos', 'corrective_issues', 'corrective_issue_exercises', 'guides',
];

export default function BackupRestorePanel({ onRefresh }: { onRefresh: () => Promise<void> }) {
  const [backupLoading, setBackupLoading] = useState(false);
  const [restoreLoading, setRestoreLoading] = useState(false);
  const [message, setMessage] = useState<{ type: 'success' | 'error'; text: string } | null>(null);
  const [restoreResult, setRestoreResult] = useState<Record<string, { inserted: number; skipped: number; errors: string[] }> | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleBackup = useCallback(async () => {
    setBackupLoading(true);
    setMessage(null);
    setRestoreResult(null);
    try {
      const { data: session } = await supabase.auth.getSession();
      const token = session.session?.access_token;
      if (!token) {
        setMessage({ type: 'error', text: 'نشست فعال یافت نشد. لطفاً دوباره وارد شوید.' });
        setBackupLoading(false);
        return;
      }

      const url = `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/db-backup`;
      const resp = await fetch(url, {
        method: 'GET',
        headers: {
          Authorization: `Bearer ${token}`,
          apikey: import.meta.env.VITE_SUPABASE_ANON_KEY,
        },
      });

      if (!resp.ok) {
        const errText = await resp.text();
        throw new Error(`خطا در دریافت بکاپ: ${resp.status} ${errText}`);
      }

      const blob = await resp.blob();
      const filename = `backup-${new Date().toISOString().slice(0, 10)}.json`;
      const a = document.createElement('a');
      a.href = URL.createObjectURL(blob);
      a.download = filename;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      URL.revokeObjectURL(a.href);
      setMessage({ type: 'success', text: `بکاپ کامل دانلود شد: ${filename}` });
    } catch (err) {
      setMessage({ type: 'error', text: err instanceof Error ? err.message : 'خطای ناشناخته' });
    }
    setBackupLoading(false);
  }, []);

  const handleRestore = useCallback(async (file: File, seedOnly: boolean) => {
    setRestoreLoading(true);
    setMessage(null);
    setRestoreResult(null);
    try {
      const text = await file.text();
      const backup = JSON.parse(text);
      if (!backup.data) throw new Error('فایل بکاپ معتبر نیست: فیلد data یافت نشد');

      const { data: session } = await supabase.auth.getSession();
      const token = session.session?.access_token;
      if (!token) {
        setMessage({ type: 'error', text: 'نشست فعال یافت نشد. لطفاً دوباره وارد شوید.' });
        setRestoreLoading(false);
        return;
      }

      const url = `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/db-restore`;
      const resp = await fetch(url, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${token}`,
          apikey: import.meta.env.VITE_SUPABASE_ANON_KEY,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ data: backup.data, seedOnly }),
      });

      if (!resp.ok) {
        const errText = await resp.text();
        throw new Error(`خطا در بازیابی: ${resp.status} ${errText}`);
      }

      const result = await resp.json();
      if (result.success && result.results) {
        setRestoreResult(result.results);
        setMessage({ type: 'success', text: 'بازیابی با موفقیت انجام شد.' });
        await onRefresh();
      } else {
        throw new Error(result.error || 'پاسخ نامعتبر از سرور');
      }
    } catch (err) {
      setMessage({ type: 'error', text: err instanceof Error ? err.message : 'خطای ناشناخته' });
    }
    setRestoreLoading(false);
  }, [onRefresh]);

  const handleFileChange = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    handleRestore(file, false);
    e.target.value = '';
  }, [handleRestore]);

  return (
    <div className="space-y-6" dir="rtl">
      <div className="flex items-center gap-3">
        <Database size={24} className="text-gray-700" />
        <h2 className="text-xl font-bold text-gray-800">تنظیمات و بکاپ</h2>
      </div>

      {message && (
        <div className={`rounded-xl border px-4 py-3 text-sm flex items-start gap-2 ${
          message.type === 'success'
            ? 'border-green-200 bg-green-50 text-green-700'
            : 'border-red-200 bg-red-50 text-red-700'
        }`}>
          {message.type === 'success'
            ? <CheckCircle2 size={18} className="mt-0.5 shrink-0" />
            : <AlertCircle size={18} className="mt-0.5 shrink-0" />}
          <span className="leading-7">{message.text}</span>
        </div>
      )}

      {/* Backup Section */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-card p-6">
        <h3 className="text-base font-semibold text-gray-800 mb-2 flex items-center gap-2">
          <Download size={18} className="text-gray-500" />
          دانلود بکاپ کامل دیتابیس
        </h3>
        <p className="text-sm text-gray-500 leading-7 mb-4">
          تمام داده‌های ۳۳ جدول (شامل ۵۵۰ حرکت و لینک‌های ویدئویی، قالب‌ها، نکات، راهنماها، شاگردها، برنامه‌ها و...) به‌صورت یک فایل JSON دانلود می‌شود. این فایل شامل تعداد رکوردهای هر جدول و متادیتای بکاپ است.
        </p>
        <button
          onClick={handleBackup}
          disabled={backupLoading}
          className="inline-flex items-center gap-2 rounded-xl bg-gray-800 px-5 py-2.5 text-sm font-medium text-white hover:bg-gray-700 transition-colors disabled:opacity-50"
        >
          {backupLoading ? <Loader2 size={16} className="animate-spin" /> : <Download size={16} />}
          {backupLoading ? 'در حال آماده‌سازی...' : 'دانلود بکاپ کامل'}
        </button>
      </div>

      {/* Restore Section */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-card p-6">
        <h3 className="text-base font-semibold text-gray-800 mb-2 flex items-center gap-2">
          <Upload size={18} className="text-gray-500" />
          بازیابی از فایل بکاپ
        </h3>
        <p className="text-sm text-gray-500 leading-7 mb-2">
          فایل بکاپ JSON را انتخاب کنید. بازیابی تکرارپذیر است: رکوردهایی که با همان شناسه وجود دارند، بازنویسی نمی‌شوند.
        </p>
        <div className="rounded-xl bg-amber-50 border border-amber-200 px-4 py-3 text-sm text-amber-700 mb-4 flex items-start gap-2">
          <AlertCircle size={16} className="mt-0.5 shrink-0" />
          <span className="leading-7">
            بازیابی در اکانت فعلی فقط رکوردهای جدید اضافه می‌کند و داده‌های موجود را حذف نمی‌کند. برای انتقال به اکانت جدید، ابتدا Migrationها را در اکانت جدید اجرا کنید، سپس فایل بکاپ را بازیابی کنید.
          </span>
        </div>
        <input
          ref={fileInputRef}
          type="file"
          accept=".json"
          onChange={handleFileChange}
          className="hidden"
        />
        <button
          onClick={() => fileInputRef.current?.click()}
          disabled={restoreLoading}
          className="inline-flex items-center gap-2 rounded-xl border border-gray-200 bg-white px-5 py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors disabled:opacity-50"
        >
          {restoreLoading ? <Loader2 size={16} className="animate-spin" /> : <Upload size={16} />}
          {restoreLoading ? 'در حال بازیابی...' : 'انتخاب فایل بکاپ و بازیابی'}
        </button>
      </div>

      {/* Restore Results */}
      {restoreResult && (
        <div className="bg-white rounded-2xl border border-gray-100 shadow-card p-6">
          <h3 className="text-base font-semibold text-gray-800 mb-4">گزارش بازیابی</h3>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-gray-100 text-gray-500">
                  <th className="text-right py-2 px-3 font-medium">جدول</th>
                  <th className="text-right py-2 px-3 font-medium">رکورد اضافه‌شده</th>
                  <th className="text-right py-2 px-3 font-medium">رکورد رد‌شده</th>
                  <th className="text-right py-2 px-3 font-medium">خطا</th>
                </tr>
              </thead>
              <tbody>
                {Object.entries(restoreResult).map(([table, res]) => (
                  <tr key={table} className="border-b border-gray-50">
                    <td className="py-2 px-3 font-mono text-xs text-gray-700">{table}</td>
                    <td className="py-2 px-3 text-green-600">{res.inserted}</td>
                    <td className="py-2 px-3 text-gray-400">{res.skipped}</td>
                    <td className="py-2 px-3 text-red-500 text-xs">{res.errors.join('; ') || '—'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Table list */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-card p-6">
        <h3 className="text-base font-semibold text-gray-800 mb-3">جداول پشتیبانی‌شده در بکاپ ({BACKUP_TABLES.length} جدول)</h3>
        <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
          {BACKUP_TABLES.map((t) => (
            <span key={t} className="text-xs font-mono text-gray-500 bg-gray-50 rounded-lg px-3 py-1.5">
              {t}
            </span>
          ))}
        </div>
      </div>
    </div>
  );
}
