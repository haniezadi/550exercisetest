# راهنمای انتقال پروژه به اکانت جدید

این سند مراحل کامل انتقال پروژه، داده‌ها و بازیابی بکاپ را توضیح می‌دهد.

## پیش‌نیازها

1. اکانت جدید Supabase ایجاد کنید.
2. پروژه را از GitHub کلون کنید:
   ```bash
   git clone https://github.com/haniezadi/550execisetest.git
   cd 550execisetest
   npm install
   ```

3. فایل `.env` را در ریشه پروژه با مقادیر اکانت جدید ایجاد کنید:
   ```
   VITE_SUPABASE_URL=https://<new-project>.supabase.co
   VITE_SUPABASE_ANON_KEY=<new-anon-key>
   ```
   **هشدار:** کلید `SERVICE_ROLE_KEY` را هرگز در `.env` یا GitHub قرار ندهید. فقط در تنظیمات Edge Function در پنل Supabase وارد می‌شود.

## مرحله ۱: اجرای Migrationها

Migrationها در پوشه `supabase/migrations/` قرار دارند. برای اجرای آن‌ها در اکانت جدید:

1. به پنل Supabase اکانت جدید بروید → SQL Editor.
2. فایل‌های Migration را به‌ترتیب زمانی اجرا کنید. ترتیب مهم است چون جدول‌ها به هم وابسته‌اند.

فهرست Migrationها به ترتیب:
1. `20261017060028_create_coach_app_schema.sql` — ساختار اصلی
2. `20261018051623_step1_intake_requests_and_lock_tables.sql`
3. `20261018095554_step2_plans_measurements_reminders.sql`
4. `20261018102956_step3_exercise_bank.sql`
5. `20261018163601_step4_split_program_status_and_seed_template.sql`
6. `20261019051648_step5_program_exercise_source_tracking.sql.sql`
7. `20261020055324_step6_student_coach_notes_and_contact.sql.sql`
8. `20261020140011_step7_diet_meals_food_tips.sql`
9. `20261022130805_step8_pdf_mode_and_seed_data.sql`
10. `20261023045040_create_test_student_negar_ahmadi.sql` — اختیاری (داده تستی)
11. `20261023131557_step9_import_exercises_batch_1.sql.sql`
12. `20261023132154_step10_add_unique_constraint_exercises.sql.sql`
13. `20261024000000_step11_seed_all_exercises.sql` + فایل‌های `step11_chunk_*` — ۵۵۰ حرکت
14. `20261024042307_step10_add_unique_constraint_exercises.sql`
15. `20261024174349_20261024060000_step12_food_bank_substitutions_progress_guides.sql.sql`
16. `20261024184045_step13_progress_photos_storage.sql.sql`

## مرحله ۲: استقرار Edge Functionها

دو Edge Function در پروژه وجود دارد:
- `db-backup` — خروجی کامل دیتابیس به‌صورت JSON قابل دانلود
- `db-restore` — بازیابی از فایل بکاپ (تکرارپذیر)

این توابع با دستور زیر استقرار می‌یابند:
```bash
npx supabase functions deploy db-backup --project-ref <new-project-ref>
npx supabase functions deploy db-restore --project-ref <new-project-ref>
```

**توجه:** متغیرهای `SUPABASE_URL` و `SUPABASE_SERVICE_ROLE_KEY` به‌صورت خودکار در Supabase Edge Functions تنظیم می‌شوند.

## مرحله ۳: ایجاد Storage Bucket

در پنل Supabase اکانت جدید:
1. به Storage → Buckets بروید.
2. یک bucket جدید با نام `progress-photos` ایجاد کنید و گزینه **Private** را فعال کنید.
3. سیاست‌های RLS برای این bucket در Migration مرحله ۱۶ تعریف شده‌اند.

## مرحله ۴: دریافت بکاپ از اکانت قبلی

1. در پنل اپلیکیشن اکانت قبلی، به تب **«تنظیمات و بکاپ»** بروید.
2. روی **«دانلود بکاپ کامل»** کلیک کنید.
3. فایل JSON ذخیره می‌شود (مثلاً `backup-2026-10-24.json`).

این فایل شامل:
- تمام داده‌های ۳۳ جدول
- تعداد رکوردهای هر جدول در بخش `metadata.row_counts`
- لیست فایل‌های Storage bucket `progress-photos`

## مرحله ۵: بازیابی در اکانت جدید

