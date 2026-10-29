#!/usr/bin/env node
// Exports all database tables as a single JSON backup file
// Usage: node scripts/export-full-backup.mjs
import { createClient } from '@supabase/supabase-js';
import { writeFileSync } from 'fs';

const url = process.env.VITE_SUPABASE_URL || '';
const key = process.env.VITE_SUPABASE_ANON_KEY || '';
if (!url || !key) { console.error('Missing Supabase credentials'); process.exit(1); }

const supabase = createClient(url, key);

const tables = [
  'students', 'templates', 'assigned_programs', 'student_plans',
  'measurements', 'reminders', 'exercises', 'program_exercises',
  'diet_program_meals', 'diet_program_food_items', 'diet_tips',
  'diet_program_tips', 'foods', 'report_links', 'corrective_issues',
  'guides', 'food_substitution_groups', 'food_substitution_items',
  'weekly_diet_programs', 'weekly_diet_meals', 'weekly_diet_food_items',
  'meal_substitutions', 'meal_substitution_food_items', 'cheat_meal_config',
  'progress_reports', 'progress_evaluations', 'progress_photos',
  'student_favorite_foods', 'intake_requests', 'corrective_issue_exercises',
  'diet_template_meals', 'diet_template_food_items', 'template_exercises'
];

const backup = { export_date: new Date().toISOString(), tables: {} };
for (const table of tables) {
  const { data, error } = await supabase.from(table).select('*');
  if (error) { console.error(`Error fetching ${table}:`, error.message); continue; }
  backup.tables[table] = data || [];
}

const json = JSON.stringify(backup, null, 2);
writeFileSync('database-backup.json', json, 'utf-8');
console.log(`Backup saved: database-backup.json (${(json.length / 1024).toFixed(1)} KB)`);
console.log(`Tables: ${Object.keys(backup.tables).length}`);
for (const [k, v] of Object.entries(backup.tables)) {
  console.log(`  ${k}: ${v.length} records`);
}
