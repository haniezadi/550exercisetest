import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, Authorization, X-Client-Info, Apikey",
};

const TABLES = [
  "students",
  "intake_requests",
  "student_plans",
  "measurements",
  "reminders",
  "exercises",
  "templates",
  "template_exercises",
  "assigned_programs",
  "program_exercises",
  "diet_template_meals",
  "diet_template_food_items",
  "diet_program_meals",
  "diet_program_food_items",
  "diet_tips",
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
  "corrective_issues",
  "corrective_issue_exercises",
  "guides",
];

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { status: 200, headers: corsHeaders });
  }

  try {
    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    );

    const data: Record<string, unknown> = {};
    const counts: Record<string, number> = {};

    for (const table of TABLES) {
      const { data: rows, error } = await supabase
        .from(table)
        .select("*")
        .order("created_at", { ascending: true });

      if (error) {
        counts[table] = -1;
        data[table] = { _error: error.message };
        continue;
      }

      counts[table] = rows.length;
      data[table] = rows;
    }

    // List storage objects in progress-photos bucket
    let storageFiles: unknown = [];
    const { data: objects, error: storageError } = await supabase
      .storage
      .from("progress-photos")
      .list();

    if (!storageError && objects) {
      storageFiles = objects;
    }

    const backup = {
      metadata: {
        version: 1,
        exported_at: new Date().toISOString(),
        table_count: TABLES.length,
        row_counts: counts,
        storage_bucket: "progress-photos",
        storage_file_count: Array.isArray(storageFiles) ? storageFiles.length : 0,
      },
      data,
      storage: {
        bucket: "progress-photos",
        files: storageFiles,
      },
    };

    const json = JSON.stringify(backup, null, 2);
    const filename = `backup-${new Date().toISOString().slice(0, 10)}.json`;

    return new Response(json, {
      status: 200,
      headers: {
        ...corsHeaders,
        "Content-Type": "application/json",
        "Content-Disposition": `attachment; filename="${filename}"`,
      },
    });
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
