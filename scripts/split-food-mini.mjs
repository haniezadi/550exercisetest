#!/usr/bin/env node
// Splits the generated seed SQL into very small chunks (3 foods each) for MCP execute_sql
import { readFileSync, writeFileSync, mkdirSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const sql = readFileSync(join(__dirname, '..', 'tmp-food-seed.sql'), 'utf-8');

// Extract the DO block components
const headerMatch = sql.match(/DO \$\$[\s\S]*?BEGIN\n/);
const header = headerMatch ? headerMatch[0] : "DO $$ \nDECLARE\n  v_base_id uuid;\nBEGIN\n";
const endStr = '\nEND $$;\n';

const body = sql.slice(header.length);
const bodyClean = body.replace(/\nEND \$\$;\n?$/, '');
const foodBlocks = bodyClean.split(/(?=\n  -- Base food:)/).filter(s => s.trim());

console.log(`Found ${foodBlocks.length} base food blocks`);

const outDir = join(__dirname, '..', 'tmp-food-mini');
mkdirSync(outDir, { recursive: true });

const chunkSize = 3;
let chunkIdx = 0;
for (let i = 0; i < foodBlocks.length; i += chunkSize) {
  const chunkFoods = foodBlocks.slice(i, Math.min(i + chunkSize, foodBlocks.length)).join('');
  const chunkContent = header + chunkFoods + endStr;
  writeFileSync(join(outDir, `mini_${String(chunkIdx).padStart(2,'0')}.sql`), chunkContent);
  chunkIdx++;
}

console.log(`Split into ${chunkIdx} mini-chunks of ~${chunkSize} foods each`);
