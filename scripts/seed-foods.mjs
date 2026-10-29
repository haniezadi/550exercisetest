#!/usr/bin/env node
// Seeds the foods table from the parsed food bank data.
// Reads the generated SQL from /tmp/food-seed.sql and executes it in chunks.
import { readFileSync } from 'fs';
import pg from 'pg';

const { Client } = pg;

const env = (key) => {
  const match = readFileSync('.env', 'utf8').match(new RegExp(`^${key}=(.*)$`, 'm'));
  return match ? match[1].trim() : undefined;
};

const dbUrl = env('SUPABASE_DB_URL');
if (!dbUrl) {
  console.error('SUPABASE_DB_URL not found in .env');
  process.exit(1);
}

const sql = readFileSync('/tmp/food-seed.sql', 'utf-8');

// Extract the DO block body by splitting on base food boundaries
const headerMatch = sql.match(/DO \$\$[\s\S]*?BEGIN\n/);
const header = headerMatch ? headerMatch[0] : "DO $$ \nDECLARE\n  v_base_id uuid;\nBEGIN\n";
const endStr = '\nEND $$;\n';

const body = sql.slice(header.length);
// Remove the trailing END $$;
const bodyClean = body.replace(/\nEND \$\$;\n?$/, '');
const foodBlocks = bodyClean.split(/(?=\n  -- Base food:)/).filter(s => s.trim());

console.log(`Found ${foodBlocks.length} base food blocks`);

const chunkSize = 15;
const chunks = [];
for (let i = 0; i < foodBlocks.length; i += chunkSize) {
  chunks.push(foodBlocks.slice(i, i + chunkSize).join(''));
}

console.log(`Split into ${chunks.length} chunks of ~${chunkSize} foods each`);

const client = new Client({ connectionString: dbUrl });

try {
  await client.connect();
  console.log('Connected to database');

  const before = await client.query('SELECT count(*) FROM foods');
  console.log(`Foods count before seeding: ${before.rows[0].count}`);

  let totalInserts = 0;
  for (let i = 0; i < chunks.length; i++) {
    const chunkSql = header + chunks[i] + endStr;
    const insertCount = (chunks[i].match(/INSERT INTO/g) || []).length;
    try {
      await client.query(chunkSql);
      console.log(`  Chunk ${i + 1}/${chunks.length}: ${insertCount} INSERTs OK`);
      totalInserts += insertCount;
    } catch (err) {
      console.error(`  Chunk ${i + 1}/${chunks.length}: ERROR - ${err.message.substring(0, 300)}`);
      // Try executing each food block individually
      console.log(`  Retrying chunk ${i + 1} food-by-food...`);
      const individualBlocks = chunks[i].split(/(?=\n  -- Base food:)/).filter(s => s.trim());
      let ok = 0, fail = 0;
      for (const block of individualBlocks) {
        try {
          await client.query(header + block + endStr);
          ok++;
        } catch (e) {
          fail++;
          console.error(`    Failed: ${e.message.substring(0, 200)}`);
          console.error(`    Block: ${block.substring(0, 100).replace(/\n/g, ' ')}...`);
        }
      }
      console.log(`  Chunk ${i + 1}: ${ok} ok, ${fail} failed (individual)`);
      totalInserts += ok;
    }
  }

  const after = await client.query('SELECT count(*) FROM foods');
  console.log(`\nFoods count after seeding: ${after.rows[0].count}`);
  console.log(`Total INSERTs attempted: ${totalInserts}`);

  // Summary by meal type
  const summary = await client.query(`
    SELECT meal_type, snack_subtype, 
           count(*) FILTER (WHERE parent_food_id IS NULL) as base_count,
           count(*) FILTER (WHERE parent_food_id IS NOT NULL) as version_count
    FROM foods 
    WHERE source_key IS NOT NULL
    GROUP BY meal_type, snack_subtype 
    ORDER BY meal_type, snack_subtype
  `);
  console.log('\nSummary by meal type:');
  for (const row of summary.rows) {
    console.log(`  ${row.meal_type || 'null'} / ${row.snack_subtype || 'null'}: ${row.base_count} base, ${row.version_count} versions`);
  }

  // Check for foods with no versions
  const noVersions = await client.query(`
    SELECT name, meal_type FROM foods 
    WHERE parent_food_id IS NULL AND source_key IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM foods v WHERE v.parent_food_id = foods.id)
  `);
  if (noVersions.rows.length > 0) {
    console.log(`\nWARNING: ${noVersions.rows.length} base foods with no versions:`);
    for (const row of noVersions.rows) {
      console.log(`  ${row.name} (${row.meal_type})`);
    }
  } else {
    console.log('\nAll base foods have at least one version.');
  }
} catch (err) {
  console.error('Fatal error:', err.message);
  process.exit(1);
} finally {
  await client.end();
}
