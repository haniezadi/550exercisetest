/*
# Add unique constraint on exercises.name_fa

## Purpose
Prevents duplicate exercise entries by ensuring each Persian name (name_fa) is unique.
Required before the bulk exercise seed migrations (step9, step11) which rely on
ON CONFLICT (name_fa) DO NOTHING / ON CONFLICT DO NOTHING to deduplicate.

## Changes
- Adds UNIQUE constraint `exercises_name_fa_unique` on exercises.name_fa.

## Notes
- Verified the existing 15 rows have no duplicate name_fa values.
- Idempotent via DO block: only adds if not already present.
*/

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'exercises_name_fa_unique'
      AND conrelid = 'exercises'::regclass
  ) THEN
    ALTER TABLE exercises ADD CONSTRAINT exercises_name_fa_unique UNIQUE (name_fa);
  END IF;
END $$;
