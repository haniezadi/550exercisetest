/*
# مرحلهٔ اول: قفل جداول فعلی + جدول درخواست‌های فرم عمومی

## هدف
پنل مربی خصوصی شود و فرم عمومی فقط بتواند درخواست جدید بسازد.

## ۱. جداول جدید
- `intake_requests`: درخواست‌های فرم عمومی شاگردان.
  - id, status, form_data (jsonb), coach_note, created_at, updated_at, converted_student_id.

## ۲. تغییرات جداول فعلی
- `students`: ستون جدید `source_request_id` برای اتصال پرونده به درخواست مبدا.

## ۳. امنیت (RLS)
- `students`, `templates`, `assigned_programs`: سیاست‌های anon حذف؛ فقط authenticated.
- `intake_requests`: INSERT برای anon+authenticated؛ SELECT/UPDATE/DELETE فقط authenticated.
*/

-- ۳.۱ ستون source_request_id به students
ALTER TABLE students
  ADD COLUMN IF NOT EXISTS source_request_id uuid;

-- ۳.۲ جدول درخواست‌ها
CREATE TABLE IF NOT EXISTS intake_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  status text NOT NULL DEFAULT 'new'
    CHECK (status IN ('new','reviewing','needs_info','approved','rejected','converted')),
  form_data jsonb NOT NULL DEFAULT '{}'::jsonb,
  coach_note text NOT NULL DEFAULT '',
  converted_student_id uuid,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE intake_requests ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'intake_requests_converted_student_id_fkey'
  ) THEN
    ALTER TABLE intake_requests
      ADD CONSTRAINT intake_requests_converted_student_id_fkey
      FOREIGN KEY (converted_student_id) REFERENCES students(id) ON DELETE SET NULL;
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_intake_requests_status ON intake_requests(status);
CREATE INDEX IF NOT EXISTS idx_intake_requests_created ON intake_requests(created_at DESC);

-- ۳.۳ سیاست‌های intake_requests
DROP POLICY IF EXISTS "anon_insert_intake_requests" ON intake_requests;
CREATE POLICY "anon_insert_intake_requests" ON intake_requests FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "auth_select_intake_requests" ON intake_requests;
CREATE POLICY "auth_select_intake_requests" ON intake_requests FOR SELECT
  TO authenticated USING (true);

DROP POLICY IF EXISTS "auth_update_intake_requests" ON intake_requests;
CREATE POLICY "auth_update_intake_requests" ON intake_requests FOR UPDATE
  TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "auth_delete_intake_requests" ON intake_requests;
CREATE POLICY "auth_delete_intake_requests" ON intake_requests FOR DELETE
  TO authenticated USING (true);

-- ۳.۴ قفل جداول فعلی: حذف سیاست‌های anon
-- students
DROP POLICY IF EXISTS "anon_select_students" ON students;
DROP POLICY IF EXISTS "anon_insert_students" ON students;
DROP POLICY IF EXISTS "anon_update_students" ON students;
DROP POLICY IF EXISTS "anon_delete_students" ON students;

DROP POLICY IF EXISTS "auth_select_students" ON students;
CREATE POLICY "auth_select_students" ON students FOR SELECT
  TO authenticated USING (true);

DROP POLICY IF EXISTS "auth_insert_students" ON students;
CREATE POLICY "auth_insert_students" ON students FOR INSERT
  TO authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "auth_update_students" ON students;
CREATE POLICY "auth_update_students" ON students FOR UPDATE
  TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "auth_delete_students" ON students;
CREATE POLICY "auth_delete_students" ON students FOR DELETE
  TO authenticated USING (true);

-- templates
DROP POLICY IF EXISTS "anon_select_templates" ON templates;
DROP POLICY IF EXISTS "anon_insert_templates" ON templates;
DROP POLICY IF EXISTS "anon_update_templates" ON templates;
DROP POLICY IF EXISTS "anon_delete_templates" ON templates;

DROP POLICY IF EXISTS "auth_select_templates" ON templates;
CREATE POLICY "auth_select_templates" ON templates FOR SELECT
  TO authenticated USING (true);

DROP POLICY IF EXISTS "auth_insert_templates" ON templates;
CREATE POLICY "auth_insert_templates" ON templates FOR INSERT
  TO authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "auth_update_templates" ON templates;
CREATE POLICY "auth_update_templates" ON templates FOR UPDATE
  TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "auth_delete_templates" ON templates;
CREATE POLICY "auth_delete_templates" ON templates FOR DELETE
  TO authenticated USING (true);

-- assigned_programs
DROP POLICY IF EXISTS "anon_select_assigned_programs" ON assigned_programs;
DROP POLICY IF EXISTS "anon_insert_assigned_programs" ON assigned_programs;
DROP POLICY IF EXISTS "anon_update_assigned_programs" ON assigned_programs;
DROP POLICY IF EXISTS "anon_delete_assigned_programs" ON assigned_programs;

DROP POLICY IF EXISTS "auth_select_assigned_programs" ON assigned_programs;
CREATE POLICY "auth_select_assigned_programs" ON assigned_programs FOR SELECT
  TO authenticated USING (true);

DROP POLICY IF EXISTS "auth_insert_assigned_programs" ON assigned_programs;
CREATE POLICY "auth_insert_programs" ON assigned_programs FOR INSERT
  TO authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "auth_update_assigned_programs" ON assigned_programs;
CREATE POLICY "auth_update_assigned_programs" ON assigned_programs FOR UPDATE
  TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "auth_delete_assigned_programs" ON assigned_programs;
CREATE POLICY "auth_delete_assigned_programs" ON assigned_programs FOR DELETE
  TO authenticated USING (true);
