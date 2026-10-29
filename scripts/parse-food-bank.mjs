#!/usr/bin/env node
// Parses seed-data/بانک_غذایی_.txt and generates SQL for seeding the foods table.
// Usage: node scripts/parse-food-bank.mjs > supabase/migrations/step15_seed_food_bank.sql

import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const filePath = join(__dirname, '..', 'seed-data', 'بانک_غذایی_.txt');
const raw = readFileSync(filePath, 'utf-8');

// --- Phase 1: Determine meal sections ---
// The file has sections: صبحانه, ناهار, شام, then snack subsections (ساده, سوپرمارکتی, سیرکننده)

const lines = raw.split('\n');

// State machine
let currentMeal = null; // breakfast | lunch | dinner | snack
let currentSnackSubtype = null; // simple | store_bought | filling | null
let foods = []; // { number, name, baseNote, meal, snackSubtype, versions: [{cal, protein, ingredients:[{name, amount, household}], note}] }
let currentFood = null;
let currentVersion = null;
let sectionHeaderLines = [];

function detectMealSection(text) {
  const t = text.trim();
  if (/صبحانه/.test(t) && !/میان‌وعده/.test(t)) return 'breakfast';
  if (/ناهار/.test(t) && !/میان‌وعده/.test(t)) return 'lunch';
  if (/شام/.test(t) && !/میان‌وعده/.test(t)) return 'dinner';
  if (/میان‌وعده/.test(t)) return 'snack';
  return null;
}

function detectSnackSubtype(text) {
  const t = text.trim();
  if (/ساده/.test(t) && /میان‌وعده/.test(t)) return 'simple';
  if (/سوپرمارکتی/.test(t)) return 'store_bought';
  if (/سیرکننده/.test(t) || /ترکیبی و سیرکننده/.test(t)) return 'filling';
  return null;
}

// Persian digits to English
function faToEnDigits(s) {
  const map = {'۰':'0','۱':'1','۲':'2','۳':'3','۴':'4','۵':'5','۶':'6','۷':'7','۸':'8','۹':'9'};
  return s.replace(/[۰-۹]/g, d => map[d]);
}

// Parse calorie/protein from a version header line like:
// "نان و پنیر و گردو — ۳۰۰ کالری / ۱۲ گرم پروتئین"
function parseVersionHeader(line) {
  const en = faToEnDigits(line);
  const calMatch = en.match(/(\d+)\s*کالری/);
  const protMatch = en.match(/(\d+)\s*گرم\s*پروتئین/);
  if (!calMatch) return null;
  return {
    cal: parseInt(calMatch[1]),
    protein: protMatch ? parseFloat(protMatch[1]) : null,
    ingredients: [],
    note: ''
  };
}

// Parse ingredient line like:
// "   * نان سنگک: ۷۵ گرم ≈ حدود ۲½ کف دست"
function parseIngredient(line) {
  const trimmed = line.trim().replace(/^\*\s*/, '');
  // Pattern: name: amount ≈ household
  const match = trimmed.match(/^(.+?):\s*(.+?)(?:\s*≈\s*(.+))?$/);
  if (!match) return null;
  return {
    name: match[1].trim(),
    amount: match[2].trim(),
    household: match[3] ? match[3].trim() : null
  };
}

// Check if a line is a food number+name header like "۱. نان و پنیر و گردو"
function parseFoodHeader(line) {
  const en = faToEnDigits(line.trim());
  const match = en.match(/^(\d+)\.\s*(.+)$/);
  if (!match) return null;
  // Check if it looks like a food name (not a calorie version line)
  const rest = match[2];
  if (/کالری/.test(rest)) return null; // This is a version line, not a food header
  return { number: parseInt(match[1]), name: match[2].trim() };
}

// Check if line is a "مبنا:" line (base description)
function isBaseNote(line) {
  return /^\s*مبنا:/.test(line) || /^مبنا:/.test(line.trim());
}

