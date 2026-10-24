import { useState } from 'react';
import { Dumbbell, Loader2, LogIn, UserPlus } from 'lucide-react';
import { useAuth } from '@/lib/auth';

export default function LoginScreen() {
  const { signIn, signUp } = useAuth();
  const [mode, setMode] = useState<'signin' | 'signup'>('signin');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setBusy(true);
    setError(null);
    const { error } = mode === 'signin'
      ? await signIn(email.trim(), password)
      : await signUp(email.trim(), password);
    setBusy(false);
    if (error) setError(error);
  };

  return (
    <div className="min-h-screen bg-[#f6f7f9] flex items-center justify-center p-4" dir="rtl">
      <div className="w-full max-w-sm">
        <div className="flex flex-col items-center mb-6">
          <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-brand-600 text-white">
            <Dumbbell size={24} />
          </div>
          <h1 className="mt-3 text-lg font-bold text-gray-800">پنل طراحی برنامه هانی ایزدی</h1>
          <p className="text-sm text-gray-500">طراحی برنامه تمرینی و غذایی</p>
        </div>

        <div className="bg-white rounded-2xl border border-gray-100 shadow-card p-6">
          <div className="flex gap-1 mb-5 rounded-xl bg-gray-100 p-1">
            <button
              onClick={() => { setMode('signin'); setError(null); }}
              className={`flex-1 flex items-center justify-center gap-1.5 rounded-lg py-2 text-sm font-medium transition-all ${
                mode === 'signin' ? 'bg-white text-gray-800 shadow-sm' : 'text-gray-500'
              }`}
            >
              <LogIn size={15} />
              ورود
            </button>
            <button
              onClick={() => { setMode('signup'); setError(null); }}
              className={`flex-1 flex items-center justify-center gap-1.5 rounded-lg py-2 text-sm font-medium transition-all ${
                mode === 'signup' ? 'bg-white text-gray-800 shadow-sm' : 'text-gray-500'
              }`}
            >
              <UserPlus size={15} />
              ثبت‌نام
            </button>
          </div>

          {error && (
            <div className="mb-4 rounded-xl border border-red-200 bg-red-50 px-4 py-2.5 text-sm text-red-700">
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="flex flex-col gap-4">
            <div className="flex flex-col gap-1.5">
              <label className="text-sm font-medium text-gray-600">ایمیل</label>
              <input
                type="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="coach@example.com"
                dir="ltr"
                className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100 text-left"
              />
            </div>
            <div className="flex flex-col gap-1.5">
              <label className="text-sm font-medium text-gray-600">رمز عبور</label>
              <input
                type="password"
                required
                minLength={6}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="حداقل ۶ کاراکتر"
                dir="ltr"
                className="w-full rounded-xl border border-gray-200 px-3.5 py-2.5 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100 text-left"
              />
            </div>
            <button
              type="submit"
              disabled={busy}
              className="flex items-center justify-center gap-2 rounded-xl bg-brand-600 px-5 py-2.5 text-white text-sm font-medium hover:bg-brand-700 transition-colors disabled:opacity-50"
            >
              {busy ? <Loader2 size={16} className="animate-spin" /> : mode === 'signin' ? <LogIn size={16} /> : <UserPlus size={16} />}
              {mode === 'signin' ? 'ورود به پنل' : 'ساخت حساب'}
            </button>
          </form>
        </div>

        <p className="mt-4 text-center text-xs text-gray-400">
          {mode === 'signin'
            ? 'اگر حساب ندارید، روی «ثبت‌نام» بزنید.'
            : 'پس از ساخت حساب، خودکار وارد می‌شوید.'}
        </p>
      </div>
    </div>
  );
}
