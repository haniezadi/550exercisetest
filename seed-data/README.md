# Seed Data

این پوشه شامل داده‌های اولیه قابل نسخه‌بندی برای انتقال به اکانت جدید است.

## نحوه تولید

برای تولید یا به‌روزرسانی فایل‌های seed، اسکریپت زیر را اجرا کنید:

```bash
node scripts/export-seed-data.js
```

این اسکریپت به دیتابیس فعلی متصل می‌شود و داده‌های جدول‌های زیر را به‌صورت فایل JSON خروجی می‌گیرد:

| فایل | جدول | محتوا |
|------|------|--------|
| `exercises.json` | exercises | ۵۵۰ حرکت با لینک‌های ویدئویی |
| `templates.json` | templates | قالب‌های برنامه تمرینی و غذایی |
| `diet_tips.json` | diet_tips | نکات غذایی |
| `corrective_issues.json` | corrective_issues | حرکات اصلاحی |
| `guides.json` | guides | راهنماها |
| `foods.json` | foods | بانک غذاها |
| `food_substitution_groups.json` | food_substitution_groups | گروه‌های جایگزینی |
| `food_substitution_items.json` | food_substitution_items | موارد جایگزینی |

## نکات

- این فایل‌ها **داده‌های اولیه** هستند، نه داده‌های عملیاتی شاگردها.
- داده‌های شاگردها (students, measurements, programs و...) در بکاپ کامل از پنل اپلیکیشن قابل دریافت هستند.
- بکاپ کامل شامل تمام ۳۳ جدول است و باید در مکان امن و خصوصی نگه‌داری شود.
- Migrationهای موجود در `supabase/migrations/` نیز شامل داده‌های اولیه هستند (به‌ویژه `step11_seed_all_exercises` و `step11_chunk_*` که ۵۵۰ حرکت را شامل می‌شوند).
