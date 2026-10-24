import { defineConfig, loadEnv } from 'vite';
import react from '@vitejs/plugin-react';
import { fileURLToPath, URL } from 'node:url';
import { readFileSync, existsSync } from 'node:fs';

const envDir = fileURLToPath(new URL('.', import.meta.url));

function firstNonEmpty(...values: (string | undefined)[]): string {
  for (const v of values) {
    if (v && v.trim() !== '') return v.trim();
  }
  return '';
}

function parseEnvFile(filePath: string): Record<string, string> {
  const out: Record<string, string> = {};
  if (!existsSync(filePath)) return out;
  const content = readFileSync(filePath, 'utf8');
  for (const line of content.split('\n')) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const eqIdx = trimmed.indexOf('=');
    if (eqIdx === -1) continue;
    const key = trimmed.slice(0, eqIdx).trim();
    let val = trimmed.slice(eqIdx + 1).trim();
    if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) {
      val = val.slice(1, -1);
    }
    out[key] = val;
  }
  return out;
}

export default defineConfig(({ mode }) => {
  const fileEnv = loadEnv(mode, envDir, '');

  const manualEnv: Record<string, string> = {};
  for (const name of ['.env', '.env.local', `.env.${mode}`, `.env.${mode}.local`]) {
    const parsed = parseEnvFile(`${envDir}${name}`);
    Object.assign(manualEnv, parsed);
  }

  const supabaseUrl = firstNonEmpty(
    fileEnv.VITE_SUPABASE_URL,
    manualEnv.VITE_SUPABASE_URL,
    process.env.VITE_SUPABASE_URL,
    process.env.SUPABASE_URL,
  );

  const supabaseKey = firstNonEmpty(
    fileEnv.VITE_SUPABASE_ANON_KEY,
    manualEnv.VITE_SUPABASE_ANON_KEY,
    process.env.VITE_SUPABASE_ANON_KEY,
    process.env.SUPABASE_ANON_KEY,
  );

  return {
    plugins: [react()],
    envDir,
    define: {
      'import.meta.env.VITE_SUPABASE_URL': JSON.stringify(supabaseUrl),
      'import.meta.env.VITE_SUPABASE_ANON_KEY': JSON.stringify(supabaseKey),
    },
    resolve: {
      alias: {
        '@': fileURLToPath(new URL('./src', import.meta.url)),
      },
    },
    optimizeDeps: {
      exclude: ['lucide-react'],
    },
  };
});
