#!/usr/bin/env node
// Splits the generated seed SQL into multiple chunk files for migration
import { readFileSync, writeFileSync, mkdirSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const sql = readFileSync(join(__dirname, '..', 'tmp-food-seed.sql'), 'utf-8');

// Split on "-- Base food:" boundaries, keeping header
const headerMatch = sql.match(/^[\s\S]*?(?=-- Base food:)/);
const header = headerMatch ? headerMatch[0] : '';
const body = sql.slice(header.length);

const foodBlocks = body.split(/(?=-- Base food:)/);
const chunkSize = 20; // foods per chunk
const chunks = [];
for (let i = 0; i < foodBlocks.length; i += chunkSize) {
  chunks.push(foodBlocks.slice(i, i + chunkSize).join(''));
}

const outDir = join(__dirname, '..', 'tmp-food-chunks');
mkdirSync(outDir, { recursive: true });

for (let i = 0; i < chunks.length; i++) {
  let chunkSql = '';
  if (i === 0) chunkSql += header;
  chunkSql += chunks[i];
  if (i === chunks.length - 1) {
    // Add END $$; from the end of the original
    const endMatch = sql.match(/(END \$\$;.*)$/s);
    if (endMatch) chunkSql += endMatch[1];
    else chunkSql += '\nEND $$;\n';
  } else {
    // Each intermediate chunk needs its own DO block wrapper
    // Actually, let's restructure: each chunk gets full DO block
  }
  // Actually, let's restructure properly
}

// Better approach: each chunk is a complete DO $$ ... END $$; block
let chunkSql = '';
let chunkIdx = 0;
const doHeader = header.match(/DO \$\$[\s\S]*?BEGIN/);
const doHeaderStr = doHeader ? doHeader[0] : 'DO $$ \nDECLARE\n  v_base_id uuid;\nBEGIN';
const endStr = 'END $$;';

for (let i = 0; i < foodBlocks.length; i += chunkSize) {
  const chunkFoods = foodBlocks.slice(i, Math.min(i + chunkSize, foodBlocks.length)).join('');
  const chunkContent = `${doHeaderStr}\n${chunkFoods}\n${endStr};\n`;
  writeFileSync(join(outDir, `chunk_${String(chunkIdx).padStart(2,'0')}.sql`), chunkContent);
  chunkIdx++;
}

console.log(`Split into ${chunkIdx} chunks in ${outDir}`);