// Check if line is a note (not ingredient, not version, not header)
function isNoteLine(line, currentVersion) {
  const t = line.trim();
  if (!t) return false;
  if (t.startsWith('*')) return false; // ingredient
  if (parseVersionHeader(line)) return false;
  if (parseFoodHeader(line)) return false;
  if (isBaseNote(line)) return false;
  if (/^________________$/.test(t)) return false;
  if (/صبحانه|ناهار|شام|میان‌وعده/.test(t) && t.length < 50) return false;
  return true;
}

// Main parsing loop
for (let i = 0; i < lines.length; i++) {
  const line = lines[i];
  const trimmed = line.trim();

  // Skip empty lines
  if (!trimmed) {
    // Empty line might end a version's ingredients
    continue;
  }

  // Check for separator
  if (/^________________$/.test(trimmed)) {
    if (currentVersion && currentFood) {
      currentFood.versions.push(currentVersion);
      currentVersion = null;
    }
    if (currentFood) {
      foods.push(currentFood);
      currentFood = null;
    }
    continue;
  }

  // Check for meal section headers (short lines with meal keywords)
  if (trimmed.length < 50) {
    const meal = detectMealSection(trimmed);
    if (meal) {
      currentMeal = meal;
      if (meal === 'snack') {
        const sub = detectSnackSubtype(trimmed);
        if (sub) currentSnackSubtype = sub;
      }
      continue;
    }
    // Check for snack subtype headers
    if (currentMeal === 'snack') {
      const sub = detectSnackSubtype(trimmed);
      if (sub) {
        currentSnackSubtype = sub;
        continue;
      }
    }
  }

  // Check for food header (numbered item)
  const foodHeader = parseFoodHeader(line);
  if (foodHeader) {
    // Save previous version and food
    if (currentVersion && currentFood) {
      currentFood.versions.push(currentVersion);
      currentVersion = null;
    }
    if (currentFood) {
      foods.push(currentFood);
    }
    currentFood = {
      number: foodHeader.number,
      name: foodHeader.name,
      baseNote: '',
      meal: currentMeal,
      snackSubtype: currentMeal === 'snack' ? currentSnackSubtype : null,
      versions: []
    };
    continue;
  }

  // Check for base note
  if (isBaseNote(line) && currentFood) {
    currentFood.baseNote = trimmed.replace(/^مبنا:\s*/, '');
    continue;
  }

  // Check for version header
  const versionHeader = parseVersionHeader(line);
  if (versionHeader && currentFood) {
    // Save previous version
    if (currentVersion) {
      currentFood.versions.push(currentVersion);
    }
    currentVersion = versionHeader;
    continue;
  }

  // Check for ingredient
  if (trimmed.startsWith('*') && currentVersion) {
    const ingredient = parseIngredient(line);
    if (ingredient) {
      currentVersion.ingredients.push(ingredient);
    } else {
      // Could be a sub-option ingredient (e.g., "سیب: ۱۱۵ گرم ≈ ۱ عدد کوچک")
      const sub = parseIngredient(line);
      if (sub) currentVersion.ingredients.push(sub);
    }
    continue;
  }

  // Check for note line (after ingredients, before separator)
  if (isNoteLine(line, currentVersion) && currentFood) {
    if (currentVersion) {
      // Could be a note for the version or the food
      // If it's after the last version's ingredients, attach to food
      currentFood.baseNote = currentFood.baseNote 
        ? currentFood.baseNote + ' ' + trimmed 
        : trimmed;
    }
    continue;
  }
}

// Save any remaining data
if (currentVersion && currentFood) {
  currentFood.versions.push(currentVersion);
}
if (currentFood) {
  foods.push(currentFood);
}

// --- Phase 2: Generate SQL ---

