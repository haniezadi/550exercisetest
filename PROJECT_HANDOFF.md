# PROJECT_HANDOFF — پنل طراحی برنامه هانی ایزدی

> این فایل برای انتقال پروژه نوشته شده است.
> هوش مصنوعی بعدی باید این فایل را **قبل از هر کاری** بخواند.

---

## A. معرفی پروژه

**نام:** پنل طراحی برنامه هانی ایزدی
**هدف:** پنل مدیریت مربی برای طراحی برنامه تمرینی و غذایی شاگردها، با بانک حرکات، قالب‌ها، نکات اجرایی رژیم، خروجی PDF، و مدیریت پلن/پرداخت.

### فناوری‌های اصلی

- **Frontend:** React 18 + TypeScript + Vite 5
- **Styling:** Tailwind CSS 3 (RTL، فارسی، فونت Vazirmatn)
- **Icons:** lucide-react
- **Backend:** Supabase (Postgres + RLS + Auth)
- **تاریخ شمسی:** jalaali-js
- **خروجی PDF:** PrintLayout component با cover page، فهرست مطالب، شماره صفحه، سه حالت (کامل/غذایی/نکات)

### روش اجرای پروژه

- `npm run dev` — اجرای dev server
- `npm run build` — build تولیدی
- `npm run typecheck` — بررسی TypeScript
- dev server در Bolt به‌صورت خودکار اجرا می‌شود.

---

## B. وضعیت قابلیت‌ها (۲۰۲۶-۱۰-۲۴)

### قابلیت‌های کامل‌شده

| قابلیت | وضعیت | توضیح |
|---|---|---|
| پروفایل و جست‌وجوی شاگردها | ✅ | جست‌وجو بر اساس نام و شماره |
| کارت‌های آماری داشبورد | ✅ | فیلتر با کلیک روی کارت |
| تاریخ‌های شمسی | ✅ | JalaliDatePicker + تبدیل در lib/jalali.ts |
| قالب‌های تمرینی و غذایی | ✅ | TemplateEditor |
| طراحی برنامه تمرینی | ✅ | WorkoutProgramModal با انتخاب از قالب یا بانک حرکات |
| طراحی برنامه غذایی (قدیمی) | ✅ | DietProgramModal با وعده‌ها، مواد، کالری/پروتئین |
| بانک حرکات و ویدئوها | ✅ | **۵۵۰ حرکت** در دیتابیس |
| خروجی PDF | ✅ | PrintLayout با cover page، جدول مواد، جدول حرکات با لینک، نکات |
| احراز هویت | ✅ | ایمیل/پسورد via Supabase Auth |
| یادآورها | ✅ | یادآور اندازه‌گیری و تمدید پلن |
| **بانک غذاها** | ✅ | FoodBankView — CRUD کامل با دسته‌بندی، کالری/پروتئین، واحد خانگی |
| **بانک جایگزین‌های عمومی** | ✅ | SubstitutionBankView — گروه‌ها و موارد، PDF مستقل |
| **راهنماهای قابل ارسال** | ✅ | GuidesView — ۴ راهنمای seed شده، CRUD + PDF مستقل |
| **پیگیری پیشرفت** | ✅ | ProgressView در پروفایل شاگرد — گزارش دو‌هفته‌ای، ارزیابی ماهانه، لینک گزارش |
| **چیت‌میل** | ✅ | WeeklyDietModal با پیکربندی چیت‌میل (فعال/غیرفعال) |
| **برنامه غذایی هفتگی** | ✅ | WeeklyDietModal — شنبه تا جمعه، ۶ وعده، کپی روز/وعده، جمع کالری/پروتئین |
| **جایگزین اختصاصی وعده** | ✅ | WeeklyDietModal — جایگزین‌های هر وعده با مواد |
| **بانک غذاها مستقل از برنامه** | ✅ | snapshot columns در weekly_diet_food_items |

### قابلیت‌های بخشی پیاده‌سازی‌شده

| قابلیت | وضعیت | توضیح |
|---|---|---|
| غذاهای پرتکرار شاگرد | 🔶 | جدول student_favorite_foods ساخته شده اما UI در StudentDetail اضافه نشده |
| حرکات اصلاحی | 🔶 | جدول‌ها و seed ساخته شده اما ابزار انتخاب در پنل نیست |
| لینک گزارش عمومی | 🔶 | لینک ساخته و کپی می‌شود اما صفحه عمومی `#/report/:token` پیاده نشده |
| خروجی Word | 🔶 | پیاده‌سازی نشده — نیاز به بازنویسی |
| طراحی دفترچه جدید (Part 1) | 🔶 | PrintLayout فعلی با navy/orange کار می‌کند اما سبز/طلایی درخواستی نیست |

