/*
# Diet system: meals, food items, diet tips, and program diet data

## Purpose
The existing diet system only stores a free-text description on assigned_programs.
This migration adds structured meal-based diet data so the coach can build
real diet templates with meals and food items, plus a reusable tips library.

## New Tables

1. `diet_template_meals` — meals inside a diet template (template_id → templates.id)
   - sort_order, name (e.g. "صبحانه"), notes
   - fasting window fields (start/end) for fasting-type templates

2. `diet_template_food_items` — food items inside a diet template meal
   - meal_id → diet_template_meals.id (CASCADE)
   - name, amount, unit, is_raw (خام/پخته), alternatives, notes
   - sort_order

3. `diet_program_meals` — meals inside a student's assigned diet program
   - program_id → assigned_programs.id (CASCADE)
   - independent copy from template (source_template_id nullable)
   - sort_order, name, notes, fasting_start, fasting_end

4. `diet_program_food_items` — food items inside a student's diet meal
   - meal_id → diet_program_meals.id (CASCADE)
   - name, amount, unit, is_raw, alternatives, notes, sort_order

5. `diet_tips` — reusable diet execution tips library
   - category, title, body, is_active, sort_order

6. `diet_program_tips` — tips selected for a specific student's diet program
   - program_id → assigned_programs.id (CASCADE)
   - tip_id → diet_tips.id (SET NULL, so deleting a tip keeps the program text)
   - custom_text (coach can edit the tip text per-student)
   - sort_order

7. `assigned_programs` — add two columns:
   - `diet_target_calories` int (nullable) — daily calorie goal
   - `diet_target_protein_g` int (nullable) — daily protein goal in grams
   - `diet_pattern` text (nullable) — diet pattern label (e.g. "فستینگ", "کربوسایکلینگ")

## Security
- This is a single-tenant no-auth coach panel. All policies use
  `TO anon, authenticated` with `USING(true)` / `WITH CHECK(true)`
  matching existing tables.
- RLS enabled on every new table.
- No changes to existing RLS policies.

## Data Safety
- All new tables and columns are additive. No existing data is modified.
- `assigned_programs.custom_description` is preserved — new columns are
  nullable and coexist with the existing free-text field.
- Idempotent: uses IF NOT EXISTS / DO $$ blocks.
*/