function sqlEscape(s) {
  if (s === null || s === undefined) return 'NULL';
  return "'" + String(s).replace(/'/g, "''") + "'";
}

function jsonEscape(obj) {
  return sqlEscape(JSON.stringify(obj));
}

function slugify(name) {
  return name
    .replace(/\s+/g, '-')
    .replace(/[^\u0600-\u06FFa-zA-Z0-9-]/g, '')
    .toLowerCase();
}

let sql = `-- Step 15: Seed food bank from TXT file
-- Auto-generated by scripts/parse-food-bank.mjs
-- Idempotent: uses source_key for dedup via ON CONFLICT

-- First, insert base (parent) foods, then version (child) foods
-- Base foods have food_type='compound' and no parent_food_id
-- Version foods have parent_food_id pointing to their base

`;

// We need to insert base foods first, then versions
// Use a DO block to handle the parent-child relationship

sql += `DO $$ 
DECLARE
  v_base_id uuid;
BEGIN\n`;

let baseCount = 0;
let versionCount = 0;

for (const food of foods) {
  if (!food.versions.length) continue;
  
  const sourceKey = `${food.meal}:${food.number}:${slugify(food.name)}`;
  const mealType = food.meal === 'snack' ? 'snack' : food.meal;
  const snackSubtype = food.meal === 'snack' ? food.snackSubtype : null;
  
  // Insert base food
  sql += `\n  -- Base food: ${food.name} (${food.meal})\n`;
  sql += `  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)\n`;
  sql += `  VALUES (${sqlEscape(food.name)}, 'compound', ${sqlEscape(mealType)}, ${sqlEscape(snackSubtype)}, ${sqlEscape(sourceKey)}, ${sqlEscape(food.baseNote || null)})\n`;
  sql += `  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype\n`;
  sql += `  RETURNING id INTO v_base_id;\n`;
  baseCount++;

  for (const version of food.versions) {
    const versionKey = `${sourceKey}:${version.cal}`;
    const versionName = `${food.name} — ${version.cal} کالری`;
    const ingredientsJson = version.ingredients.length > 0 ? version.ingredients : null;
    
    sql += `\n  -- Version: ${version.cal} cal, ${version.protein}g protein\n`;
    sql += `  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)\n`;
    sql += `  VALUES (\n`;
    sql += `    ${sqlEscape(versionName)}, 'compound', ${sqlEscape(mealType)}, ${sqlEscape(snackSubtype)},\n`;
    sql += `    v_base_id, ${sqlEscape(version.cal + ' کالری')}, ${version.cal}, ${version.protein !== null ? version.protein : 'NULL'},\n`;
    sql += `    ${sqlEscape(versionKey)}, ${jsonEscape(ingredientsJson)}, NULL\n`;
    sql += `  )\n`;
    sql += `  ON CONFLICT (source_key) DO UPDATE SET\n`;
    sql += `    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,\n`;
    sql += `    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;\n`;
    versionCount++;
  }
}

sql += `\nEND $$;\n`;

// Add summary comment
sql += `\n-- Summary: ${baseCount} base foods, ${versionCount} versions\n`;
sql += `-- Total records: ${baseCount + versionCount}\n`;

// Write to stdout
process.stdout.write(sql);

// Also print stats to stderr
process.stderr.write(`\nParsed: ${foods.length} foods, ${baseCount} base, ${versionCount} versions\n`);
process.stderr.write(`Meals: ${foods.filter(f => f.meal === 'breakfast').length} breakfast, ${foods.filter(f => f.meal === 'lunch').length} lunch, ${foods.filter(f => f.meal === 'dinner').length} dinner, ${foods.filter(f => f.meal === 'snack').length} snack\n`);

// Print any foods with no versions
const noVersions = foods.filter(f => f.versions.length === 0);
if (noVersions.length > 0) {
  process.stderr.write(`\nWARNING: ${noVersions.length} foods with no versions:\n`);
  for (const f of noVersions) {
    process.stderr.write(`  #${f.number} ${f.name} (${f.meal})\n`);
  }
}