### قابلیت‌های انجام‌نشده

| قابلیت | وضعیت | توضیح |
|---|---|---|
| آپلود عکس پیشرفت | ❌ | نیازمند Supabase Storage با باکت خصوصی |
| صفحه عمومی ثبت گزارش | ❌ | Edge function یا صفحه عمومی برای `#/report/:token` |
| ادغام WeeklyDietModal در App | ❌ | کامپوننت ساخته شده ولی به App متصل نیست |
| ویرایش PrintLayout برای سبز/طلایی | ❌ | CSS فعلی navy/orange است |
| بکاپ واقعی داده‌ها | ❌ | ابزار pg_dump در این محیط موجود نیست |

---

## C. وضعیت دیتابیس

### ۳۳ جدول (۱۶ اصلی + ۱۷ جدید)

**جداول اصلی (۱۶):** students, intake_requests, student_plans, measurements, reminders, templates, template_exercises, assigned_programs, program_exercises, exercises, diet_template_meals, diet_template_food_items, diet_program_meals, diet_program_food_items, diet_tips, diet_program_tips

**جداول جدید (۱۷):** foods, student_favorite_foods, food_substitution_groups, food_substitution_items, weekly_diet_programs, weekly_diet_meals, weekly_diet_food_items, meal_substitutions, meal_substitution_food_items, cheat_meal_config, report_links, progress_reports, progress_evaluations, progress_photos, corrective_issues, corrective_issue_exercises, guides

### تعداد رکوردها

| جدول | تعداد |
|---|---|
| exercises | ۵۵۰ |
| diet_tips | ۸ |
| corrective_issues | ۷ (seed) |
| templates | ۶ |
| guides | ۴ (seed) |
| سایر جداول | ۰ |

### Migrationها (۱۳ فایل)

مسیر: `supabase/migrations/`

آخرین migration: `20261024174349_20261024060000_step12_food_bank_substitutions_progress_guides.sql.sql` — ایجاد ۱۷ جدول جدید با RLS و seed راهنماها و حرکات اصلاحی.

---

## D. وضعیت Build و Git

- **Build:** ✅ موفق (۵۴۵KB JS, ۴۲KB CSS)
- **TypeScript:** بدون خطا
- **Git repo:** ✅ محلی init شده، commit اول انجام شده
- **GitHub push:** ❌ ناموفق — نیاز به credential (username/password یا token)
- **.env:** ✅ gitignore شده، در commit نیست
- **dist/:** ✅ gitignore شده

---

## E. کارهای باقی‌مانده (اولویت‌بندی)

1. **اتصال WeeklyDietModal به App.tsx** — کامپوننت ساخته شده ولی به برنامه شاگرد متصل نیست
2. **غذاهای پرتکرار شاگرد** — UI در StudentDetail اضافه شود
3. **ابزار حرکات اصلاحی** — CorrectiveExerciseTool component در پنل
4. **صفحه عمومی لینک گزارش** — `#/report/:token` با فرم امن
5. **ویرایش PrintLayout** — سبز/طلایی به جای navy/orange، ساختار دفترچه جدید
6. **خروجی Word** — بازنویسی
7. **آپلود عکس** — نیازمند Supabase Storage
8. **Push به GitHub** — نیاز به credential

---

## F. محدودیت‌های اعلام‌شده

1. **بکاپ داده‌ها:** ابزار `pg_dump` در محیط Bolt موجود نیست. داده‌ها در Supabase ذخیره هستند و از طریق Supabase Dashboard قابل backup هستند. تعداد رکوردها تأیید شده (۵۵۰ حرکت، ۶ قالب، ۸ نکت، ۴ راهنما، ۷ حرکت اصلاحی).
2. **Push به GitHub:** نیاز به GitHub credential دارد که در این محیط موجود نیست. commit محلی انجام شده.
3. **آپلود عکس:** Supabase Storage فعلاً پیکربندی نشده. عکس‌های پیشرفت قابل ذخیره نیستند.
4. **صفحه عمومی گزارش:** لینک ایجاد و کپی می‌شود اما صفحه `#/report/:token` هنوز ساخته نشده.
