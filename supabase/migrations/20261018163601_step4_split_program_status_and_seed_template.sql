/*
# Split program status tracking + seed structured template exercises

## What this migration does

1. **Adds two status columns to `assigned_programs`** so workout and diet
   sections can each independently track their design state:
   - `workout_status` text: 'none' (default) | 'draft' | 'completed'
   - `diet_status` text: 'none' (default) | 'draft' | 'completed'

   These are informational labels surfaced in the UI. Existing rows are
   backfilled: if a program already has workout_template_id or
   program_exercises, workout_status becomes 'completed'; if it has a
   diet_template_id or custom_description, diet_status becomes 'completed'.
   Otherwise they stay 'none'.

2. **Seeds `template_exercises` for the existing "برنامه مبتدی کامل‌بدن"
   workout template** (id = a694b759-053f-4d9b-b7d5-a68e8f0b0009) so the
   coach can immediately test loading a structured template into a
   student's program editor. Three training days are seeded using existing
   exercises from the bank. Only inserted if none exist yet for this
   template (idempotent).

## Security
- No new tables. No RLS policy changes — existing authenticated-only
  policies on `assigned_programs` and `template_exercises` continue to
  apply to the new columns automatically.
*/

-- 1. Add status columns (idempotent)
ALTER TABLE assigned_programs
  ADD COLUMN IF NOT EXISTS workout_status text NOT NULL DEFAULT 'none'
    CHECK (workout_status IN ('none','draft','completed'));

ALTER TABLE assigned_programs
  ADD COLUMN IF NOT EXISTS diet_status text NOT NULL DEFAULT 'none'
    CHECK (diet_status IN ('none','draft','completed'));

-- 2. Backfill existing rows from current content
UPDATE assigned_programs ap
SET workout_status = 'completed'
WHERE workout_status = 'none'
  AND (
    ap.workout_template_id IS NOT NULL
    OR EXISTS (SELECT 1 FROM program_exercises pe WHERE pe.program_id = ap.id)
  );

UPDATE assigned_programs ap
SET diet_status = 'completed'
WHERE diet_status = 'none'
  AND (
    ap.diet_template_id IS NOT NULL
    OR COALESCE(ap.custom_description, '') <> ''
  );

-- 3. Seed structured template exercises for "برنامه مبتدی کامل‌بدن"
--    Only if no template_exercises exist for this template yet.
INSERT INTO template_exercises
  (template_id, exercise_id, sort_order, sets, reps, rest_seconds, rpe, day_label, coach_notes)
SELECT
  'a694b759-053f-4d9b-b7d5-a68e8f0b0009',
  e.id,
  n.sort_order,
  n.sets,
  n.reps,
  n.rest_seconds,
  n.rpe,
  n.day_label,
  n.coach_notes
FROM (VALUES
  -- روز ۱ — بالاتنه
  ('5132864b-56dc-4466-a31f-82efa9c43f1d'::uuid, 0, 3, '10-12', 60, 7, 'روز ۱ — بالاتنه', ''),
  ('bda114e7-67e3-4e93-90cf-22c06f5b3f9c'::uuid, 1, 3, '10',     90, 7, 'روز ۱ — بالاتنه', ''),
  ('80e89bd6-4937-42a7-8e55-c99fd995348b'::uuid, 2, 3, '12',     60, 6, 'روز ۱ — بالاتنه', ''),
  ('84eb6c23-48d2-44d7-a102-32489c265f44'::uuid, 3, 3, '30s',    45, null, 'روز ۱ — بالاتنه', 'هیئت را حفظ کن'),
  -- روز ۲ — پایین‌تنه
  ('c1df9530-bf8e-44f5-9e63-5298355149ed'::uuid, 4, 4, '8-10',   120, 7, 'روز ۲ — پایین‌تنه', ''),
  ('8883de69-74ed-40bf-95c1-e0661ecc9649'::uuid, 5, 3, '10',     90, 7, 'روز ۲ — پایین‌تنه', ''),
  ('e069c244-619b-4e31-ac33-e6c8e339c077'::uuid, 6, 3, '12',     60, 6, 'روز ۲ — پایین‌تنه', ''),
  -- روز ۳ — فول‌بادی / هسته
  ('f7928573-f4e6-400b-8c58-1e87464709f8'::uuid, 7, 3, '15',     45, 5, 'روز ۳ — فول‌بادی', ''),
  ('c6621c2c-b570-42f3-8291-bf7d33bc5b11'::uuid, 8, 3, '6-8',    90, 7, 'روز ۳ — فول‌بادی', ''),
  ('448da388-b6d0-4bea-9ac5-ae0e8e1184b0'::uuid, 9, 3, '12',     60, 6, 'روز ۳ — فول‌بادی', '')
) AS n(exercise_id, sort_order, sets, reps, rest_seconds, rpe, day_label, coach_notes)
JOIN exercises e ON e.id = n.exercise_id
WHERE NOT EXISTS (
  SELECT 1 FROM template_exercises te
  WHERE te.template_id = 'a694b759-053f-4d9b-b7d5-a68e8f0b0009'
);
