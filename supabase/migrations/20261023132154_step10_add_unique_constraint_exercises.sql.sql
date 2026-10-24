-- Add unique constraint on name_fa to prevent duplicate exercise entries
ALTER TABLE exercises ADD CONSTRAINT exercises_name_fa_unique UNIQUE (name_fa);