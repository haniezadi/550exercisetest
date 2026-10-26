/*
# Create test student "نگار احمدی" with full program data

## Summary
Creates a test student with complete program data (workout, diet, measurements, reminders) for PDF design verification.
Exercise and diet tip UUIDs have been remapped to match actual database IDs.

## Data Created
1. Test student: نگار احمدی - تست طراحی PDF (ID: 11111111-...)
2. Assigned program with workout_status and diet_status completed
3. Student plan (5-week workout+diet)
4. 16 program exercises across 3 workout days (بالاتنه، پایین‌تنه، فول‌بادی)
5. 5 diet meals with food items
6. 7 diet tips (5 in full mode, 2 in tips_only mode)
7. Initial measurement
8. Renewal reminder

## Notes
- This is TEST DATA ONLY, clearly identifiable by name, for PDF design verification.
- Uses fixed UUIDs for idempotency.
- Can be safely deleted after testing.
*/

-- ── 1. Insert student ──
INSERT INTO students (id, name, age, height_cm, weight_kg, goal, phone, birth_date, coach_notes)
VALUES (
  '11111111-1111-1111-1111-111111111111',
  'نگار احمدی - تست طراحی PDF',
  32,
  167,
  92,
  'کاهش چربی، حفظ عضله، افزایش آمادگی جسمانی و اصلاح عادت‌های سبک زندگی',
  '09120000000',
  '1994-05-15',
  'شاگرد آزمایشی برای بررسی طراحی PDF. سطح مبتدی تا متوسط، ۳ روز در هفته، حدود ۶۰ دقیقه هر جلسه. شغل: کارمند با فعالیت کم. خواب: ۶-۷ ساعت.'
)
ON CONFLICT (id) DO NOTHING;

-- ── 2. Insert assigned program ──
INSERT INTO assigned_programs (
  id, student_id, custom_name, custom_description,
  workout_status, diet_status,
  diet_target_calories, diet_target_protein_g, diet_pattern
) VALUES (
  '22222222-2222-2222-2222-222222222222',
  '11111111-1111-1111-1111-111111111111',
  'برنامه کاهش وزن و تناسب اندام - دوره اول',
  'این برنامه برای کاهش تدریجی وزن و افزایش آمادگی جسمانی طراحی شده است. هدف کاهش ۰.۵ تا ۱ کیلوگرم در هفته است. لطفاً قبل از شروع تمرین، ۵ دقیقه گرم کردن انجام دهید و پس از تمرین حرکات کششی را اجرا کنید.',
  'completed',
  'completed',
  1800,
  130,
  'معمولی و انعطاف‌پذیر'
)
ON CONFLICT (id) DO NOTHING;

-- ── 3. Insert student plan ──
INSERT INTO student_plans (
  id, student_id, plan_type, start_date, end_date,
  amount, payment_status, plan_status, notes
) VALUES (
  '33333333-3333-3333-3333-333333333333',
  '11111111-1111-1111-1111-111111111111',
  'workout_diet',
  '2026-10-23',
  '2026-11-27',
  1500000,
  'paid',
  'active',
  'پلن آزمایشی - ۵ هفته'
)
ON CONFLICT (id) DO NOTHING;

