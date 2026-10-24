/*
# Add pdf_mode to diet_program_tips + seed preset diet templates and tips

## Changes

### 1. New column: diet_program_tips.pdf_mode
- Adds `pdf_mode` text column with default 'full' to `diet_program_tips`.
- Controls whether a tip appears in the full PDF, the tips-only PDF, or neither.
- Values: 'full' (both PDFs), 'tips_only' (only tips PDF), 'none' (excluded from PDFs).
- This is a non-destructive ALTER TABLE ADD COLUMN — no data is lost.

### 2. Seed preset diet tips
- Inserts 8 ready-made diet tips across different categories (daily, fasting, flex_meal, restaurant, travel, sick_day, maintenance, relapse).
- Uses ON CONFLICT DO NOTHING to be idempotent — re-running won't create duplicates.
- Tips are active by default and serve as a starting library for the coach.

### 3. Seed preset diet templates
- Inserts 6 diet template entries (reduction standard, intermittent fasting, carb cycling, budget, high protein, maintenance).
- Templates are created with type='diet' and a description.
- Meals and food items are NOT seeded here — the coach will populate them via the UI.
- This avoids hardcoding specific food quantities that may not suit all students.

## Security
- No RLS or policy changes — existing policies on these tables remain unchanged.
- No new tables created.
*/

-- 1. Add pdf_mode column to diet_program_tips
ALTER TABLE diet_program_tips
  ADD COLUMN IF NOT EXISTS pdf_mode text NOT NULL DEFAULT 'full';

-- 2. Seed preset diet tips (idempotent via ON CONFLICT)
INSERT INTO diet_tips (category, title, body, is_active, sort_order)
SELECT * FROM (VALUES
  ('daily', 'آب کافی بنوشید', 'روزانه حداقل ۸ لیوان آب بنوشید. آب کافی به متابولیسم کمک می‌کند و احساس گرسنگی کاذب را کاهش می‌دهد.', true, 0),
  ('fasting', 'زمان‌بندی وعده‌ها در فستینگ', 'در الگوی فستینگ متناوب ۱۶:۸، بازه خوردن ۸ ساعت است. وعده‌های اصلی را در این بازه برنامه‌ریزی کنید و از خوردن خارج از بازه خودداری کنید.', true, 1),
  ('flex_meal', 'وعده انعطاف‌پذیر', 'هفته‌ای یک وعده می‌توانید آزادانه‌تر غذا بخورید، اما به یک وعده محدود شود و بیش از حد مجاز کالری نگیرید.', true, 2),
  ('restaurant', 'غذا خوردن در رستوران', 'در رستوران از غذاهای پخته شده (گریل، بخارپز) استفاده کنید. از غذاهای سرخ‌کرده و سس‌های کرم‌دار خودداری کنید. درخواست کنید سس جدا داده شود.', true, 3),
  ('travel', 'تغذیه در سفر', 'در سفر از میان‌وعده‌های سالم مانند آجیل، میوه خشک یا پروتئین بار استفاده کنید. در فرودگاه از غذاهای فست‌فود خودداری کنید.', true, 4),
  ('sick_day', 'تغذیه در روز بیماری', 'در روزهایی که احساس ضعف دارید، کالری را کمی افزایش دهید و از غذاهای سبک و مغذی مانند سوپ مرغ، برنج و سبزیجات بخورید. برنامه را پس از بهبودی از سر بگیرید.', true, 5),
  ('maintenance', 'روزهای تثبیت کالری', 'در روزهای تثبیت، کالری را در محدوده هدف نگه دارید. وزن را هفته‌ای یک‌بار در شرایط ثابت (صبح ناشتا) اندازه بگیرید.', true, 6),
  ('relapse', 'بازگشت به برنامه', 'اگر یک روز از برنامه خارج شدید، احساس گناه نکنید. روز بعد بدون تغییر، همان برنامه اصلی را اجرا کنید. جبران با کاهش کالری بیشتر توصیه نمی‌شود.', true, 7)
) AS v(category, title, body, is_active, sort_order)
WHERE NOT EXISTS (SELECT 1 FROM diet_tips LIMIT 1);

-- 3. Seed preset diet templates (idempotent)
INSERT INTO templates (type, name, description)
SELECT * FROM (VALUES
  ('diet', 'کاهش وزن استاندارد', 'برنامه غذایی متعادل برای کاهش وزن تدریجی و پایدار. مناسب اکثر افراد با هدف کاهش ۰.۵ تا ۱ کیلوگرم در هفته.'),
  ('diet', 'فستینگ متناوب ۱۶:۸', 'برنامه غذایی با الگوی روزه‌داری متناوب ۱۶ ساعت ناشتایی و ۸ ساعت بازه خوردن. مناسب برای بهبود حساسیت به انسولین و چربی‌سوزی.'),
  ('diet', 'کرب‌سایکلینگ', 'برنامه با تغییر متناوب کربوهیدرات در روزهای تمرین و استراحت. مناسب افراد فعال با هدف کاهش چربی و حفظ عضله.'),
  ('diet', 'برنامه اقتصادی', 'برنامه غذایی مقرون‌به‌صرفه با مواد غذایی در دسترس و ارزان. مناسب برای بودجه محدود بدون افت کیفیت.'),
  ('diet', 'پروتئین بالا', 'برنامه با پروتئین بالاتر از حد استاندارد برای حفظ توده عضلانی در دوره کاهش وزن. مناسب افراد ورزشکار.'),
  ('diet', 'نگهدارنده وزن', 'برنامه برای حفظ وزن فعلی بدون کاهش یا افزایش. مناسب پس از پایان دوره کاهش وزن.')
) AS v(type, name, description)
WHERE NOT EXISTS (SELECT 1 FROM templates WHERE type = 'diet' LIMIT 1);
