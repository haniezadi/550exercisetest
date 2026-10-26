import { readFileSync, readdirSync } from 'fs';
import { join } from 'path';
import https from 'https';

const env = readFileSync('.env', 'utf8');
const url = env.match(/VITE_SUPABASE_URL=(.*)/)[1].trim();
const key = env.match(/VITE_SUPABASE_ANON_KEY=(.*)/)[1].trim();

const apiUrl = new URL(url + '/rest/v1/exercises');
const migrationsDir = 'supabase/migrations';
const chunks = readdirSync(migrationsDir)
  .filter(f => f.startsWith('step11_chunk_'))
  .sort();

console.log(`Found ${chunks.length} chunk files: ${chunks.join(', ')}`);

// Parse INSERT statements from a chunk file
function parseInserts(sql) {
  const inserts = [];
  // Match INSERT INTO exercises ... VALUES (...);
  // We need to handle multi-line values with parentheses, arrays, quotes
  const lines = sql.split('\n');
  for (const line of lines) {
    const trimmed = line.trim();
    if (!trimmed.startsWith('INSERT INTO exercises')) continue;
    // Extract the VALUES (...) part - find "VALUES (" then match until the closing ");"
    const valuesIdx = trimmed.indexOf("VALUES (");
    if (valuesIdx === -1) continue;
    // The values start after "VALUES (" and end with ");"
    const valuesStart = valuesIdx + "VALUES (".length;
    // Find the closing ");" - need to handle nested parens in ARRAY[...]
    let depth = 1;
    let endIdx = valuesStart;
    for (let i = valuesStart; i < trimmed.length; i++) {
      if (trimmed[i] === '(') depth++;
      else if (trimmed[i] === ')') {
        depth--;
        if (depth === 0) {
          endIdx = i;
          break;
        }
      }
    }
    const valuesStr = trimmed.substring(valuesStart, endIdx);
    inserts.push(valuesStr);
  }
  return inserts;
}

// Parse a values string into an object
function parseValues(valuesStr) {
  // Fields: name_fa, name_en, primary_muscles, secondary_muscles, exercise_type, equipment, difficulty, location, instructions, tips, limitations, video_url, is_active, is_favorite, tags, coach_notes
  // This is complex SQL syntax with ARRAY[...]::text[], single quotes, etc.
  // Instead of parsing SQL literals, we'll just send the raw SQL via the rpc endpoint
  return valuesStr;
}

async function executeViaRPC(sql) {
  // Use the SQL endpoint via REST API
  // Supabase doesn't expose raw SQL via REST, so we need to use the PostgREST API
  // Instead, we'll parse each INSERT and send via POST to /rest/v1/exercises
  return null;
}

// Better approach: parse each INSERT into a JSON object and POST via REST API
function sqlStringToJS(s) {
  // SQL single-quoted string to JS string: replace '' with ' and strip outer quotes
  if (s.startsWith("'") && s.endsWith("'")) {
    return s.slice(1, -1).replace(/''/g, "'");
  }
  return s;
}

function sqlArrayToJSArray(s) {
  // ARRAY['a','b']::text[] or ARRAY[]::text[]
  const match = s.match(/ARRAY\[(.*)\]::text\[\]/);
  if (!match) return [];
  if (!match[1].trim()) return [];
  // Split by comma, but need to handle commas inside quotes
  const items = [];
  let current = '';
  let inQuote = false;
  for (let i = 0; i < match[1].length; i++) {
    const c = match[1][i];
    if (c === "'" && (i === 0 || match[1][i-1] !== '\\')) {
      inQuote = !inQuote;
      current += c;
    } else if (c === ',' && !inQuote) {
      items.push(current.trim());
      current = '';
    } else {
      current += c;
    }
  }
  if (current.trim()) items.push(current.trim());
  return items.map(item => sqlStringToJS(item));
}

function sqlBoolToJS(s) {
  return s.trim() === 'true';
}