-- ── 4. Insert program exercises (workout) ──
-- Day 1: بالاتنه (شنبه و سه‌شنبه)
INSERT INTO program_exercises (program_id, exercise_id, sort_order, sets, reps, rest_seconds, rpe, day_label, coach_notes, exercise_name_fa, exercise_name_en, exercise_video_url) VALUES
('22222222-2222-2222-2222-222222222222', '200a8260-b8f2-4891-a870-e4b49447f3b4', 1, 4, '۸ تا ۱۲', 90, 7, 'روز ۱ - بالاتنه', 'کنترل کامل روی نزولی حرکت', 'پرس سینه با هالتر', 'Barbell Bench Press', ''),
('22222222-2222-2222-2222-222222222222', 'af5b0302-3e13-48bb-bd7a-e665e63d96d0', 2, 3, '۱۰ تا ۱۲', 60, 6, 'روز ۱ - بالاتنه', 'وزن سبک شروع کنید', 'پرس بالای سر با دمبل', 'Dumbbell Overhead Press', ''),
('22222222-2222-2222-2222-222222222222', '2d2f6b62-9be4-46b8-8387-11b31f689ccf', 3, 4, '۸ تا ۱۰', 75, 7, 'روز ۱ - بالاتنه', 'بازوهای صاف، آرنج نزدیک بدن', 'لت پول‌داون', 'Lat Pulldown', ''),
('22222222-2222-2222-2222-222222222222', '5a7388f1-a2d4-4849-9f16-44240eac4915', 4, 3, '۱۰ تا ۱۲', 60, 6, 'روز ۱ - بالاتنه', 'بدن روی نیمکت ثابت باشد', 'پرس زیربغل با دمبل', 'Dumbbell Row', ''),
('22222222-2222-2222-2222-222222222222', '29c9fa5a-9700-4678-b020-125515556cf3', 5, 3, '۸ تا ۱۲', 45, 5, 'روز ۱ - بالاتنه', 'اگر شنا سوئدی سخت بود، روی زانو انجام دهید', 'شنا سوئدی', 'Push-up', ''),
('22222222-2222-2222-2222-222222222222', '8c6dc69c-0236-4b21-8eae-16beeadc2a61', 6, 3, '۳۰ ثانیه', 30, 5, 'روز ۱ - بالاتنه', 'بدن کاملاً صاف، شکم جمع', 'پلانک', 'Plank', '')
ON CONFLICT DO NOTHING;

-- Day 2: پایین‌تنه (یکشنبه و چهارشنبه)
INSERT INTO program_exercises (program_id, exercise_id, sort_order, sets, reps, rest_seconds, rpe, day_label, coach_notes, exercise_name_fa, exercise_name_en, exercise_video_url) VALUES
('22222222-2222-2222-2222-222222222222', 'd9af6ba2-3082-4b14-83b3-0098a3484d62', 1, 4, '۸ تا ۱۲', 120, 7, 'روز ۲ - پایین‌تنه', 'زانوها از نوک پا جلوتر نرود', 'اسکات با هالتر', 'Barbell Squat', 'https://drive.google.com/file/d/1-QoIf02stFDTcVydMoSptVusXwc0G264/view?usp=sharing'),
('22222222-2222-2222-2222-222222222222', '02c58393-c8bb-4344-b254-65fd70afe214', 2, 3, '۱۰ تا ۱۲ هر پا', 60, 6, 'روز ۲ - پایین‌تنه', 'قدم‌ها به اندازه عرض شانه', 'لوینگز', 'Lunges', ''),
('22222222-2222-2222-2222-222222222222', '30d0d446-7033-44bc-b910-552b516ac34f', 3, 3, '۱۲ تا ۱۵', 45, 5, 'روز ۲ - پایین‌تنه', 'باسن را بالا ببرید و ۲ ثانیه مکث کنید', 'هیپ بریج', 'Hip Bridge', ''),
('22222222-2222-2222-2222-222222222222', 'e4d4dc3a-f614-4ead-8b44-b3679734ad02', 4, 2, '۳۰ ثانیه', 30, 3, 'روز ۲ - پایین‌تنه', 'کشش ملایم، بدون درد', 'کشش همسترینگ', 'Hamstring Stretch', ''),
('22222222-2222-2222-2222-222222222222', 'dac014f1-bc95-426e-8e72-a15734211ae8', 5, 2, '۱۰ تکرار', 30, 3, 'روز ۲ - پایین‌تنه', 'حرکت آرام و کنترل‌شده', 'گربه شتر', 'Cat-Camel', '')
ON CONFLICT DO NOTHING;

