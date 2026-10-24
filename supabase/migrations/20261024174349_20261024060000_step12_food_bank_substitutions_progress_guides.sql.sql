/*
# Food Bank, Substitutions, Progress Tracking, Cheat Meal, Corrective Exercises, Guides

## Summary
This migration adds new tables for the expanded coach panel features. No existing tables or data are modified or deleted.

## New Tables
1. foods — Independent food bank with calories, protein, household unit conversion
2. student_favorite_foods — Student's frequently consumed foods, categorized
3. food_substitution_groups — Groups like breads, fruits, protein sources
4. food_substitution_items — Items within each group with equivalent amounts
5. weekly_diet_programs — Weekly diet program per assigned_program
6. weekly_diet_meals — Meals for each day of week (Sat-Fri)
7. weekly_diet_food_items — Food items in each weekly meal (snapshotted)
8. meal_substitutions — Specific substitutions for a particular meal
9. meal_substitution_food_items — Food items for meal substitutions
10. cheat_meal_config — Per-program cheat meal configuration
11. report_links — Secure unique links for student report submission
12. progress_reports — Biweekly (14-day) progress reports
13. progress_evaluations — Monthly (4-week) evaluations with measurements
14. progress_photos — Progress photo references (stored in Supabase Storage)
15. corrective_issues — Catalog of structural issues
16. corrective_issue_exercises — Junction mapping issues to exercises
17. guides — Editable guide content for separate PDF guides

## Security
- All tables have RLS enabled.
- Grants to anon, authenticated with USING(true) (single-coach app pattern).
- report_links is accessible to anon (students submit reports via public link).

## Important Notes
- No existing tables are modified.
- No existing data is affected.
*/

