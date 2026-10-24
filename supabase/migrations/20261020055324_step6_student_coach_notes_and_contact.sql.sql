/*
# Add coach notes and contact fields to students

## Purpose
Phase 4 of the panel development requires:
- Internal coach notes per student (separate from program data shown to the student).
- Contact phone number (used in student search/filter).
- Optional Jalali birth date stored as ISO date for correct date-only handling.

## Changes
1. New columns on `students` (all nullable, all additive — no existing data affected):
   - `phone` (text) — contact phone number.
   - `birth_date` (date) — date-only birth date (stored ISO; UI converts to/from Jalali).
   - `coach_notes` (text) — internal coach notes, not part of delivered program output.

## Security
- No policy changes. Existing RLS policies on `students` already grant full CRUD
  to `authenticated`/`anon`, and these new columns inherit those same grants.
  The columns are plain-text fields with no special access requirements; they
  are populated only through the coach panel (authenticated).

## Notes
- Columns are nullable so existing rows remain valid without backfill.
- No data is moved or deleted. `id`, `name`, `age`, etc. are untouched.
- Idempotent: uses `DO $$ ... IF NOT EXISTS ... END $$` so re-running is safe.
*/

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_schema='public' AND table_name='students' AND column_name='phone') THEN
    ALTER TABLE public.students ADD COLUMN phone text;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_schema='public' AND table_name='students' AND column_name='birth_date') THEN
    ALTER TABLE public.students ADD COLUMN birth_date date;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns
                 WHERE table_schema='public' AND table_name='students' AND column_name='coach_notes') THEN
    ALTER TABLE public.students ADD COLUMN coach_notes text DEFAULT ''::text;
  END IF;
END $$;