-- Day 3: فول‌بادی (سه‌شنبه)
INSERT INTO program_exercises (program_id, exercise_id, sort_order, sets, reps, rest_seconds, rpe, day_label, coach_notes, exercise_name_fa, exercise_name_en, exercise_video_url) VALUES
('22222222-2222-2222-2222-222222222222', 'aea4d1ab-05fc-41e4-b94c-3fc44383e45c', 1, 3, '۱۲ تا ۱۵', 45, 5, 'روز ۳ - فول‌بادی', 'اسکات با وزن بدن، تمرکز روی فرم', 'سیتی‌اسکات', 'Bodyweight Squat', ''),
('22222222-2222-2222-2222-222222222222', '200a8260-b8f2-4891-a870-e4b49447f3b4', 2, 3, '۱۰ تا ۱۲', 90, 6, 'روز ۳ - فول‌بادی', 'تکرار حرکت پرس سینه با وزنه سبک‌تر - تست لینک تکراری', 'پرس سینه با هالتر', 'Barbell Bench Press', ''),
('22222222-2222-2222-2222-222222222222', '2d2f6b62-9be4-46b8-8387-11b31f689ccf', 3, 3, '۱۰ تا ۱۲', 60, 6, 'روز ۳ - فول‌بادی', '', 'لت پول‌داون', 'Lat Pulldown', ''),
('22222222-2222-2222-2222-222222222222', '7bc1f484-ae1f-40ba-a415-85b981c93ce5', 4, 2, '۸ تکرار هر طرف', 30, 4, 'روز ۳ - فول‌بادی', 'حرکت اصلاحی - برای تقویت هسته بدن', 'دد‌باگ', 'Dead Bug', ''),
('22222222-2222-2222-2222-222222222222', '8c6dc69c-0236-4b21-8eae-16beeadc2a61', 5, 2, '۴۵ ثانیه', 30, 5, 'روز ۳ - فول‌بادی', '', 'پلانک', 'Plank', '')
ON CONFLICT DO NOTHING;

-- ── 5. Insert diet program meals ──
INSERT INTO diet_program_meals (id, program_id, sort_order, name, notes, fasting_start, fasting_end) VALUES
('aaaaaaaa-0001-0000-0000-000000000001', '22222222-2222-2222-2222-222222222222', 1, 'صبحانه', 'بلافاصله پس از بیدار شدن، یک لیوان آب بنوشید.', '', ''),
('aaaaaaaa-0002-0000-0000-000000000001', '22222222-2222-2222-2222-222222222222', 2, 'میان‌وعده صبح', 'می‌توانید با چای سبز همراه کنید.', '', ''),
('aaaaaaaa-0003-0000-0000-000000000001', '22222222-2222-2222-2222-222222222222', 3, 'ناهار', 'سالاد فصل حتماً همراه ناهار مصرف شود.', '', ''),
('aaaaaaaa-0004-0000-0000-000000000001', '22222222-2222-2222-2222-222222222222', 4, 'میان‌وعده عصر (قبل تمرین)', 'یک ساعت قبل از تمرین مصرف کنید.', '', ''),
('aaaaaaaa-0005-0000-0000-000000000001', '22222222-2222-2222-2222-222222222222', 5, 'شام', 'حداقل ۲ ساعت قبل از خواب صرف کنید.', '', '')
ON CONFLICT (id) DO NOTHING;

