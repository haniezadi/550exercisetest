#!/usr/bin/env node
import { readFileSync, writeFileSync, mkdirSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const sql = readFileSync(join(__dirname, '..', 'tmp-food-seed.sql'), 'utf-8');

// Find the real DO block start (the last one before first "-- Base food:")
const firstFoodIdx = sql.indexOf('-- Base food:');
const beforeFoods = sql.substring(0, firstFoodIdx);
const doMatch = beforeFoods.lastIndexOf('DO $$');
const header = beforeFoods.substring(doMatch); // "DO $$ \nDECLARE\n  v_base_id uuid;\nBEGIN\n"
const endStr = '\nEND $$;\n';

const body = sql.substring(firstFoodIdx);
const bodyClean = body.replace(/\nEND \$\$;\n?$/, '');
const foodBlocks = bodyClean.split(/(?=\n  -- Base food:)/).filter(s => s.trim());

const outDir = join(__dirname, '..', 'tmp-food-mid');
mkdirSync(outDir, { recursive: true });

const chunkSize = 10;
let chunkIdx = 0;
for (let i = 0; i < foodBlocks.length; i += chunkSize) {
  const chunkFoods = foodBlocks.slice(i, Math.min(i + chunkSize, foodBlocks.length)).join('');
  const chunkContent = header + chunkFoods + endStr;
  writeFileSync(join(outDir, `mid_${String(chunkIdx).padStart(2,'0')}.sql`), chunkContent);
  chunkIdx++;
}
console.log(`Split into ${chunkIdx} mid-chunks`);
