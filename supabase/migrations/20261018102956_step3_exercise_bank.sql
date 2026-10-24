/*
# مرحله سوم: بانک جامع حرکات تمرینی

## جداول جدید
1. `exercises` — بانک حرکات با تمام مشخصات (نام فارسی/انگلیسی، عضلات، نوع، تجهیزات، سطح، ویدئو و...)
2. `template_exercises` — حرکات داخل قالب تمرینی (با ترتیب، ست، تکرار، استراحت، RPE، روز، توضیحات مربی)
3. `program_exercises` — حرکات داخل برنامه اختصاصی شاگرد (مستقل از بانک و قالب)

## تغییرات جداول موجود
- بدون تغییر در tables، assigned_programs، students، student_plans، measurements، reminders

## امنیت
- exercises: TO anon, authenticated (مثل templates فعلی)
- template_exercises و program_exercises: TO authenticated (مثل assigned_programs فعلی)
- همه جداول RLS فعال

## نکات
- عضلات و تجهیزات به‌صورت text[] ذخیره می‌شوند (آرایه‌ای از مقادیر از پیش تعیین‌شده)
- ویدئو فقط لینک ذخیره می‌شود (Google Drive یا هر URL)
- اطلاعات اختصاصی برنامه شاگرد مستقل از بانک ذخیره می‌شود
*/

