import { useMemo, useState } from 'react';
import { ChevronRight, ChevronLeft, Calendar } from 'lucide-react';
import {
  JALALI_MONTHS,
  JALALI_WEEKDAYS,
  type JalaliDate,
  jalaliMonthLength,
  jalaliWeekday,
  jalaliToIso,
  isoToJalali,
  jalaliToInputString,
  parseJalaliInput,
  toPersianDigits,
} from '@/lib/jalali';

interface JalaliDatePickerProps {
  value: string; // ISO YYYY-MM-DD or ''
  onChange: (iso: string) => void;
  placeholder?: string;
  label?: string;
  required?: boolean;
}

export default function JalaliDatePicker({
  value,
  onChange,
  placeholder = '۲۸/۰۷/۱۴۰۵',
  label,
  required,
}: JalaliDatePickerProps) {
  const initial = value ? isoToJalali(value) : null;
  const [text, setText] = useState(initial ? jalaliToInputString(initial) : '');
  const [open, setOpen] = useState(false);
  const [view, setView] = useState<JalaliDate>(
    initial ?? { jy: 1405, jm: 7, jd: 28 },
  );
  const [error, setError] = useState<string | null>(null);

  const commitText = (raw: string) => {
    if (!raw.trim()) {
      setError(null);
      onChange('');
      return;
    }
    const j = parseJalaliInput(raw);
    if (!j) {
      setError('تاریخ نامعتبر است (مثال: ۲۸/۰۷/۱۴۰۵)');
      return;
    }
    setError(null);
    onChange(jalaliToIso(j));
    setView(j);
  };

  const grid = useMemo(() => {
    const len = jalaliMonthLength(view.jy, view.jm);
    const firstWeekday = jalaliWeekday({ jy: view.jy, jm: view.jm, jd: 1 });
    const cells: (JalaliDate | null)[] = [];
    for (let i = 0; i < firstWeekday; i++) cells.push(null);
    for (let d = 1; d <= len; d++) {
      cells.push({ jy: view.jy, jm: view.jm, jd: d });
    }
    return cells;
  }, [view]);

  const selected = value ? isoToJalali(value) : null;

  const prevMonth = () => {
    setView((v) => {
      let jm = v.jm - 1;
      let jy = v.jy;
      if (jm < 1) {
        jm = 12;
        jy -= 1;
      }
      return { jy, jm, jd: 1 };
    });
  };
  const nextMonth = () => {
    setView((v) => {
      let jm = v.jm + 1;
      let jy = v.jy;
      if (jm > 12) {
        jm = 1;
        jy += 1;
      }
      return { jy, jm, jd: 1 };
    });
  };

  const pick = (j: JalaliDate) => {
    onChange(jalaliToIso(j));
    setText(jalaliToInputString(j));
    setError(null);
    setOpen(false);
  };

  return (
    <div className="flex flex-col gap-1.5 relative">
      {label && (
        <label className="text-sm font-medium text-gray-600">
          {label}
          {required && <span className="text-red-500 mr-1">*</span>}
        </label>
      )}
      <div className="relative">
        <input
          type="text"
          value={text}
          onChange={(e) => {
            setText(e.target.value);
            setError(null);
          }}
          onBlur={(e) => commitText(e.target.value)}
          placeholder={placeholder}
          dir="ltr"
          className={`w-full rounded-xl border px-3.5 py-2.5 pr-10 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100 text-left ${
            error ? 'border-red-300 bg-red-50/40' : 'border-gray-200'
          }`}
        />
        <button
          type="button"
          onClick={() => setOpen((o) => !o)}
          className="absolute left-2 top-1/2 -translate-y-1/2 p-1 text-gray-400 hover:text-brand-600"
          aria-label="تقویم"
        >
          <Calendar size={16} />
        </button>
      </div>
      {error && <span className="text-xs text-red-500">{error}</span>}

      {open && (
        <div className="absolute z-50 mt-1 w-72 rounded-2xl border border-gray-200 bg-white p-3 shadow-cardHover">
          <div className="flex items-center justify-between mb-2">
            <button
              type="button"
              onClick={prevMonth}
              className="p-1 rounded-lg text-gray-500 hover:bg-gray-100"
            >
              <ChevronRight size={18} />
            </button>
            <span className="text-sm font-semibold text-gray-800">
              {JALALI_MONTHS[view.jm - 1]} {toPersianDigits(view.jy)}
            </span>
            <button
              type="button"
              onClick={nextMonth}
              className="p-1 rounded-lg text-gray-500 hover:bg-gray-100"
            >
              <ChevronLeft size={18} />
            </button>
          </div>
          <div className="grid grid-cols-7 gap-1 mb-1">
            {JALALI_WEEKDAYS.map((w) => (
              <div key={w} className="text-center text-[10px] text-gray-400">
                {w.slice(0, 1)}
              </div>
            ))}
          </div>
          <div className="grid grid-cols-7 gap-1">
            {grid.map((c, i) => {
              if (!c) return <div key={i} />;
              const isSelected =
                selected &&
                selected.jy === c.jy &&
                selected.jm === c.jm &&
                selected.jd === c.jd;
              return (
                <button
                  key={i}
                  type="button"
                  onClick={() => pick(c)}
                  className={`h-8 rounded-lg text-xs transition-colors ${
                    isSelected
                      ? 'bg-brand-600 text-white font-semibold'
                      : 'text-gray-700 hover:bg-brand-50'
                  }`}
                >
                  {toPersianDigits(c.jd)}
                </button>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