1. در پنل اپلیکیشن اکانت جدید، به تب **«تنظیمات و بکاپ»** بروید.
2. روی **«انتخاب فایل بکاپ و بازیابی»** کلیک کنید.
3. فایل JSON بکاپ را انتخاب کنید.
4. گزارش بازیابی نمایش داده می‌شود: تعداد رکوردهای اضافه‌شده و رد‌شده برای هر جدول.

**ویژگی تکرارپذیری:** اگر رکوردی با همان شناسه (`id`) از قبل وجود داشته باشد، بازنویسی نمی‌شود. بنابراین می‌توانید بازیابی را چند بار بدون نگرانی از داده تکراری اجرا کنید.

### بازیابی فقط داده‌های اولیه (Seed)

اگر می‌خواهید فقط داده‌های اولیه (حرکات، قالب‌ها، نکات، راهنماها) را وارد کنید، می‌توانید درخواست بازیابی را با پارامتر `seedOnly: true` ارسال کنید. این روش برای راه‌اندازی سریع یک اکانت جدید بدون داده‌های عملیاتی مناسب است.

## مرحله ۶: بررسی صحت انتقال

پس از بازیابی، موارد زیر را بررسی کنید:

| جدول | تعداد مورد انتظار |
|------|-------------------|
| exercises | ۵۵۰ |
| diet_tips | ۸ |
| corrective_issues | ۷ |
| templates | ۶ |
| guides | ۴ |
| سایر جداول | بر اساس داده عملیاتی |

برای بررسی دقیق:
1. در پنل، تب «بانک حرکات» را باز کنید — باید ۵۵۰ حرکت نمایش داده شود.
2. لینک‌های ویدئویی ۵۳۵ حرکت را بررسی کنید.
3. تعداد قالب‌ها، نکات و راهنماها را بشمارید.
4. اگر داده‌های شاگرد وجود دارد، اطلاعات آن‌ها را بررسی کنید.

## مرحله ۷: انتقال فایل‌های Storage

فایل‌های عکس پیشرفت در bucket خصوصی `progress-photos` ذخیره می‌شوند. برای انتقال:

1. در اکانت قبلی، از طریق پنل Supabase → Storage → `progress-photos` فایل‌ها را دانلود کنید.
2. در اکانت جدید، همان bucket را ایجاد کنید و فایل‌ها را آپلود کنید.
3. مسیر فایل‌ها در جدول `progress_photos` (ستون `storage_path`) ثبت شده است و باید حفظ شود.

## Push به GitHub (دستی)

به دلیل نبود کلیدهای احراز هویت GitHub در محیط ساخت، Push باید به‌صورت دستی انجام شود:

```bash
# در دایرکتوری پروژه
git remote add origin https://github.com/haniezadi/550execisetest.git
git branch -M main
git push -u origin main
```

اگر مخزن قبلاً وجود دارد و خالی است:
```bash
git push -u origin main --force
```

اگر مخزن محتوای قبلی دارد:
```bash
git pull origin main --rebase
git push -u origin main
```

## نکات امنیتی

- **هرگز** کلید `SERVICE_ROLE_KEY` را در GitHub یا فایل‌های عمومی قرار ندهید.
- فایل `.env` در `.gitignore` قرار دارد و در GitHub آپلود نمی‌شود.
- بکاپ حاوی داده‌های شاگرد است — آن را در مکان امن نگه‌دارید و در GitHub قرار ندهید.
- برای داده‌های اولیه قابل نسخه‌بندی (حرکات، قالب‌ها و...) فقط از Migrationها استفاده کنید.

## خطاها و رفع

### خطای "permission denied for table"
گرانت‌های دسترسی در Migrationها تعریف شده‌اند. اگر این خطا را دریافت کردید، Migration مربوطه را دوباره بررسی کنید.

### جدول `cheat_meal_config` (مفرد)
نام جدول `cheat_meal_config` به‌صورت **مفرد** است. اگر در کد به‌اشتباه `cheat_meal_configs` (جمع) استفاده شده باشد، خطای بارگذاری دیتابیس رخ می‌دهد.

### تعداد حرکات صفر است
اگر پس از اجرای Migrationها تعداد حرکات صفر است:
1. فایل‌های `step11_chunk_*` را به‌ترتیب اجرا کنید.
2. با کوئری `SELECT count(*) FROM exercises;` تعداد را بررسی کنید.
