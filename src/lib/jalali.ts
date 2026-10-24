import { toJalaali, toGregorian, jalaaliMonthLength as _jalaaliMonthLength } from 'jalaali-js';

export interface JalaliDate {
  jy: number;
  jm: number;
  jd: number;
}

export const JALALI_MONTHS = [
  'فروردین',
  'اردیبهشت',
  'خرداد',
  'تیر',
  'مرداد',
  'شهریور',
  'مهر',
  'آبان',
  'آذر',
  'دی',
  'بهمن',
  'اسفند',
];

export const JALALI_WEEKDAYS = ['شنبه', 'یک‌شنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنج‌شنبه', 'جمعه'];

/** Convert ISO date string (YYYY-MM-DD) to a Jalali {jy,jm,jd} object. */
export function isoToJalali(iso: string): JalaliDate | null {
  if (!iso) return null;
  // Strip any time/timezone portion — these are date-only fields.
  const datePart = iso.length >= 10 ? iso.slice(0, 10) : iso;
  const m = datePart.match(/^(\d{4})-(\d{2})-(\d{2})$/);
  if (!m) return null;
  const gy = Number(m[1]);
  const gm = Number(m[2]);
  const gd = Number(m[3]);
  const j = toJalaali(gy, gm, gd);
  return { jy: j.jy, jm: j.jm, jd: j.jd };
}

/** Convert a Jalali {jy,jm,jd} to ISO date string (YYYY-MM-DD). */
export function jalaliToIso(j: JalaliDate): string {
  const g = toGregorian(j.jy, j.jm, j.jd);
  const y = g.gy;
  const m = String(g.gm).padStart(2, '0');
  const d = String(g.gd).padStart(2, '0');
  return `${y}-${m}-${d}`;
}

/** Convert ISO datetime (e.g. created_at with time) to Jalali, using Tehran tz. */
export function isoDateTimeToJalali(iso: string): JalaliDate | null {
  if (!iso) return null;
  // Convert to Tehran date to avoid UTC day-shift, then take YYYY-MM-DD.
  const tehranDate = new Date(iso).toLocaleDateString('en-CA', { timeZone: 'Asia/Tehran' });
  return isoToJalali(tehranDate);
}

const faDigits = '۰۱۲۳۴۵۶۷۸۹';
/** Convert Latin digits in a string to Persian digits. */
export function toPersianDigits(s: string | number): string {
  return String(s).replace(/[0-9]/g, (d) => faDigits[Number(d)]);
}

/** Convert Persian/Arabic digits in a string to Latin digits. */
export function toLatinDigits(s: string): string {
  return s
    .replace(/[۰-۹]/g, (d) => String(faDigits.indexOf(d)))
    .replace(/[٠-٩]/g, (d) => String('٠١٢٣٤٥٦٧٨٩'.indexOf(d)));
}

export function normalizePersianText(s: string): string {
  return toLatinDigits(s)
    .replace(/\u064A/g, '\u06CC')
    .replace(/\u0643/g, '\u06A9')
    .replace(/\u0629/g, '\u0647')
    .replace(/\u0649/g, '\u06CC')
    .replace(/\u0623/g, '\u0627')
    .replace(/\u0625/g, '\u0627')
    .replace(/\u0622/g, '\u0627')
    .replace(/\u0640/g, '')
    .replace(/\s+/g, ' ')
    .trim();
}

/** Format an ISO date as a Jalali string like "۱۴۰۵/۰۷/۲۸". */
export function formatJalaliShort(iso: string | null | undefined): string {
  if (!iso) return '—';
  const j = isoToJalali(iso);
  if (!j) return '—';
  return toPersianDigits(
    `${j.jy}/${String(j.jm).padStart(2, '0')}/${String(j.jd).padStart(2, '0')}`,
  );
}

/** Format an ISO date as a Jalali long string like "۲۸ مهر ۱۴۰۵". */
export function formatJalaliLong(iso: string | null | undefined): string {
  if (!iso) return '—';
  const j = isoToJalali(iso);
  if (!j) return '—';
  return `${toPersianDigits(j.jd)} ${JALALI_MONTHS[j.jm - 1]} ${toPersianDigits(j.jy)}`;
}

/** Format an ISO datetime as a Jalali long string (Tehran tz, no time). */
export function formatJalaliDateTime(iso: string | null | undefined): string {
  if (!iso) return '—';
  const j = isoDateTimeToJalali(iso);
  if (!j) return '—';
  return `${toPersianDigits(j.jd)} ${JALALI_MONTHS[j.jm - 1]} ${toPersianDigits(j.jy)}`;
}

/** Number of days in a given Jalali month. */
export function jalaliMonthLength(jy: number, jm: number): number {
  return _jalaaliMonthLength(jy, jm);
}

/** weekday (0=Sat..6=Fri) of a Jalali date. */
export function jalaliWeekday(j: JalaliDate): number {
  const iso = jalaliToIso(j);
  const d = new Date(iso + 'T00:00:00');
  // JS: 0=Sun..6=Sat. Convert to 0=Sat..6=Fri.
  return (d.getDay() + 1) % 7;
}

/** Parse a user-typed Jalali string in day/month/year order like "28/07/1405" or "۲۸/۰۷/۱۴۰۵". */
export function parseJalaliInput(input: string): JalaliDate | null {
  const latin = toLatinDigits(input.trim()).replace(/[\u06f0-\u06f9]/g, '');
  const m = latin.match(/^(\d{1,2})[/\-.](\d{1,2})[/\-.](\d{4})$/);
  if (!m) return null;
  const jd = Number(m[1]);
  const jm = Number(m[2]);
  const jy = Number(m[3]);
  if (jm < 1 || jm > 12) return null;
  if (jd < 1 || jd > jalaliMonthLength(jy, jm)) return null;
  if (jy < 1300 || jy > 1500) return null;
  return { jy, jm, jd };
}

/** Format a Jalali date for input display in day/month/year order like "۲۸/۰۷/۱۴۰۵". */
export function jalaliToInputString(j: JalaliDate | null): string {
  if (!j) return '';
  return toPersianDigits(
    `${String(j.jd).padStart(2, '0')}/${String(j.jm).padStart(2, '0')}/${j.jy}`,
  );
}
