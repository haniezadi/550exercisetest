/*
# مرحله پنجم: ردیابی منبع حرکات برنامه شاگرد

## هدف
وقتی یک قالب تمرینی به برنامه شاگرد اختصاص داده می‌شود، حرکات آن
به‌صورت یک «کپی» در `program_exercises` ذخیره می‌شوند. تاکنون هیچ
راهی برای تشخیص منبع هر حرکت وجود نداشت، به همین دلیل برداشتن تیک
قالب نمی‌توانست فقط حرکات همان قالب را حذف کند.

## تغییر
به جدول `program_exercises` ستون `source_template_id` اضافه می‌شود
(nullable uuid، بدون FK چون قالب ممکن است بعداً حذف شود ولی
برنامه شاگرد باید حفظ شود). مقدار پیش‌فرض NULL یعنی «حرکت دستی».

## بازگشت
- این تغییر فقط یک ستون اختیاری اضافه می‌کند؛ هیچ داده‌ای حذف یا
  تغییر نمی‌کند.
- برای بازگشت: `ALTER TABLE program_exercises DROP COLUMN
  source_template_id;` (فقط ستون ردیابی حذف می‌شود، حرکات باقی
  می‌مانند).
- ردیف‌های فعلی NULL باقی می‌مانند (یعنی به‌عنوان «دستی» در نظر
  گرفته می‌شوند) که رفتار امن و سازگار با داده‌های موجود است.

## امنیت
- بدون تغییر RLS. ستون جدید تحت سیاست‌های موجود `program_exercises`
  قرار می‌گیرد.
*/

ALTER TABLE program_exercises
  ADD COLUMN IF NOT EXISTS source_template_id uuid;

CREATE INDEX IF NOT EXISTS idx_program_exercises_source_template
  ON program_exercises(source_template_id);
