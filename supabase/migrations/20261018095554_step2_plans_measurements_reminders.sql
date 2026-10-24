/*
# مرحله دوم: مدیریت پلن شاگردها، اندازه‌گیری‌ها و یادآورها

## جداول جدید
1. `student_plans` — پلن‌های شاگرد (تاریخ شروع/پایان، مبلغ، نوع، وضعیت پرداخت، وضعیت پلن)
2. `measurements` — اندازه‌گیری‌های دوره‌ای شاگرد (وزن، دور کمر/باسن/سینه/ران و...)
3. `reminders` — یادآورهای خودکار (اندازه‌گیری ۱۴ روزه، تمدید پلن ۳ روز قبل)

## تغییرات جداول فعلی
- بدون تغییر در جداول موجود (students، templates، assigned_programs، intake_requests)

## امنیت (RLS)
- هر سه جدول جدید: فقط authenticated (مربی) دسترسی کامل دارد.
- یادآورها در دیتابیس ذخیره می‌شوند و با رفرش باقی می‌مانند.
*/

-- ۱. جدول پلن‌ها
CREATE TABLE IF NOT EXISTS student_plans (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  plan_type text NOT NULL DEFAULT 'workout_diet'
    CHECK (plan_type IN ('workout_only','diet_only','workout_diet','vip','custom')),
  custom_type_label text NOT NULL DEFAULT '',
  start_date date NOT NULL,
  end_date date NOT NULL,
  amount numeric NOT NULL DEFAULT 0,
  payment_status text NOT NULL DEFAULT 'unpaid'
    CHECK (payment_status IN ('paid','unpaid','partial')),
  plan_status text NOT NULL DEFAULT 'active'
    CHECK (plan_status IN ('active','expiring','expired','renewed')),
  notes text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE student_plans ENABLE ROW LEVEL SECURITY;

CREATE INDEX IF NOT EXISTS idx_student_plans_student ON student_plans(student_id);
CREATE INDEX IF NOT EXISTS idx_student_plans_end_date ON student_plans(end_date);
CREATE INDEX IF NOT EXISTS idx_student_plans_status ON student_plans(plan_status);

DROP POLICY IF EXISTS "auth_select_student_plans" ON student_plans;
CREATE POLICY "auth_select_student_plans" ON student_plans FOR SELECT
  TO authenticated USING (true);

DROP POLICY IF EXISTS "auth_insert_student_plans" ON student_plans;
CREATE POLICY "auth_insert_student_plans" ON student_plans FOR INSERT
  TO authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "auth_update_student_plans" ON student_plans;
CREATE POLICY "auth_update_student_plans" ON student_plans FOR UPDATE
  TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "auth_delete_student_plans" ON student_plans;
CREATE POLICY "auth_delete_student_plans" ON student_plans FOR DELETE
  TO authenticated USING (true);

-- ۲. جدول اندازه‌گیری‌ها
CREATE TABLE IF NOT EXISTS measurements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  recorded_at date NOT NULL DEFAULT CURRENT_DATE,
  weight_kg numeric,
  waist_cm numeric,
  hip_cm numeric,
  chest_cm numeric,
  thigh_cm numeric,
  arm_cm numeric,
  extra jsonb NOT NULL DEFAULT '{}'::jsonb,
  notes text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE measurements ENABLE ROW LEVEL SECURITY;

CREATE INDEX IF NOT EXISTS idx_measurements_student ON measurements(student_id);
CREATE INDEX IF NOT EXISTS idx_measurements_recorded ON measurements(recorded_at DESC);

DROP POLICY IF EXISTS "auth_select_measurements" ON measurements;
CREATE POLICY "auth_select_measurements" ON measurements FOR SELECT
  TO authenticated USING (true);

DROP POLICY IF EXISTS "auth_insert_measurements" ON measurements;
CREATE POLICY "auth_insert_measurements" ON measurements FOR INSERT
  TO authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "auth_update_measurements" ON measurements;
CREATE POLICY "auth_update_measurements" ON measurements FOR UPDATE
  TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "auth_delete_measurements" ON measurements;
CREATE POLICY "auth_delete_measurements" ON measurements FOR DELETE
  TO authenticated USING (true);

-- ۳. جدول یادآورها
CREATE TABLE IF NOT EXISTS reminders (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  plan_id uuid REFERENCES student_plans(id) ON DELETE CASCADE,
  type text NOT NULL CHECK (type IN ('measurement','renewal')),
  due_date date NOT NULL,
  status text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','done','dismissed')),
  title text NOT NULL DEFAULT '',
  detail text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE reminders ENABLE ROW LEVEL SECURITY;

CREATE INDEX IF NOT EXISTS idx_reminders_student ON reminders(student_id);
CREATE INDEX IF NOT EXISTS idx_reminders_due_date ON reminders(due_date);
CREATE INDEX IF NOT EXISTS idx_reminders_status ON reminders(status);
CREATE INDEX IF NOT EXISTS idx_reminders_type ON reminders(type);

DROP POLICY IF EXISTS "auth_select_reminders" ON reminders;
CREATE POLICY "auth_select_reminders" ON reminders FOR SELECT
  TO authenticated USING (true);

DROP POLICY IF EXISTS "auth_insert_reminders" ON reminders;
CREATE POLICY "auth_insert_reminders" ON reminders FOR INSERT
  TO authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "auth_update_reminders" ON reminders;
CREATE POLICY "auth_update_reminders" ON reminders FOR UPDATE
  TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "auth_delete_reminders" ON reminders;
CREATE POLICY "auth_delete_reminders" ON reminders FOR DELETE
  TO authenticated USING (true);
