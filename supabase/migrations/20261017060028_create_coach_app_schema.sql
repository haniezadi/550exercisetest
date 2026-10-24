/*
# پنل مربی تن‌اندام - ساختار دیتابیس اولیه

1. جداول جدید
- `students` (شاگردها): نام، سن، قد (cm)، وزن (kg)، هدف، تاریخ ایجاد.
- `templates` (قالب‌های آماده): نوع (workout/diet)، نام، توضیح، تاریخ ایجاد.
- `assigned_programs` (برنامه‌های اختصاص‌یافته): یکی به هر شاگرد،
  شامل قالب تمرینی، قالب غذایی، نام سفارشی و توضیح سفارشی قابل ویرایش.

2. روابط
- assigned_programs.student_id → students.id (CASCADE)
- assigned_programs.workout_template_id → templates.id (SET NULL)
- assigned_programs.diet_template_id → templates.id (SET NULL)
- محدودیت یکتایی: یک برنامه به ازای هر شاگرد.

3. امنیت (RLS)
- برنامه بدون ورود است (تک‌کاربره). RLS روی همهٔ جداول فعال و
  سیاست‌های anon+authenticated با USING(true) چون داده‌ها عمومی/مشترک هستند.
*/

CREATE TABLE IF NOT EXISTS students (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  age integer,
  height_cm numeric,
  weight_kg numeric,
  goal text,
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE students ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_select_students" ON students;
CREATE POLICY "anon_select_students" ON students FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_students" ON students;
CREATE POLICY "anon_insert_students" ON students FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_students" ON students;
CREATE POLICY "anon_update_students" ON students FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_students" ON students;
CREATE POLICY "anon_delete_students" ON students FOR DELETE
  TO anon, authenticated USING (true);

CREATE TABLE IF NOT EXISTS templates (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type text NOT NULL CHECK (type IN ('workout', 'diet')),
  name text NOT NULL,
  description text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE templates ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_select_templates" ON templates;
CREATE POLICY "anon_select_templates" ON templates FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_templates" ON templates;
CREATE POLICY "anon_insert_templates" ON templates FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_templates" ON templates;
CREATE POLICY "anon_update_templates" ON templates FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_templates" ON templates;
CREATE POLICY "anon_delete_templates" ON templates FOR DELETE
  TO anon, authenticated USING (true);

CREATE TABLE IF NOT EXISTS assigned_programs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL UNIQUE REFERENCES students(id) ON DELETE CASCADE,
  workout_template_id uuid REFERENCES templates(id) ON DELETE SET NULL,
  diet_template_id uuid REFERENCES templates(id) ON DELETE SET NULL,
  custom_name text NOT NULL DEFAULT '',
  custom_description text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE assigned_programs ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_select_assigned_programs" ON assigned_programs;
CREATE POLICY "anon_select_assigned_programs" ON assigned_programs FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "anon_insert_assigned_programs" ON assigned_programs;
CREATE POLICY "anon_insert_assigned_programs" ON assigned_programs FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_assigned_programs" ON assigned_programs;
CREATE POLICY "anon_update_assigned_programs" ON assigned_programs FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_assigned_programs" ON assigned_programs;
CREATE POLICY "anon_delete_assigned_programs" ON assigned_programs FOR DELETE
  TO anon, authenticated USING (true);

CREATE INDEX IF NOT EXISTS idx_assigned_programs_student
  ON assigned_programs(student_id);