-- ============================================================================
-- 1. FOODS (Food Bank)
-- ============================================================================
CREATE TABLE IF NOT EXISTS foods (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  category text NOT NULL DEFAULT 'other',
  calories_per_100g numeric,
  protein_per_100g numeric,
  carbs_per_100g numeric,
  fat_per_100g numeric,
  default_unit text DEFAULT 'گرم',
  household_unit text,
  household_unit_grams numeric,
  is_raw boolean DEFAULT true,
  notes text DEFAULT '',
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);
ALTER TABLE foods ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON foods TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_foods" ON foods;
CREATE POLICY "anon_select_foods" ON foods FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_foods" ON foods;
CREATE POLICY "anon_insert_foods" ON foods FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_foods" ON foods;
CREATE POLICY "anon_update_foods" ON foods FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_foods" ON foods;
CREATE POLICY "anon_delete_foods" ON foods FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 2. STUDENT_FAVORITE_FOODS
-- ============================================================================
CREATE TABLE IF NOT EXISTS student_favorite_foods (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  category text NOT NULL DEFAULT 'breakfast',
  food_name text NOT NULL,
  food_id uuid REFERENCES foods(id) ON DELETE SET NULL,
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE student_favorite_foods ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON student_favorite_foods TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_fav_foods" ON student_favorite_foods;
CREATE POLICY "anon_select_fav_foods" ON student_favorite_foods FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_fav_foods" ON student_favorite_foods;
CREATE POLICY "anon_insert_fav_foods" ON student_favorite_foods FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_fav_foods" ON student_favorite_foods;
CREATE POLICY "anon_update_fav_foods" ON student_favorite_foods FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_fav_foods" ON student_favorite_foods;
CREATE POLICY "anon_delete_fav_foods" ON student_favorite_foods FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 3. FOOD_SUBSTITUTION_GROUPS
-- ============================================================================
CREATE TABLE IF NOT EXISTS food_substitution_groups (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE food_substitution_groups ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON food_substitution_groups TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_sub_groups" ON food_substitution_groups;
CREATE POLICY "anon_select_sub_groups" ON food_substitution_groups FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_sub_groups" ON food_substitution_groups;
CREATE POLICY "anon_insert_sub_groups" ON food_substitution_groups FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_sub_groups" ON food_substitution_groups;
CREATE POLICY "anon_update_sub_groups" ON food_substitution_groups FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_sub_groups" ON food_substitution_groups;
CREATE POLICY "anon_delete_sub_groups" ON food_substitution_groups FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 4. FOOD_SUBSTITUTION_ITEMS
-- ============================================================================
CREATE TABLE IF NOT EXISTS food_substitution_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id uuid NOT NULL REFERENCES food_substitution_groups(id) ON DELETE CASCADE,
  food_name text NOT NULL,
  amount text NOT NULL DEFAULT '',
  unit text DEFAULT '',
  equivalent_note text DEFAULT '',
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE food_substitution_items ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON food_substitution_items TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_sub_items" ON food_substitution_items;
CREATE POLICY "anon_select_sub_items" ON food_substitution_items FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_sub_items" ON food_substitution_items;
CREATE POLICY "anon_insert_sub_items" ON food_substitution_items FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_sub_items" ON food_substitution_items;
CREATE POLICY "anon_update_sub_items" ON food_substitution_items FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_sub_items" ON food_substitution_items;
CREATE POLICY "anon_delete_sub_items" ON food_substitution_items FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 5. WEEKLY_DIET_PROGRAMS
-- ============================================================================
CREATE TABLE IF NOT EXISTS weekly_diet_programs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  program_id uuid NOT NULL REFERENCES assigned_programs(id) ON DELETE CASCADE,
  is_active boolean DEFAULT true,
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);
ALTER TABLE weekly_diet_programs ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON weekly_diet_programs TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_weekly_programs" ON weekly_diet_programs;
CREATE POLICY "anon_select_weekly_programs" ON weekly_diet_programs FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_weekly_programs" ON weekly_diet_programs;
CREATE POLICY "anon_insert_weekly_programs" ON weekly_diet_programs FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_weekly_programs" ON weekly_diet_programs;
CREATE POLICY "anon_update_weekly_programs" ON weekly_diet_programs FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_weekly_programs" ON weekly_diet_programs;
CREATE POLICY "anon_delete_weekly_programs" ON weekly_diet_programs FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 6. WEEKLY_DIET_MEALS
-- ============================================================================
CREATE TABLE IF NOT EXISTS weekly_diet_meals (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  weekly_program_id uuid NOT NULL REFERENCES weekly_diet_programs(id) ON DELETE CASCADE,
  day_of_week text NOT NULL DEFAULT 'شنبه',
  meal_type text NOT NULL DEFAULT 'breakfast',
  meal_name text DEFAULT '',
  sort_order integer DEFAULT 0,
  is_active boolean DEFAULT true,
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now()
);
ALTER TABLE weekly_diet_meals ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON weekly_diet_meals TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_weekly_meals" ON weekly_diet_meals;
CREATE POLICY "anon_select_weekly_meals" ON weekly_diet_meals FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_weekly_meals" ON weekly_diet_meals;
CREATE POLICY "anon_insert_weekly_meals" ON weekly_diet_meals FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_weekly_meals" ON weekly_diet_meals;
CREATE POLICY "anon_update_weekly_meals" ON weekly_diet_meals FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_weekly_meals" ON weekly_diet_meals;
CREATE POLICY "anon_delete_weekly_meals" ON weekly_diet_meals FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 7. WEEKLY_DIET_FOOD_ITEMS
-- ============================================================================
CREATE TABLE IF NOT EXISTS weekly_diet_food_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  weekly_meal_id uuid NOT NULL REFERENCES weekly_diet_meals(id) ON DELETE CASCADE,
  sort_order integer DEFAULT 0,
  food_id uuid REFERENCES foods(id) ON DELETE SET NULL,
  name text NOT NULL DEFAULT '',
  amount text NOT NULL DEFAULT '',
  unit text DEFAULT '',
  household_unit text DEFAULT '',
  household_grams numeric,
  is_raw boolean DEFAULT true,
  calories numeric,
  protein_g numeric,
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now()
);
ALTER TABLE weekly_diet_food_items ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON weekly_diet_food_items TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_weekly_food" ON weekly_diet_food_items;
CREATE POLICY "anon_select_weekly_food" ON weekly_diet_food_items FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_weekly_food" ON weekly_diet_food_items;
CREATE POLICY "anon_insert_weekly_food" ON weekly_diet_food_items FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_weekly_food" ON weekly_diet_food_items;
CREATE POLICY "anon_update_weekly_food" ON weekly_diet_food_items FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_weekly_food" ON weekly_diet_food_items;
CREATE POLICY "anon_delete_weekly_food" ON weekly_diet_food_items FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 8. MEAL_SUBSTITUTIONS
-- ============================================================================
CREATE TABLE IF NOT EXISTS meal_substitutions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  weekly_meal_id uuid NOT NULL REFERENCES weekly_diet_meals(id) ON DELETE CASCADE,
  substitution_name text NOT NULL DEFAULT '',
  sort_order integer DEFAULT 0,
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now()
);
ALTER TABLE meal_substitutions ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON meal_substitutions TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_meal_subs" ON meal_substitutions;
CREATE POLICY "anon_select_meal_subs" ON meal_substitutions FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_meal_subs" ON meal_substitutions;
CREATE POLICY "anon_insert_meal_subs" ON meal_substitutions FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_meal_subs" ON meal_substitutions;
CREATE POLICY "anon_update_meal_subs" ON meal_substitutions FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_meal_subs" ON meal_substitutions;
CREATE POLICY "anon_delete_meal_subs" ON meal_substitutions FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 9. MEAL_SUBSTITUTION_FOOD_ITEMS
-- ============================================================================
CREATE TABLE IF NOT EXISTS meal_substitution_food_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  substitution_id uuid NOT NULL REFERENCES meal_substitutions(id) ON DELETE CASCADE,
  sort_order integer DEFAULT 0,
  food_id uuid REFERENCES foods(id) ON DELETE SET NULL,
  name text NOT NULL DEFAULT '',
  amount text NOT NULL DEFAULT '',
  unit text DEFAULT '',
  household_unit text DEFAULT '',
  household_grams numeric,
  is_raw boolean DEFAULT true,
  calories numeric,
  protein_g numeric,
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now()
);
ALTER TABLE meal_substitution_food_items ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON meal_substitution_food_items TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_meal_sub_food" ON meal_substitution_food_items;
CREATE POLICY "anon_select_meal_sub_food" ON meal_substitution_food_items FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_meal_sub_food" ON meal_substitution_food_items;
CREATE POLICY "anon_insert_meal_sub_food" ON meal_substitution_food_items FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_meal_sub_food" ON meal_substitution_food_items;
CREATE POLICY "anon_update_meal_sub_food" ON meal_substitution_food_items FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_meal_sub_food" ON meal_substitution_food_items;
CREATE POLICY "anon_delete_meal_sub_food" ON meal_substitution_food_items FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 10. CHEAT_MEAL_CONFIG
-- ============================================================================
CREATE TABLE IF NOT EXISTS cheat_meal_config (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  program_id uuid NOT NULL REFERENCES assigned_programs(id) ON DELETE CASCADE,
  is_enabled boolean DEFAULT false,
  food_name text DEFAULT '',
  amount text DEFAULT '',
  placement text DEFAULT '',
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);
ALTER TABLE cheat_meal_config ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON cheat_meal_config TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_cheat_meal" ON cheat_meal_config;
CREATE POLICY "anon_select_cheat_meal" ON cheat_meal_config FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_cheat_meal" ON cheat_meal_config;
CREATE POLICY "anon_insert_cheat_meal" ON cheat_meal_config FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_cheat_meal" ON cheat_meal_config;
CREATE POLICY "anon_update_cheat_meal" ON cheat_meal_config FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_cheat_meal" ON cheat_meal_config;
CREATE POLICY "anon_delete_cheat_meal" ON cheat_meal_config FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 11. REPORT_LINKS (must come before progress_reports/evaluations)
-- ============================================================================
CREATE TABLE IF NOT EXISTS report_links (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  token text NOT NULL UNIQUE DEFAULT encode(gen_random_bytes(32), 'hex'),
  link_type text NOT NULL DEFAULT 'monthly',
  due_date date,
  status text NOT NULL DEFAULT 'active',
  title text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  expires_at timestamptz,
  used_at timestamptz
);
ALTER TABLE report_links ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON report_links TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_report_links" ON report_links;
CREATE POLICY "anon_select_report_links" ON report_links FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_report_links" ON report_links;
CREATE POLICY "anon_insert_report_links" ON report_links FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_report_links" ON report_links;
CREATE POLICY "anon_update_report_links" ON report_links FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_report_links" ON report_links;
CREATE POLICY "anon_delete_report_links" ON report_links FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 12. PROGRESS_REPORTS (biweekly)
-- ============================================================================
CREATE TABLE IF NOT EXISTS progress_reports (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  report_date date NOT NULL DEFAULT CURRENT_DATE,
  period_label text DEFAULT '',
  weight_kg numeric,
  diet_adherence text DEFAULT '',
  workout_adherence text DEFAULT '',
  hunger_level text DEFAULT '',
  energy_level text DEFAULT '',
  sleep_quality text DEFAULT '',
  workout_performance text DEFAULT '',
  pain_issues text DEFAULT '',
  student_notes text DEFAULT '',
  coach_private_notes text DEFAULT '',
  report_link_id uuid REFERENCES report_links(id) ON DELETE SET NULL,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE progress_reports ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON progress_reports TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_progress_reports" ON progress_reports;
CREATE POLICY "anon_select_progress_reports" ON progress_reports FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_progress_reports" ON progress_reports;
CREATE POLICY "anon_insert_progress_reports" ON progress_reports FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_progress_reports" ON progress_reports;
CREATE POLICY "anon_update_progress_reports" ON progress_reports FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_progress_reports" ON progress_reports;
CREATE POLICY "anon_delete_progress_reports" ON progress_reports FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 13. PROGRESS_EVALUATIONS (monthly)
-- ============================================================================
CREATE TABLE IF NOT EXISTS progress_evaluations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  evaluation_date date NOT NULL DEFAULT CURRENT_DATE,
  period_label text DEFAULT '',
  weight_kg numeric,
  waist_cm numeric,
  hip_cm numeric,
  chest_cm numeric,
  thigh_cm numeric,
  arm_cm numeric,
  notes text DEFAULT '',
  report_link_id uuid REFERENCES report_links(id) ON DELETE SET NULL,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE progress_evaluations ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON progress_evaluations TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_evaluations" ON progress_evaluations;
CREATE POLICY "anon_select_evaluations" ON progress_evaluations FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_evaluations" ON progress_evaluations;
CREATE POLICY "anon_insert_evaluations" ON progress_evaluations FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_evaluations" ON progress_evaluations;
CREATE POLICY "anon_update_evaluations" ON progress_evaluations FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_evaluations" ON progress_evaluations;
CREATE POLICY "anon_delete_evaluations" ON progress_evaluations FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 14. PROGRESS_PHOTOS
-- ============================================================================
CREATE TABLE IF NOT EXISTS progress_photos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  evaluation_id uuid NOT NULL REFERENCES progress_evaluations(id) ON DELETE CASCADE,
  photo_type text NOT NULL DEFAULT 'front',
  storage_path text NOT NULL DEFAULT '',
  public_url text DEFAULT '',
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE progress_photos ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON progress_photos TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_photos" ON progress_photos;
CREATE POLICY "anon_select_photos" ON progress_photos FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_photos" ON progress_photos;
CREATE POLICY "anon_insert_photos" ON progress_photos FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_photos" ON progress_photos;
CREATE POLICY "anon_update_photos" ON progress_photos FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_photos" ON progress_photos;
CREATE POLICY "anon_delete_photos" ON progress_photos FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 15. CORRECTIVE_ISSUES
-- ============================================================================
CREATE TABLE IF NOT EXISTS corrective_issues (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name_fa text NOT NULL,
  name_en text DEFAULT '',
  description text DEFAULT '',
  suggested_tags text[] DEFAULT '{}',
  is_active boolean DEFAULT true,
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE corrective_issues ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON corrective_issues TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_corrective" ON corrective_issues;
CREATE POLICY "anon_select_corrective" ON corrective_issues FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_corrective" ON corrective_issues;
CREATE POLICY "anon_insert_corrective" ON corrective_issues FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_corrective" ON corrective_issues;
CREATE POLICY "anon_update_corrective" ON corrective_issues FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_corrective" ON corrective_issues;
CREATE POLICY "anon_delete_corrective" ON corrective_issues FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 16. CORRECTIVE_ISSUE_EXERCISES
-- ============================================================================
CREATE TABLE IF NOT EXISTS corrective_issue_exercises (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  issue_id uuid NOT NULL REFERENCES corrective_issues(id) ON DELETE CASCADE,
  exercise_id uuid NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE corrective_issue_exercises ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON corrective_issue_exercises TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_corrective_ex" ON corrective_issue_exercises;
CREATE POLICY "anon_select_corrective_ex" ON corrective_issue_exercises FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_corrective_ex" ON corrective_issue_exercises;
CREATE POLICY "anon_insert_corrective_ex" ON corrective_issue_exercises FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_corrective_ex" ON corrective_issue_exercises;
CREATE POLICY "anon_update_corrective_ex" ON corrective_issue_exercises FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_corrective_ex" ON corrective_issue_exercises;
CREATE POLICY "anon_delete_corrective_ex" ON corrective_issue_exercises FOR DELETE TO anon, authenticated USING (true);

-- ============================================================================
-- 17. GUIDES
-- ============================================================================
CREATE TABLE IF NOT EXISTS guides (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text NOT NULL UNIQUE,
  title text NOT NULL,
  category text NOT NULL DEFAULT 'general',
  content text DEFAULT '',
  is_active boolean DEFAULT true,
  sort_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);
ALTER TABLE guides ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON guides TO anon, authenticated;
DROP POLICY IF EXISTS "anon_select_guides" ON guides;
CREATE POLICY "anon_select_guides" ON guides FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_guides" ON guides;
CREATE POLICY "anon_insert_guides" ON guides FOR INSERT TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_guides" ON guides;
CREATE POLICY "anon_update_guides" ON guides FOR UPDATE TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_guides" ON guides;
CREATE POLICY "anon_delete_guides" ON guides FOR DELETE TO anon, authenticated USING (true);

-- Seed default guides
INSERT INTO guides (slug, title, category, content, sort_order) VALUES
  ('food_substitution', 'راهنمای عمومی جایگزین‌های غذایی', 'food', '', 1),
  ('restaurant_party', 'راهنمای مهمانی و انتخاب غذا در رستوران', 'food', '', 2),
  ('travel_nutrition', 'راهنمای تغذیه در سفر', 'food', '', 3),
  ('hard_days', 'راهنمای روزهای سخت، کمبود وقت یا آماده نبودن غذا', 'food', '', 4)
ON CONFLICT (slug) DO NOTHING;

-- Seed default corrective issues
INSERT INTO corrective_issues (name_fa, name_en, description, suggested_tags, sort_order) VALUES
  ('گودی بیش از حد کمر', 'Excessive Lumbar Curve', 'پیشنهاد حرکات تقویت کننده هسته و باسن', ARRAY['corrective','mobility','stretching'], 1),
  ('شانه‌های گرد', 'Rounded Shoulders', 'پیشنهاد حرکات باز کردن سینه و تقویت پشت شانه', ARRAY['corrective','stretching'], 2),
  ('سر خوردن به جلو', 'Forward Head Posture', 'پیشنهاد حرکات تقویت پشت گردن و کشش جلو گردن', ARRAY['corrective','stretching'], 3),
  ('زانوی پرانتزی', 'Knock Knees', 'پیشنهاد حرکات تقویت داخلی ران و اصلاح الگوی حرکت', ARRAY['corrective','mobility'], 4),
  ('زانوی زانو به داخل', 'Knee Valgus', 'پیشنهاد حرکات تقویت گلوت مدیال و ابداکشن ران', ARRAY['corrective'], 5),
  ('کمبود انعطاف‌پذیری', 'Limited Flexibility', 'پیشنهاد حرکات کششی برای نواحی مختلف', ARRAY['stretching'], 6),
  ('ضعف هسته', 'Core Weakness', 'پیشنهاد حرکات تقویت هسته و شکم', ARRAY['corrective','strength'], 7)
ON CONFLICT DO NOTHING;