-- ── 6. Insert diet program food items ──
-- Meal 1: صبحانه
INSERT INTO diet_program_food_items (meal_id, sort_order, name, amount, unit, is_raw, alternatives, notes) VALUES
('aaaaaaaa-0001-0000-0000-000000000001', 1, 'تخم‌مرغ آب‌پز', '۲', 'عدد', false, 'پنیر کم‌چرب + گردو', 'کامل باشد'),
('aaaaaaaa-0001-0000-0000-000000000001', 2, 'نان سنگک', '۱', 'کف دست', false, 'نان جو', ''),
('aaaaaaaa-0001-0000-0000-000000000001', 3, 'پنیر فتا کم‌چرب', '۳۰', 'گرم', false, 'پنیر لیقوان', 'یک قاچ کوچک'),
('aaaaaaaa-0001-0000-0000-000000000001', 4, 'گردو', '۲', 'عدد', true, 'بادام (۸ عدد)', ''),
('aaaaaaaa-0001-0000-0000-000000000001', 5, 'چای سبز', '۱', 'لیوان', false, '', 'بدون شکر')
ON CONFLICT DO NOTHING;

-- Meal 2: میان‌وعده صبح
INSERT INTO diet_program_food_items (meal_id, sort_order, name, amount, unit, is_raw, alternatives, notes) VALUES
('aaaaaaaa-0002-0000-0000-000000000001', 1, 'سیب', '۱', 'عدد', true, 'کیوی یا گلابی', ''),
('aaaaaaaa-0002-0000-0000-000000000001', 2, 'ماست یونانی', '۱۰۰', 'گرم', false, 'ماست کم‌چرب', 'یک پیاله کوچک')
ON CONFLICT DO NOTHING;

-- Meal 3: ناهار
INSERT INTO diet_program_food_items (meal_id, sort_order, name, amount, unit, is_raw, alternatives, notes) VALUES
('aaaaaaaa-0003-0000-0000-000000000001', 1, 'برنج', '۱', 'پیمانه', true, 'پاستا (نصف پیمانه)', 'برنج قهوه‌ای اولویت دارد'),
('aaaaaaaa-0003-0000-0000-000000000001', 2, 'سینه مرغ گریل', '۱۵۰', 'گرم', false, 'ماهی کبابی یا گوشت کم‌چرب', 'بخارپز یا گریل، بدون پوست'),
('aaaaaaaa-0003-0000-0000-000000000001', 3, 'سالاد فصل', '۱', 'بشقاب', false, 'سالاد شیرازی', 'با چاشنی آبلیمو و روغن زیتون'),
('aaaaaaaa-0003-0000-0000-000000000001', 4, 'روغن زیتون', '۱', 'قاشق غذاخوری', false, 'روغن کنجد', '')
ON CONFLICT DO NOTHING;

-- Meal 4: میان‌وعده عصر (قبل تمرین)
INSERT INTO diet_program_food_items (meal_id, sort_order, name, amount, unit, is_raw, alternatives, notes) VALUES
('aaaaaaaa-0004-0000-0000-000000000001', 1, 'موز', '۱', 'عدد', true, 'خرما (۳ عدد)', 'مناسب برای انرژی قبل تمرین'),
('aaaaaaaa-0004-0000-0000-000000000001', 2, 'کره بادام‌زمینی', '۱', 'قاشق چای‌خوری', false, 'کره بادام', 'طبیعی و بدون شکر افزوده'),
('aaaaaaaa-0004-0000-0000-000000000001', 3, 'چای کم‌رنگ', '۱', 'لیوان', false, '', 'بدون شکر یا با ۱ عدد قند')
ON CONFLICT DO NOTHING;

-- Meal 5: شام
INSERT INTO diet_program_food_items (meal_id, sort_order, name, amount, unit, is_raw, alternatives, notes) VALUES
('aaaaaaaa-0005-0000-0000-000000000001', 1, 'خوراک لوبیا چیتی', '۱', 'پیاله متوسط', true, 'عدسی یا خوراک نخود', 'پخته با روغن کم'),
('aaaaaaaa-0005-0000-0000-000000000001', 2, 'نان سنگک', '۱', 'کف دست', false, 'نان جو', ''),
('aaaaaaaa-0005-0000-0000-000000000001', 3, 'سبزیجات بخارپز', '۲', 'پیمانه', false, 'سالاد سبزیجات', 'کلم، هویج، کدو'),
('aaaaaaaa-0005-0000-0000-000000000001', 4, 'ماست کم‌چرب', '۱۰۰', 'گرم', false, 'دوغ کم‌چرب', '')
ON CONFLICT DO NOTHING;

