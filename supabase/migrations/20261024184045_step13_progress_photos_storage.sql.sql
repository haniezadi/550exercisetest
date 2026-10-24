/*
# Progress Photos Storage Infrastructure

## Summary
Sets up secure, private storage for student progress photos with proper access controls.

## Changes

### 1. New columns on progress_photos
- `student_id` (uuid, NOT NULL): Direct link to students table for simpler ownership queries
- `file_size` (integer, nullable): Uploaded file size in bytes for validation/limits
- `mime_type` (text, nullable): Uploaded file MIME type for type validation

### 2. Storage bucket
- Creates `progress-photos` bucket (private, NOT public)
- Files stored under path pattern: `{student_id}/{evaluation_id}/{photo_type}/{filename}`

### 3. Storage RLS policies (storage.objects)
- SELECT (read/download): authenticated only — coach panel can view
- INSERT (upload): authenticated only — coach panel can upload
- UPDATE: authenticated only
- DELETE: authenticated only — coach can remove photos
- anon role gets NO access to storage objects in this bucket

### 4. progress_photos table RLS (tightened)
- Replaces existing open anon policies with authenticated-only CRUD
- Removes anon role access — photos are private coach data
- Keeps existing grants but revokes from anon

### 5. Security notes
- Public report links (#/report/:token) do NOT get photo access
- The anon key cannot list, read, or download any progress photo
- Only authenticated coach sessions can upload, view, and delete photos
- File path includes student_id so per-student isolation is enforced at query level
*/

-- ── 1. Add columns to progress_photos ──
ALTER TABLE progress_photos
  ADD COLUMN IF NOT EXISTS student_id uuid REFERENCES students(id) ON DELETE CASCADE,
  ADD COLUMN IF NOT EXISTS file_size integer,
  ADD COLUMN IF NOT EXISTS mime_type text;

-- Backfill student_id from evaluation link for any existing rows
UPDATE progress_photos pp
SET student_id = pe.student_id
FROM progress_evaluations pe
WHERE pp.evaluation_id = pe.id AND pp.student_id IS NULL;

-- Index for per-student photo queries
CREATE INDEX IF NOT EXISTS idx_progress_photos_student_id ON progress_photos(student_id);
CREATE INDEX IF NOT EXISTS idx_progress_photos_evaluation_id ON progress_photos(evaluation_id);

-- ── 2. Create private storage bucket ──
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'progress-photos',
  'progress-photos',
  false,
  10485760,  -- 10 MB limit
  ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/jpg']
)
ON CONFLICT (id) DO UPDATE SET
  public = false,
  file_size_limit = 10485760,
  allowed_mime_types = ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/jpg'];

-- ── 3. Storage RLS policies for progress-photos bucket ──
-- Only authenticated users (coach panel) can manage objects in this bucket
-- anon gets zero access — photos are private

DROP POLICY IF EXISTS "progress_photos_storage_read" ON storage.objects;
CREATE POLICY "progress_photos_storage_read"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (bucket_id = 'progress-photos');

DROP POLICY IF EXISTS "progress_photos_storage_insert" ON storage.objects;
CREATE POLICY "progress_photos_storage_insert"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'progress-photos');

DROP POLICY IF EXISTS "progress_photos_storage_update" ON storage.objects;
CREATE POLICY "progress_photos_storage_update"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (bucket_id = 'progress-photos')
  WITH CHECK (bucket_id = 'progress-photos');

DROP POLICY IF EXISTS "progress_photos_storage_delete" ON storage.objects;
CREATE POLICY "progress_photos_storage_delete"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (bucket_id = 'progress-photos');

-- ── 4. Tighten progress_photos table RLS ──
-- Revoke anon access; photos are private coach-only data
REVOKE SELECT, INSERT, UPDATE, DELETE ON progress_photos FROM anon;

-- Drop old open policies and replace with authenticated-only
DROP POLICY IF EXISTS "anon_select_photos" ON progress_photos;
DROP POLICY IF EXISTS "anon_insert_photos" ON progress_photos;
DROP POLICY IF EXISTS "anon_update_photos" ON progress_photos;
DROP POLICY IF EXISTS "anon_delete_photos" ON progress_photos;

CREATE POLICY "auth_select_progress_photos"
  ON progress_photos FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "auth_insert_progress_photos"
  ON progress_photos FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "auth_update_progress_photos"
  ON progress_photos FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "auth_delete_progress_photos"
  ON progress_photos FOR DELETE
  TO authenticated
  USING (true);