function parseInsertToJSON(valuesStr) {
  // We need to carefully parse the 16 fields
  // Fields are separated by commas, but commas can appear inside quotes and arrays
  const fields = [];
  let current = '';
  let depth = 0;
  let inQuote = false;
  let quoteDepth = 0;

  for (let i = 0; i < valuesStr.length; i++) {
    const c = valuesStr[i];
    if (c === "'" && (i === 0 || valuesStr[i-1] !== '\\')) {
      // Check if it's a doubled single-quote (escaped quote)
      if (i + 1 < valuesStr.length && valuesStr[i+1] === "'") {
        current += "''";
        i++; // skip next quote
        continue;
      }
      inQuote = !inQuote;
      current += c;
    } else if (c === '[' && !inQuote) {
      depth++;
      current += c;
    } else if (c === ']' && !inQuote) {
      depth--;
      current += c;
    } else if (c === ',' && !inQuote && depth === 0) {
      fields.push(current.trim());
      current = '';
    } else {
      current += c;
    }
  }
  if (current.trim()) fields.push(current.trim());

  if (fields.length !== 16) {
    throw new Error(`Expected 16 fields, got ${fields.length}: ${fields.map(f => f.substring(0, 30)).join(' | ')}`);
  }

  return {
    name_fa: sqlStringToJS(fields[0]),
    name_en: sqlStringToJS(fields[1]),
    primary_muscles: sqlArrayToJSArray(fields[2]),
    secondary_muscles: sqlArrayToJSArray(fields[3]),
    exercise_type: sqlStringToJS(fields[4]),
    equipment: sqlArrayToJSArray(fields[5]),
    difficulty: sqlStringToJS(fields[6]),
    location: sqlStringToJS(fields[7]),
    instructions: sqlStringToJS(fields[8]),
    tips: sqlStringToJS(fields[9]),
    limitations: sqlStringToJS(fields[10]),
    video_url: sqlStringToJS(fields[11]),
    is_active: sqlBoolToJS(fields[12]),
    is_favorite: sqlBoolToJS(fields[13]),
    tags: sqlArrayToJSArray(fields[14]),
    coach_notes: sqlStringToJS(fields[15]),
  };
}

function postExercise(record) {
  return new Promise((resolve, reject) => {
    const body = JSON.stringify(record);
    const u = new URL(apiUrl);
    const options = {
      hostname: u.hostname,
      path: u.pathname,
      method: 'POST',
      headers: {
        'apikey': key,
        'Authorization': 'Bearer ' + key,
        'Content-Type': 'application/json',
        'Prefer': 'return=minimal,resolution=ignore-duplicates',
      },
    };
    const req = https.request(options, (res) => {
      let data = '';
      res.on('data', (c) => data += c);
      res.on('end', () => {
        if (res.statusCode >= 200 && res.statusCode < 300) resolve({ ok: true, status: res.statusCode });
        else resolve({ ok: false, status: res.statusCode, body: data.substring(0, 300) });
      });
    });
    req.on('error', reject);
    req.write(body);
    req.end();
  });
}

async function main() {
  let total = 0;
  let ok = 0;
  let fail = 0;

  for (const chunk of chunks) {
    const content = readFileSync(join(migrationsDir, chunk), 'utf8');
    const valuesStrs = parseInserts(content);
    console.log(`\n${chunk}: ${valuesStrs.length} INSERTs`);

    // Process in batches of 10 for parallel requests
    for (let i = 0; i < valuesStrs.length; i += 10) {
      const batch = valuesStrs.slice(i, i + 10);
      const promises = batch.map(async (vs, j) => {
        try {
          const record = parseInsertToJSON(vs);
          const result = await postExercise(record);
          total++;
          if (result.ok) ok++;
          else {
            fail++;
            if (fail <= 5) console.error(`  Failed #${i+j}: ${result.status} ${result.body}`);
          }
        } catch (e) {
          fail++;
          if (fail <= 5) console.error(`  Parse error #${i+j}: ${e.message}`);
        }
      });
      await Promise.all(promises);
    }
    console.log(`  Progress: ok=${ok}, fail=${fail}, total=${total}`);
  }

  console.log(`\nDone! Total: ${total}, OK: ${ok}, Failed: ${fail}`);
}

main().catch(e => { console.error('Fatal:', e); process.exit(1); });
