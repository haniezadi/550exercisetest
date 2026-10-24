// Form field definitions for the public intake form.
// Each step groups related questions for a short, focused screen.

export type FieldType = 'text' | 'number' | 'select' | 'multiselect' | 'textarea';

export interface FieldDef {
  key: string;
  label: string;
  type: FieldType;
  options?: string[];
  required?: boolean;
  placeholder?: string;
  allowUnknown?: boolean;
  min?: number;
  max?: number;
  unit?: string;
}

export interface FormStep {
  id: string;
  title: string;
  subtitle: string;
  fields: FieldDef[];
}

export const FORM_STEPS: FormStep[] = [
  {
    id: 'personal',
    title: 'مشخصات فردی',
    subtitle: 'لطفاً اطلاعات پایه خود را وارد کنید',
    fields: [
      { key: 'name', label: 'نام و نام خانوادگی', type: 'text', required: true, placeholder: 'مثال: سارا محمدی' },
      { key: 'age', label: 'سن', type: 'number', required: true, min: 10, max: 100, unit: 'سال' },
      { key: 'gender', label: 'جنسیت', type: 'select', options: ['زن', 'مرد'], allowUnknown: true },
      { key: 'height_cm', label: 'قد', type: 'number', min: 100, max: 230, unit: 'سانتی‌متر', allowUnknown: true },
      { key: 'weight_kg', label: 'وزن فعلی', type: 'number', min: 30, max: 250, unit: 'کیلوگرم', allowUnknown: true },
    ],
  },
  {
    id: 'goal',
    title: 'هدف شما',
    subtitle: 'به ما کمک کنید هدفتان را دقیق‌تر بشناسیم',
    fields: [
      {
        key: 'primary_goal',
        label: 'هدف اصلی شما چیست؟',
        type: 'select',
        required: true,
        options: ['کاهش وزن', 'افزایش عضله', 'کاهش چربی و افزایش عضله', 'تن‌اندام و فرم‌دهی', 'بهبود سلامت عمومی', 'افزایش نیرو و قدرت'],
      },
      { key: 'target_weight_kg', label: 'وزن هدف (اختیاری)', type: 'number', min: 30, max: 250, unit: 'کیلوگرم', allowUnknown: true },
      {
        key: 'timeframe',
        label: 'در چه بازهٔ زمانی؟',
        type: 'select',
        options: ['یک ماه', '۳ ماه', '۶ ماه', 'یک سال', 'نمی‌دانم'],
        allowUnknown: true,
      },
    ],
  },
  {
    id: 'history',
    title: 'سابقه تمرین',
    subtitle: 'تجربه‌های ورزشی قبلی شما',
    fields: [
      {
        key: 'experience_level',
        label: 'سطح تجربهٔ تمرینی',
        type: 'select',
        required: true,
        options: ['بدون سابقه', 'مبتدی (کمتر از ۶ ماه)', 'متوسط (۶ ماه تا ۲ سال)', 'پیشرفته (بیش از ۲ سال)'],
      },
      {
        key: 'current_activity',
        label: 'فعالیت ورزشی فعلی',
        type: 'select',
        options: ['هیچ', 'هرازگاهی پیاده‌روی', 'هفته‌ای ۱-۲ جلسه', 'هفته‌ای ۳-۴ جلسه', 'روزانه'],
        allowUnknown: true,
      },
      {
        key: 'preferred_workouts',
        label: 'چه نوع تمرین‌هایی را ترجیح می‌دهید؟',
        type: 'multiselect',
        options: ['بدنسازی با وزنه', 'بدنسازی با دستگاه', 'هییت (HIIT)', 'کاردیو', 'پیاده‌روی', 'دویدن', 'یوگا/ Pilates', 'تمرین گروهی'],
      },
    ],
  },
  {
    id: 'health',
    title: 'وضعیت سلامت و محدودیت‌ها',
    subtitle: 'این اطلاعات محرمانه می‌ماند و فقط برای ایمنی برنامه استفاده می‌شود',
    fields: [
      {
        key: 'health_issues',
        label: 'آیا مشکل سلامتی خاصی دارید؟',
        type: 'multiselect',
        options: ['فشار خون بالا', 'دیابت', 'مشکلات مفصلی یا ستون فقرات', 'بیماری قلبی', 'آلرژی غذایی', 'تنگی نفس/آسم', 'سابقه جراحی', 'هیچ‌کدام'],
      },
      {
        key: 'medications',
        label: 'آیا داروی خاصی مصرف می‌کنید؟',
        type: 'text',
        placeholder: 'در صورت وجود بنویسید',
        allowUnknown: true,
      },
      {
        key: 'injuries',
        label: 'آیا محدودیت حرکتی یا آسیب‌دیدگی دارید؟',
        type: 'textarea',
        placeholder: 'مثال: زانوی راست در اسکات درد می‌گیرد',
        allowUnknown: true,
      },
      {
        key: 'smoking',
        label: 'وضعیت سیگار',
        type: 'select',
        options: ['سیگاری', 'ترک کرده', 'بدون سیگار'],
        allowUnknown: true,
      },
    ],
  },
  {
    id: 'nutrition',
    title: 'تغذیه',
    subtitle: 'عادت‌های غذایی فعلی شما',
    fields: [
      {
        key: 'meals_per_day',
        label: 'روزانه چند وعده غذا می‌خورید؟',
        type: 'select',
        options: ['۱ وعده', '۲ وعده', '۳ وعده', '۴ وعده', 'بیشتر'],
        allowUnknown: true,
      },
      {
        key: 'diet_type',
        label: 'نوع رژیم غذایی',
        type: 'select',
        options: ['معمولی/مختلط', 'گیاهی (وگان)', 'گیاه‌خوار', 'پروتئین بالا', 'کم‌کربوهیدرات', 'کتوژنیک', 'بدون رژیم خاص'],
        allowUnknown: true,
      },
      {
        key: 'food_allergies',
        label: 'حساسیت غذایی یا محدودیت',
        type: 'text',
        placeholder: 'مثال: لاکتوز، گلوتن',
        allowUnknown: true,
      },
      {
        key: 'water_intake',
        label: 'میانگین مصرف آب روزانه',
        type: 'select',
        options: ['کمتر از ۱ لیتر', '۱-۲ لیتر', '۲-۳ لیتر', 'بیشتر از ۳ لیتر'],
        allowUnknown: true,
      },
    ],
  },
  {
    id: 'lifestyle',
    title: 'سبک زندگی',
    subtitle: 'برای برنامه‌ریزی دقیق‌تر',
    fields: [
      {
        key: 'job_type',
        label: 'نوع شغل از نظر فعالیت بدنی',
        type: 'select',
        options: ['تحرک کم (پشت میز)', 'نیمه‌فعال', 'فعال', 'سنگین'],
        allowUnknown: true,
      },
      {
        key: 'sleep_hours',
        label: 'میانگین خواب شبانه',
        type: 'select',
        options: ['کمتر از ۵ ساعت', '۵-۶ ساعت', '۷-۸ ساعت', 'بیشتر از ۸ ساعت'],
        allowUnknown: true,
      },
      {
        key: 'stress_level',
        label: 'سطح استرس روزانه',
        type: 'select',
        options: ['پایین', 'متوسط', 'زیاد', 'خیلی زیاد'],
        allowUnknown: true,
      },
    ],
  },
  {
    id: 'facilities',
    title: 'امکانات تمرین',
    subtitle: 'با چه امکاناتی می‌توانید تمرین کنید؟',
    fields: [
      {
        key: 'workout_location',
        label: 'کجا تمرین می‌کنید؟',
        type: 'select',
        required: true,
        options: ['باشگاه بدنسازی', 'خانه با وزنه', 'خانه بدون وزنه', 'هیچ‌کدام'],
      },
      {
        key: 'available_days',
        label: 'هفته‌ای چند روز می‌توانید تمرین کنید؟',
        type: 'select',
        options: ['۱ روز', '۲ روز', '۳ روز', '۴ روز', '۵ روز یا بیشتر'],
        allowUnknown: true,
      },
      {
        key: 'session_duration',
        label: 'هر جلسه چقدر زمان دارید؟',
        type: 'select',
        options: ['۳۰ دقیقه', '۴۵ دقیقه', '۶۰ دقیقه', '۹۰ دقیقه'],
        allowUnknown: true,
      },
    ],
  },
  {
    id: 'contact',
    title: 'اطلاعات پیگیری',
    subtitle: 'برای تماس و هماهنگی',
    fields: [
      { key: 'phone', label: 'شماره تماس', type: 'text', required: true, placeholder: 'مثال: ۰۹۱۲۳۴۵۶۷۸۹' },
      { key: 'email', label: 'ایمیل', type: 'text', placeholder: 'example@email.com', allowUnknown: true },
      {
        key: 'contact_method',
        label: 'روش ترجیحی برای تماس',
        type: 'select',
        options: ['تماس تلفنی', 'پیامک', 'تلگرام', 'واتس‌اپ', 'ایمیل'],
        allowUnknown: true,
      },
      { key: 'notes', label: 'یادداشت یا نکتهٔ اضافه', type: 'textarea', placeholder: 'هر چیز دیگری که لازم است مربی بداند' },
    ],
  },
];

export const UNKNOWN_VALUE = 'در حال حاضر مشخص نیست';

export function createEmptyFormValues(): Record<string, unknown> {
  const values: Record<string, unknown> = {};
  for (const step of FORM_STEPS) {
    for (const field of step.fields) {
      if (field.type === 'multiselect') {
        values[field.key] = [] as string[];
      } else {
        values[field.key] = '';
      }
    }
  }
  return values;
}
