/*
# Add unique constraint on exercises.name_fa

## Purpose
Prevents duplicate exercise entries by ensuring each Persian name (name_fa) is unique in the exercises table.
This is a data integrity safeguard — the exercises table already has 15 rows with no duplicates.

## Changes
- Adds `exercises_name_fa_unique` UNIQUE constraint on the `name_fa` column of the `exercises` table.

## Notes
- Verified: no duplicate name_fa values exist before adding this constraint.
- This constraint is required before the bulk exercise seed migration (step11) which uses ON CONFLICT (name_fa) DO NOTHING.
*/

ALTER TABLE exercises ADD CONSTRAINT exercises_name_fa_unique UNIQUE (name_fa);