-- 1. Diet template meals
CREATE TABLE IF NOT EXISTS diet_template_meals (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  template_id uuid NOT NULL REFERENCES templates(id) ON DELETE CASCADE,
  sort_order int NOT NULL DEFAULT 0,
  name text NOT NULL DEFAULT '',
  notes text NOT NULL DEFAULT '',
  fasting_start text NOT NULL DEFAULT '',
  fasting_end text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE diet_template_meals ENABLE ROW LEVEL SECURITY;
CREATE INDEX IF NOT EXISTS idx_diet_template_meals_tpl ON diet_template_meals(template_id);
CREATE INDEX IF NOT EXISTS idx_diet_template_meals_sort ON diet_template_meals(template_id, sort_order);

DROP POLICY IF EXISTS "anon_select_diet_template_meals" ON diet_template_meals;
CREATE POLICY "anon_select_diet_template_meals" ON diet_template_meals FOR SELECT
  TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_diet_template_meals" ON diet_template_meals;
CREATE POLICY "anon_insert_diet_template_meals" ON diet_template_meals FOR INSERT
  TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_diet_template_meals" ON diet_template_meals;
CREATE POLICY "anon_update_diet_template_meals" ON diet_template_meals FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_diet_template_meals" ON diet_template_meals;
CREATE POLICY "anon_delete_diet_template_meals" ON diet_template_meals FOR DELETE
  TO anon, authenticated USING (true);

-- 2. Diet template food items
CREATE TABLE IF NOT EXISTS diet_template_food_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  meal_id uuid NOT NULL REFERENCES diet_template_meals(id) ON DELETE CASCADE,
  sort_order int NOT NULL DEFAULT 0,
  name text NOT NULL DEFAULT '',
  amount text NOT NULL DEFAULT '',
  unit text NOT NULL DEFAULT '',
  is_raw boolean,
  alternatives text NOT NULL DEFAULT '',
  notes text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE diet_template_food_items ENABLE ROW LEVEL SECURITY;
CREATE INDEX IF NOT EXISTS idx_diet_template_food_meal ON diet_template_food_items(meal_id);
CREATE INDEX IF NOT EXISTS idx_diet_template_food_sort ON diet_template_food_items(meal_id, sort_order);

DROP POLICY IF EXISTS "anon_select_diet_template_food" ON diet_template_food_items;
CREATE POLICY "anon_select_diet_template_food" ON diet_template_food_items FOR SELECT
  TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_diet_template_food" ON diet_template_food_items;
CREATE POLICY "anon_insert_diet_template_food" ON diet_template_food_items FOR INSERT
  TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_diet_template_food" ON diet_template_food_items;
CREATE POLICY "anon_update_diet_template_food" ON diet_template_food_items FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_diet_template_food" ON diet_template_food_items;
CREATE POLICY "anon_delete_diet_template_food" ON diet_template_food_items FOR DELETE
  TO anon, authenticated USING (true);

-- 3. Diet program meals (student's independent copy)
CREATE TABLE IF NOT EXISTS diet_program_meals (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  program_id uuid NOT NULL REFERENCES assigned_programs(id) ON DELETE CASCADE,
  source_template_id uuid,
  sort_order int NOT NULL DEFAULT 0,
  name text NOT NULL DEFAULT '',
  notes text NOT NULL DEFAULT '',
  fasting_start text NOT NULL DEFAULT '',
  fasting_end text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE diet_program_meals ENABLE ROW LEVEL SECURITY;
CREATE INDEX IF NOT EXISTS idx_diet_program_meals_prog ON diet_program_meals(program_id);
CREATE INDEX IF NOT EXISTS idx_diet_program_meals_sort ON diet_program_meals(program_id, sort_order);
CREATE INDEX IF NOT EXISTS idx_diet_program_meals_source ON diet_program_meals(source_template_id);

DROP POLICY IF EXISTS "anon_select_diet_program_meals" ON diet_program_meals;
CREATE POLICY "anon_select_diet_program_meals" ON diet_program_meals FOR SELECT
  TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_diet_program_meals" ON diet_program_meals;
CREATE POLICY "anon_insert_diet_program_meals" ON diet_program_meals FOR INSERT
  TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_diet_program_meals" ON diet_program_meals;
CREATE POLICY "anon_update_diet_program_meals" ON diet_program_meals FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_diet_program_meals" ON diet_program_meals;
CREATE POLICY "anon_delete_diet_program_meals" ON diet_program_meals FOR DELETE
  TO anon, authenticated USING (true);

-- 4. Diet program food items
CREATE TABLE IF NOT EXISTS diet_program_food_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  meal_id uuid NOT NULL REFERENCES diet_program_meals(id) ON DELETE CASCADE,
  sort_order int NOT NULL DEFAULT 0,
  name text NOT NULL DEFAULT '',
  amount text NOT NULL DEFAULT '',
  unit text NOT NULL DEFAULT '',
  is_raw boolean,
  alternatives text NOT NULL DEFAULT '',
  notes text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE diet_program_food_items ENABLE ROW LEVEL SECURITY;
CREATE INDEX IF NOT EXISTS idx_diet_program_food_meal ON diet_program_food_items(meal_id);
CREATE INDEX IF NOT EXISTS idx_diet_program_food_sort ON diet_program_food_items(meal_id, sort_order);

DROP POLICY IF EXISTS "anon_select_diet_program_food" ON diet_program_food_items;
CREATE POLICY "anon_select_diet_program_food" ON diet_program_food_items FOR SELECT
  TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_diet_program_food" ON diet_program_food_items;
CREATE POLICY "anon_insert_diet_program_food" ON diet_program_food_items FOR INSERT
  TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_diet_program_food" ON diet_program_food_items;
CREATE POLICY "anon_update_diet_program_food" ON diet_program_food_items FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_diet_program_food" ON diet_program_food_items;
CREATE POLICY "anon_delete_diet_program_food" ON diet_program_food_items FOR DELETE
  TO anon, authenticated USING (true);

-- 5. Diet tips library
CREATE TABLE IF NOT EXISTS diet_tips (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  category text NOT NULL DEFAULT '',
  title text NOT NULL DEFAULT '',
  body text NOT NULL DEFAULT '',
  is_active boolean NOT NULL DEFAULT true,
  sort_order int NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE diet_tips ENABLE ROW LEVEL SECURITY;
CREATE INDEX IF NOT EXISTS idx_diet_tips_active ON diet_tips(is_active);
CREATE INDEX IF NOT EXISTS idx_diet_tips_category ON diet_tips(category);

DROP POLICY IF EXISTS "anon_select_diet_tips" ON diet_tips;
CREATE POLICY "anon_select_diet_tips" ON diet_tips FOR SELECT
  TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_diet_tips" ON diet_tips;
CREATE POLICY "anon_insert_diet_tips" ON diet_tips FOR INSERT
  TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_diet_tips" ON diet_tips;
CREATE POLICY "anon_update_diet_tips" ON diet_tips FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_diet_tips" ON diet_tips;
CREATE POLICY "anon_delete_diet_tips" ON diet_tips FOR DELETE
  TO anon, authenticated USING (true);

-- 6. Diet program tips (selected per-student, editable text)
CREATE TABLE IF NOT EXISTS diet_program_tips (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  program_id uuid NOT NULL REFERENCES assigned_programs(id) ON DELETE CASCADE,
  tip_id uuid REFERENCES diet_tips(id) ON DELETE SET NULL,
  custom_text text NOT NULL DEFAULT '',
  sort_order int NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE diet_program_tips ENABLE ROW LEVEL SECURITY;
CREATE INDEX IF NOT EXISTS idx_diet_program_tips_prog ON diet_program_tips(program_id);

DROP POLICY IF EXISTS "anon_select_diet_program_tips" ON diet_program_tips;
CREATE POLICY "anon_select_diet_program_tips" ON diet_program_tips FOR SELECT
  TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "anon_insert_diet_program_tips" ON diet_program_tips;
CREATE POLICY "anon_insert_diet_program_tips" ON diet_program_tips FOR INSERT
  TO anon, authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "anon_update_diet_program_tips" ON diet_program_tips;
CREATE POLICY "anon_update_diet_program_tips" ON diet_program_tips FOR UPDATE
  TO anon, authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "anon_delete_diet_program_tips" ON diet_program_tips;
CREATE POLICY "anon_delete_diet_program_tips" ON diet_program_tips FOR DELETE
  TO anon, authenticated USING (true);

-- 7. Add diet target columns to assigned_programs (additive, nullable)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_schema='public' AND table_name='assigned_programs'
                 AND column_name='diet_target_calories') THEN
    ALTER TABLE public.assigned_programs ADD COLUMN diet_target_calories int;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_schema='public' AND table_name='assigned_programs'
                 AND column_name='diet_target_protein_g') THEN
    ALTER TABLE public.assigned_programs ADD COLUMN diet_target_protein_g int;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_schema='public' AND table_name='assigned_programs'
                 AND column_name='diet_pattern') THEN
    ALTER TABLE public.assigned_programs ADD COLUMN diet_pattern text;
  END IF;
END $$;