-- ── 7. Insert diet program tips ──
INSERT INTO diet_program_tips (program_id, tip_id, custom_text, sort_order, pdf_mode) VALUES
('22222222-2222-2222-2222-222222222222', '4dc978cd-ce86-4ed8-b1f5-c572a5644e29', 'روزانه حداقل ۸ لیوان آب بنوشید. بین وعده‌های غذایی آب بنوشید، نه با غذا. آب ولرم اولویت دارد.', 1, 'full'),
('22222222-2222-2222-2222-222222222222', '12f78fea-83be-46c2-ab38-ef6559381c57', 'هفته‌ای یک وعده می‌توانید آزادانه‌تر غذا بخورید، اما به یک وعده محدود شود. پیشنهاد: جمعه‌ها وعده آزاد را جایگزین ناهار کنید.', 2, 'full'),
('22222222-2222-2222-2222-222222222222', 'ef9d760c-1a4d-4a38-b180-3be10ebbdae3', 'در رستوران از غذاهای گریل یا بخارپز استفاده کنید. از سرخ‌کرده و سس‌های کرم‌دار خودداری کنید. نان را کاهش دهید.', 3, 'full'),
('22222222-2222-2222-2222-222222222222', '49c419eb-a7f5-4a6d-a489-00907f98303e', 'وزن را هفته‌ای یک‌بار، صبح ناشتا و با لباس یکسان اندازه بگیرید. نوسان روزانه طبیعی است.', 4, 'full'),
('22222222-2222-2222-2222-222222222222', 'd0c2368e-035c-4ae7-9d6e-1455346476e2', 'اگر یک روز از برنامه خارج شدید نگران نباشید. روز بعد همان برنامه اصلی را اجرا کنید. گرسنگی دادن یا تمرین اضافی توصیه نمی‌شود.', 5, 'full'),
('22222222-2222-2222-2222-222222222222', 'ce8d6cb2-2776-43c0-bd80-bcfd2c218dae', 'در روزهای بیماری تمرین را متوقف کنید. از غذاهای سبک و مغذی استفاده کنید و پس از بهبودی تدریجاً به برنامه برگردید.', 6, 'tips_only'),
('22222222-2222-2222-2222-222222222222', '489cf00f-3e73-4d69-886d-ce3c9b8b127c', 'در سفر از آجیل بدون نمک، میوه تازه یا پروتئین بار استفاده کنید. از فست‌فود و میان‌وعده‌های بسته‌بندی خودداری کنید.', 7, 'tips_only')
ON CONFLICT DO NOTHING;

-- ── 8. Insert initial measurement ──
INSERT INTO measurements (student_id, recorded_at, weight_kg, waist_cm, hip_cm, chest_cm, thigh_cm, arm_cm, notes)
VALUES (
  '11111111-1111-1111-1111-111111111111',
  '2026-10-23',
  92,
  98,
  112,
  104,
  62,
  32,
  'اندازه‌گیری اولیه - شروع برنامه'
)
ON CONFLICT DO NOTHING;

-- ── 9. Insert renewal reminder ──
INSERT INTO reminders (student_id, plan_id, type, due_date, status, title, detail)
VALUES (
  '11111111-1111-1111-1111-111111111111',
  '33333333-3333-3333-3333-333333333333',
  'renewal',
  '2026-11-20',
  'pending',
  'بازدید و تمدید پلن',
  'پلن ۵ هفته‌ای نگار احمدی در تاریخ ۲۷ آبان پایان می‌یابد. برای تمدید یا اصلاح برنامه اقدام کنید.'
)
ON CONFLICT DO NOTHING;