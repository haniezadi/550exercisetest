#!/usr/bin/env node
/**
 * Export seed data (exercises, templates, diet_tips, corrective_issues, guides)
 * from the current Supabase project to JSON files for version control.
 *
 * Usage:
 *   node scripts/export-seed-data.js
 *
 * Requires env vars: SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY
 * (or a .env file with VITE_SUPABASE_URL + SUPABASE_SERVICE_ROLE_KEY)
 */
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Load .env manually
const envPath = path.join(__dirname, '..', '.env');
if (fs.existsSync(envPath)) {
  for (const line of fs.readFileSync(envPath, 'utf8').split('\n')) {
    const m = line.match(/^(\w+)=(.+)$/);
    if (m) process.env[m[1]] = m[2].trim().replace(/^["']|["']$/g, '');
  }
}

const url = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !key) {
  console.error('Missing SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY. Set them in .env or environment.');
  process.exit(1);
}

const supabase = createClient(url, key);

const TABLES = [
  { name: 'exercises', file: 'exercises.json' },
  { name: 'templates', file: 'templates.json' },
  { name: 'diet_tips', file: 'diet_tips.json' },
  { name: 'corrective_issues', file: 'corrective_issues.json' },
  { name: 'guides', file: 'guides.json' },
  { name: 'foods', file: 'foods.json' },
  { name: 'food_substitution_groups', file: 'food_substitution_groups.json' },
  { name: 'food_substitution_items', file: 'food_substitution_items.json' },
];

async function main() {
  const outDir = path.join(__dirname, '..', 'seed-data');
  fs.mkdirSync(outDir, { recursive: true });

  const summary = {};
  for (const { name, file } of TABLES) {
    const { data, error } = await supabase.from(name).select('*');
    if (error) {
      console.error(`Error exporting ${name}:`, error.message);
      summary[name] = { error: error.message, count: 0 };
      continue;
    }
    const outPath = path.join(outDir, file);
    fs.writeFileSync(outPath, JSON.stringify(data, null, 2));
    summary[name] = { count: data.length, file: `seed-data/${file}` };
    console.log(`Exported ${data.length} rows from ${name} → seed-data/${file}`);
  }

  fs.writeFileSync(
    path.join(outDir, 'manifest.json'),
    JSON.stringify({ exported_at: new Date().toISOString(), tables: summary }, null, 2),
  );
  console.log('\nSummary:', JSON.stringify(summary, null, 2));
}

main().catch((e) => { console.error(e); process.exit(1); });