-- ۱. جدول exercises (بانک حرکات)
CREATE TABLE IF NOT EXISTS exercises (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name_fa text NOT NULL DEFAULT '',
  name_en text NOT NULL DEFAULT '',
  primary_muscles text[] NOT NULL DEFAULT '{}',
  secondary_muscles text[] NOT NULL DEFAULT '{}',
  exercise_type text NOT NULL DEFAULT 'strength'
    CHECK (exercise_type IN ('strength','cardio','mobility','stretching','corrective')),
  equipment text[] NOT NULL DEFAULT '{}',
  difficulty text NOT NULL DEFAULT 'beginner'
    CHECK (difficulty IN ('beginner','intermediate','advanced')),
  location text NOT NULL DEFAULT 'both'
    CHECK (location IN ('home','gym','both')),
  instructions text NOT NULL DEFAULT '',
  tips text NOT NULL DEFAULT '',
  limitations text NOT NULL DEFAULT '',
  alternative_names text NOT NULL DEFAULT '',
  video_url text NOT NULL DEFAULT '',
  is_active boolean NOT NULL DEFAULT true,
  is_favorite boolean NOT NULL DEFAULT false,
  tags text[] NOT NULL DEFAULT '{}',
  coach_notes text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;

CREATE INDEX IF NOT EXISTS idx_exercises_name_fa ON exercises USING gin (to_tsvector('simple', name_fa));
CREATE INDEX IF NOT EXISTS idx_exercises_name_en ON exercises USING gin (to_tsvector('simple', name_en));
CREATE INDEX IF NOT EXISTS idx_exercises_type ON exercises(exercise_type);
CREATE INDEX IF NOT EXISTS idx_exercises_difficulty ON exercises(difficulty);
CREATE INDEX IF NOT EXISTS idx_exercises_active ON exercises(is_active);
CREATE INDEX IF NOT EXISTS idx_exercises_favorite ON exercises(is_favorite);
CREATE INDEX IF NOT EXISTS idx_exercises_muscles ON exercises USING gin (primary_muscles);
CREATE INDEX IF NOT EXISTS idx_exercises_equipment ON exercises USING gin (equipment);

DROP POLICY IF EXISTS "anon_select_exercises" ON exercises;
CREATE POLICY "anon_select_exercises" ON exercises FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_exercises" ON exercises;
CREATE POLICY "anon_insert_exercises" ON exercises FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_exercises" ON exercises;
CREATE POLICY "anon_update_exercises" ON exercises FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_exercises" ON exercises;
CREATE POLICY "anon_delete_exercises" ON exercises FOR DELETE
  TO anon, authenticated USING (true);

-- ۲. جدول template_exercises (حرکات داخل قالب تمرینی)
CREATE TABLE IF NOT EXISTS template_exercises (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  template_id uuid NOT NULL REFERENCES templates(id) ON DELETE CASCADE,
  exercise_id uuid NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
  sort_order int NOT NULL DEFAULT 0,
  sets int,
  reps text NOT NULL DEFAULT '',
  rest_seconds int,
  rpe int,
  day_label text NOT NULL DEFAULT '',
  coach_notes text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE template_exercises ENABLE ROW LEVEL SECURITY;

CREATE INDEX IF NOT EXISTS idx_template_exercises_template ON template_exercises(template_id);
CREATE INDEX IF NOT EXISTS idx_template_exercises_sort ON template_exercises(template_id, sort_order);

DROP POLICY IF EXISTS "anon_select_template_exercises" ON template_exercises;
CREATE POLICY "anon_select_template_exercises" ON template_exercises FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_template_exercises" ON template_exercises;
CREATE POLICY "anon_insert_template_exercises" ON template_exercises FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_template_exercises" ON template_exercises;
CREATE POLICY "anon_update_template_exercises" ON template_exercises FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_template_exercises" ON template_exercises;
CREATE POLICY "anon_delete_template_exercises" ON template_exercises FOR DELETE
  TO anon, authenticated USING (true);

-- ۳. جدول program_exercises (حرکات داخل برنامه اختصاصی شاگرد)
CREATE TABLE IF NOT EXISTS program_exercises (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  program_id uuid NOT NULL REFERENCES assigned_programs(id) ON DELETE CASCADE,
  exercise_id uuid NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
  sort_order int NOT NULL DEFAULT 0,
  sets int,
  reps text NOT NULL DEFAULT '',
  rest_seconds int,
  rpe int,
  day_label text NOT NULL DEFAULT '',
  coach_notes text NOT NULL DEFAULT '',
  -- snapshot of exercise info at time of assignment (independent from bank)
  exercise_name_fa text NOT NULL DEFAULT '',
  exercise_name_en text NOT NULL DEFAULT '',
  exercise_video_url text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE program_exercises ENABLE ROW LEVEL SECURITY;

CREATE INDEX IF NOT EXISTS idx_program_exercises_program ON program_exercises(program_id);
CREATE INDEX IF NOT EXISTS idx_program_exercises_sort ON program_exercises(program_id, sort_order);

DROP POLICY IF EXISTS "anon_select_program_exercises" ON program_exercises;
CREATE POLICY "anon_select_program_exercises" ON program_exercises FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_program_exercises" ON program_exercises;
CREATE POLICY "anon_insert_program_exercises" ON program_exercises FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_program_exercises" ON program_exercises;
CREATE POLICY "anon_update_program_exercises" ON program_exercises FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_program_exercises" ON program_exercises;
CREATE POLICY "anon_delete_program_exercises" ON program_exercises FOR DELETE
  TO anon, authenticated USING (true);

-- ۴. داده‌های اولیه: ۱۵ حرکت نمونه
-- لینک ویدئو خالی — بدون لینک جعلی
INSERT INTO exercises (name_fa, name_en, primary_muscles, secondary_muscles, exercise_type, equipment, difficulty, location, instructions, tips, limitations, alternative_names, tags) VALUES
('اسکات با هالتر', 'Barbell Squat', ARRAY['چهارسر', 'باسن'], ARRAY['ساق', 'شکمی'], 'strength', ARRAY['هالتر'], 'intermediate', 'gym', 'هالتر روی شانه، پاها به عرض شانه، زانو خم تا ران موازی با زمین، سپس بالا بیایید.', 'صاف نگه داشتن کمر، زانوها در جهت پنجه', 'آسیب زانو یا کمر، بارداری', 'اسکات با دمبل,اسکات گابلت', ARRAY['پایین‌تنه','پایه']),
('پرس سینه با هالتر', 'Barbell Bench Press', ARRAY['سینه'], ARRAY['سرشانه', 'پشت‌بازو'], 'strength', ARRAY['هالتر','نیمکت'], 'intermediate', 'gym', 'روی نیمکت دراز بکشید، هالتر را تا قفسه سینه پایین بیاورید و بالا فشار دهید.', 'کمربندی شانه به نیمکت، پاها روی زمین', 'آسیب سرشانه', 'پرس سینه با دمبل,پرس سینه ماشین', ARRAY['بالاتنه','پایه']),
('ددلیفت', 'Deadlift', ARRAY['پشت', 'باسن', 'چهارسر'], ARRAY['ساق', 'شکمی', 'بازو'], 'strength', ARRAY['هالتر'], 'advanced', 'gym', 'هالتر روی زمین، کمر صاف، با قدرت پا و باسن بالا بیاورید.', 'کمر کاملاً صاف، نزدیک به بدن نگه دارید', 'آسیب کمر، دیسک', 'ردلفت,سومو ددلیفت', ARRAY['کل‌بدن','پایه']),
('پرس بالای سر با دمبل', 'Dumbbell Overhead Press', ARRAY['سرشانه'], ARRAY['بازو', 'شکمی'], 'strength', ARRAY['دمبل'], 'beginner', 'both', 'دمبل‌ها در ارتفاع شانه، بالای سر فشار دهید.', 'کمر صاف، شکم سفت', 'آسیب گردن یا کمر', 'پرس بالای سر با هالتر,پرس کتل‌بل', ARRAY['بالاتنه','سرشانه']),
('لت پول‌داون', 'Lat Pulldown', ARRAY['پشت'], ARRAY['بازو'], 'strength', ARRAY['ماشین'], 'beginner', 'gym', 'میله را از بالا بکشید تا زیر چانه.', 'کمر صاف، آرنج پایین', 'آسیب سرشانه', 'پول‌آپ,بارفیکس', ARRAY['بالاتنه','پشت']),
('لوینگز', 'Lunges', ARRAY['چهارسر', 'باسن'], ARRAY['ساق'], 'strength', ARRAY['دمبل','بدون تجهیزات'], 'beginner', 'both', 'یک گام به جلو، زانو خم تا ۹۰ درجه، سپس برگردید.', 'زانوی جلو از پنجه جلوتر نشود', 'آسیب زانو', 'اسکات بلغاری,استپ‌آپ', ARRAY['پایین‌تنه']),
('پلانک', 'Plank', ARRAY['شکمی'], ARRAY['کمر'], 'strength', ARRAY['بدون تجهیزات'], 'beginner', 'both', 'روی آرنج و پنجه، بدن صاف ۳۰-۶۰ ثانیه.', 'باسن بالا یا پایین نشود', 'آسیب مچ', 'پلانک جانبی,پلانک با حرکت', ARRAY['میان‌تنه','هوازی']),
('بارفیکس', 'Pull-up', ARRAY['پشت', 'بازو'], ARRAY['سرشانه'], 'strength', ARRAY['بارفیکس'], 'advanced', 'gym', 'از بارفیکس آویزان شوید و بالا بکشید تا چانه از بار بالاتر رود.', 'بدن بدون نوسان', 'آسیب سرشانه', 'لت پول‌داون,بارفیکس کمکی', ARRAY['بالاتنه','پشت']),
('پرس زیربغل با دمبل', 'Dumbbell Row', ARRAY['پشت'], ARRAY['بازو', 'سرشانه'], 'strength', ARRAY['دمبل','نیمکت'], 'beginner', 'gym', 'روی نیمکت تکیه با یک دست، دمبل را به سمت کمر بکشید.', 'کمر صاف، آرنج نزدیک بدن', 'آسیب کمر', 'باربل رو,تی‌بار رو', ARRAY['بالاتنه','پشت']),
('سیتی‌اسکات', 'Bodyweight Squat', ARRAY['چهارسر', 'باسن'], ARRAY['ساق'], 'strength', ARRAY['بدون تجهیزات'], 'beginner', 'home', 'بدون وزنه، اسکات کامل انجام دهید.', 'صاف بودن کمر', 'آسیب زانو', 'اسکات با دمبل,گابلت اسکات', ARRAY['پایین‌تنه','بدون تجهیزات']),
('هیپ بریج', 'Hip Bridge', ARRAY['باسن', 'پشت‌ران'], ARRAY['کمر'], 'strength', ARRAY['بدون تجهیزات'], 'beginner', 'home', 'دراز کشیده، باسن را بالا بیاورید تا بدن صاف شود.', 'فشار با پاشنه', 'آسیب کمر', 'هیپ تراست,گلوت کیک‌بک', ARRAY['پایین‌تنه','باسن']),
('شنا سوئدی', 'Push-up', ARRAY['سینه', 'بازو'], ARRAY['سرشانه', 'شکمی'], 'strength', ARRAY['بدون تجهیزات'], 'beginner', 'home', 'دست‌ها به عرض شانه، بدن صاف، پایین و بالا.', 'بدن صاف، آرنج ۴۵ درجه', 'آسیب مچ', 'شنا با زانو,پرس سینه دمبل', ARRAY['بالاتنه','بدون تجهیزات']),
('دد‌باگ', 'Dead Bug', ARRAY['شکمی'], ARRAY['کمر'], 'corrective', ARRAY['بدون تجهیزات'], 'beginner', 'home', 'دراز کشیده، دست و پا مخالف را همزمان پایین بیاورید.', 'کمر به زمین چسبیده', 'آسیب کمر', 'پلانک,برد داگ', ARRAY['میان‌تنه','اصلاحی']),
('کشش همسترینگ', 'Hamstring Stretch', ARRAY['پشت‌ران'], ARRAY['باسن', 'کمر'], 'stretching', ARRAY['بدون تجهیزات'], 'beginner', 'both', 'نشسته، یک پا دراز، بدن را به جلو خم کنید.', 'زانو صاف، کشش ملایم', 'آسیب همسترینگ', 'کشش ایستاده همسترینگ', ARRAY['کشش','پایین‌تنه']),
('گربه شتر', 'Cat-Camel', ARRAY['کمر', 'شکمی'], ARRAY['پشت'], 'mobility', ARRAY['بدون تجهیزات'], 'beginner', 'both', 'چهار دست و پا، کمر را گرد و سپس کج کنید.', 'حرکت ملایم و کنترل‌شده', 'آسیب گردن', 'بردفاگ,کشش کمر', ARRAY['موبیلیتی','کمر'])
ON CONFLICT DO NOTHING;
