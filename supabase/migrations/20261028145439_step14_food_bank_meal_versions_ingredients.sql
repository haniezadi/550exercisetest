-- Step 14: Expand foods table for meal-based categorization, calorie versions, and ingredients
-- This is an additive migration — no existing columns or data are removed.

-- 1. Add meal categorization and version support to foods table
ALTER TABLE foods
  ADD COLUMN IF NOT EXISTS food_type text DEFAULT 'single'
    CHECK (food_type IN ('single', 'compound')),
  ADD COLUMN IF NOT EXISTS meal_type text
    CHECK (meal_type IN ('breakfast', 'lunch', 'dinner', 'snack')),
  ADD COLUMN IF NOT EXISTS snack_subtype text
    CHECK (snack_subtype IN ('simple', 'store_bought', 'filling')),
  ADD COLUMN IF NOT EXISTS parent_food_id uuid REFERENCES foods(id) ON DELETE CASCADE,
  ADD COLUMN IF NOT EXISTS version_label text,
  ADD COLUMN IF NOT EXISTS calories integer,
  ADD COLUMN IF NOT EXISTS protein numeric(6,1),
  ADD COLUMN IF NOT EXISTS fiber numeric(6,1),
  ADD COLUMN IF NOT EXISTS ingredients jsonb;

-- 2. Add a stable key for dedup on re-seed
ALTER TABLE foods
  ADD COLUMN IF NOT EXISTS source_key text;

-- 3. Index for meal-based queries
CREATE INDEX IF NOT EXISTS idx_foods_meal_type ON foods(meal_type);
CREATE INDEX IF NOT EXISTS idx_foods_snack_subtype ON foods(snack_subtype);
CREATE INDEX IF NOT EXISTS idx_foods_parent_food_id ON foods(parent_food_id);
CREATE INDEX IF NOT EXISTS idx_foods_source_key ON foods(source_key);

-- 4. Update RLS policies: existing policies already cover the table since we didn't drop/recreate it.
--    The new columns are covered by the existing GRANT on the table.
