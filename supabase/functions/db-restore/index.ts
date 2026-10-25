import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, Authorization, X-Client-Info, Apikey",
};

// Tables in dependency-safe insert order (parents before children)
const TABLE_ORDER = [
  "exercises",
  "templates",
  "corrective_issues",
  "diet_tips",
  "guides",
  "students",
  "intake_requests",
  "student_plans",
  "measurements",
  "reminders",
  "template_exercises",
  "assigned_programs",
  "program_exercises",
  "diet_template_meals",
  "diet_template_food_items",
  "diet_program_meals",
  "diet_program_food_items",
  "diet_program_tips",
  "foods",
  "student_favorite_foods",
  "food_substitution_groups",
  "food_substitution_items",
  "weekly_diet_programs",
  "weekly_diet_meals",
  "weekly_diet_food_items",
  "meal_substitutions",
  "meal_substitution_food_items",
  "cheat_meal_config",
  "report_links",
  "progress_reports",
  "progress_evaluations",
  "progress_photos",
  "corrective_issue_exercises",
];

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { status: 200, headers: corsHeaders });
  }

  try {
    if (req.method !== "POST") {
      return new Response(
        JSON.stringify({ error: "POST required" }),
        { status: 405, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    );

    const body = await req.json();
    if (!body || !body.data) {
      return new Response(
        JSON.stringify({ error: "Missing 'data' field in backup JSON" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } },
      );
    }

    // Optional: if body.seedOnly is true, only import seed/reference tables
    const seedTables = new Set([
      "exercises", "templates", "corrective_issues", "diet_tips", "guides",
      "foods", "food_substitution_groups", "food_substitution_items",
    ]);

    const results: Record<string, { inserted: number; skipped: number; errors: string[] }> = {};

    for (const table of TABLE_ORDER) {
      if (body.seedOnly && !seedTables.has(table)) continue;

      const rows = body.data[table];
      if (!rows || !Array.isArray(rows) || rows.length === 0) {
        results[table] = { inserted: 0, skipped: 0, errors: [] };
        continue;
      }

      // Check existing rows by id to avoid duplicates (idempotent)
      const ids = rows.map((r: Record<string, unknown>) => r.id).filter(Boolean);
      const { data: existing } = await supabase
        .from(table)
        .select("id")
        .in("id", ids);

      const existingIds = new Set((existing || []).map((r: Record<string, unknown>) => r.id));
      const newRows = rows.filter((r: Record<string, unknown>) => !existingIds.has(r.id));

      if (newRows.length === 0) {
        results[table] = { inserted: 0, skipped: rows.length, errors: [] };
        continue;
      }

      const { error } = await supabase.from(table).insert(newRows);

      if (error) {
        results[table] = {
          inserted: 0,
          skipped: rows.length,
          errors: [error.message],
        };
      } else {
        results[table] = {
          inserted: newRows.length,
          skipped: existingIds.size,
          errors: [],
        };
      }
    }

    return new Response(
      JSON.stringify({ success: true, results }),
      { status: 200, headers: { ...corsHeaders, "Content-Type": "application/json" } },
    );
  } catch (err) {
    return new Response(
      JSON.stringify({ error: err instanceof Error ? err.message : "Unknown error" }),
      {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      },
    );
  }
});
