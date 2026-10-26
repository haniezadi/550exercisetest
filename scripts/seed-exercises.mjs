import { readFileSync, readdirSync } from 'fs';
import { join } from 'path';
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

const migrationsDir = 'supabase/migrations';
const chunks = readdirSync(migrationsDir)
  .filter(f => f.startsWith('step11_chunk_'))
  .sort();

console.log(`Found ${chunks.length} chunk files: ${chunks.join(', ')}`);

const client = new Client({ connectionString: dbUrl });

try {
  await client.connect();
  console.log('Connected to database');

  // Check current count
  const before = await client.query('SELECT count(*) FROM exercises');
  console.log(`Exercise count before seeding: ${before.rows[0].count}`);

  let totalExecuted = 0;
  for (const chunk of chunks) {
    const content = readFileSync(join(migrationsDir, chunk), 'utf8');
    // Execute the entire chunk as one query
    try {
      const res = await client.query(content);
      // Count INSERTs by counting ON CONFLICT occurrences
      const insertCount = (content.match(/INSERT INTO/g) || []).length;
      console.log(`  ${chunk}: ${insertCount} INSERTs executed`);
      totalExecuted += insertCount;
    } catch (err) {
      console.error(`  ${chunk}: ERROR - ${err.message}`);
      // Try executing line by line as fallback
      console.log(`  Retrying ${chunk} line by line...`);
      const lines = content.split('\n').filter(l => l.trim().startsWith('INSERT INTO'));
      let lineOk = 0;
      let lineFail = 0;
      for (const line of lines) {
        try {
          await client.query(line);
          lineOk++;
        } catch (e) {
          lineFail++;
          if (lineFail <= 3) console.error(`    Failed: ${e.message.substring(0, 200)}`);
        }
      }
      console.log(`  ${chunk}: ${lineOk} ok, ${lineFail} failed (line-by-line)`);
      totalExecuted += lineOk;
    }
  }

  const after = await client.query('SELECT count(*) FROM exercises');
  console.log(`\nExercise count after seeding: ${after.rows[0].count}`);
  console.log(`Total INSERTs attempted: ${totalExecuted}`);
} catch (err) {
  console.error('Fatal error:', err.message);
  process.exit(1);
} finally {
  await client.end();
}
