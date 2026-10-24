import { supabase, todayInTehran, addDaysISO, daysBetween, type StudentPlan, type Measurement, type Reminder, type ReminderType, type Student } from '@/lib/supabase';

const MEASUREMENT_INTERVAL_DAYS = 14;
const RENEWAL_REMINDER_DAYS_BEFORE = 3;

/**
 * Generate reminders for all students based on their plans and measurements.
 * Called on coach panel load. Creates no duplicates — checks existing reminders
 * with same student_id, type, due_date, and status='pending'.
 */
export async function syncReminders(
  students: Student[],
  plans: StudentPlan[],
  measurements: Measurement[],
): Promise<void> {
  const today = todayInTehran();
  const inserts: Array<{
    student_id: string;
    plan_id: string | null;
    type: ReminderType;
    due_date: string;
    status: string;
    title: string;
    detail: string;
  }> = [];

  // Check existing pending reminders to avoid duplicates
  const { data: existing } = await supabase
    .from('reminders')
    .select('student_id,type,due_date,status,plan_id')
    .eq('status', 'pending');

  const existingKeys = new Set<string>();
  if (existing) {
    for (const r of existing as Pick<Reminder, 'student_id' | 'type' | 'due_date' | 'status' | 'plan_id'>[]) {
      existingKeys.add(`${r.student_id}|${r.type}|${r.due_date}`);
    }
  }

  // 1. Measurement reminders: every 14 days from last measurement (or student creation)
  for (const student of students) {
    const studentMeasurements = measurements
      .filter((m) => m.student_id === student.id)
      .sort((a, b) => b.recorded_at.localeCompare(a.recorded_at));

    const lastDate = studentMeasurements.length > 0
      ? studentMeasurements[0].recorded_at
      : student.created_at.slice(0, 10);

    // Generate next due date
    let nextDue = addDaysISO(lastDate, MEASUREMENT_INTERVAL_DAYS);

    // If the next due is in the past, keep it as overdue
    // Only generate ONE reminder per cycle (the next one)
    const key = `${student.id}|measurement|${nextDue}`;
    if (!existingKeys.has(key) && nextDue >= student.created_at.slice(0, 10)) {
      inserts.push({
        student_id: student.id,
        plan_id: null,
        type: 'measurement',
        due_date: nextDue,
        status: 'pending',
        title: 'یادآور اندازه‌گیری ۱۴ روزه',
        detail: `اندازه‌گیری دوره‌ای — آخرین ثبت: ${lastDate}`,
      });
      existingKeys.add(key);
    }
  }

  // 2. Renewal reminders: 3 days before plan end date
  for (const plan of plans) {
    if (plan.plan_status === 'renewed' || plan.plan_status === 'expired') continue;

    const daysToEnd = daysBetween(today, plan.end_date);

    // Only create renewal reminder if within 3 days before end (and not past)
    if (daysToEnd <= RENEWAL_REMINDER_DAYS_BEFORE && daysToEnd >= 0) {
      const dueDate = plan.end_date;
      const key = `${plan.student_id}|renewal|${dueDate}`;
      if (!existingKeys.has(key)) {
        inserts.push({
          student_id: plan.student_id,
          plan_id: plan.id,
          type: 'renewal',
          due_date: dueDate,
          status: 'pending',
          title: 'یادآور تمدید پلن',
          detail: `پلن در تاریخ ${dueDate} به پایان می‌رسد`,
        });
        existingKeys.add(key);
      }
    }
  }

  if (inserts.length > 0) {
    await supabase.from('reminders').insert(inserts);
  }

  // 3. Update plan statuses based on dates
  await updatePlanStatuses(plans);
}

/**
 * Update plan_status based on current date vs end date.
 * - active: end_date > 3 days from now
 * - expiring: end_date within 3 days
 * - expired: end_date < today
 * (renewed is set manually and not overwritten)
 */
async function updatePlanStatuses(plans: StudentPlan[]): Promise<void> {
  const today = todayInTehran();
  const updates: Array<{ id: string; status: string }> = [];

  for (const plan of plans) {
    if (plan.plan_status === 'renewed') continue;

    const daysToEnd = daysBetween(today, plan.end_date);
    let newStatus: 'active' | 'expiring' | 'expired';

    if (daysToEnd < 0) {
      newStatus = 'expired';
    } else if (daysToEnd <= RENEWAL_REMINDER_DAYS_BEFORE) {
      newStatus = 'expiring';
    } else {
      newStatus = 'active';
    }

    if (newStatus !== plan.plan_status) {
      updates.push({ id: plan.id, status: newStatus });
    }
  }

  for (const u of updates) {
    await supabase
      .from('student_plans')
      .update({ plan_status: u.status, updated_at: new Date().toISOString() })
      .eq('id', u.id);
  }
}

/**
 * After recording a measurement, create the next measurement reminder (14 days ahead).
 */
export async function createNextMeasurementReminder(
  studentId: string,
  measurementDate: string,
): Promise<void> {
  const nextDue = addDaysISO(measurementDate, MEASUREMENT_INTERVAL_DAYS);

  // Check if one already exists
  const { data: existing } = await supabase
    .from('reminders')
    .select('id')
    .eq('student_id', studentId)
    .eq('type', 'measurement')
    .eq('due_date', nextDue)
    .eq('status', 'pending')
    .maybeSingle();

  if (existing) return;

  // Mark any old pending measurement reminders as done
  await supabase
    .from('reminders')
    .update({ status: 'done', updated_at: new Date().toISOString() })
    .eq('student_id', studentId)
    .eq('type', 'measurement')
    .eq('status', 'pending');

  // Create next one
  await supabase.from('reminders').insert({
    student_id: studentId,
    plan_id: null,
    type: 'measurement',
    due_date: nextDue,
    status: 'pending',
    title: 'یادآور اندازه‌گیری ۱۴ روزه',
    detail: `اندازه‌گیری دوره‌ای — آخرین ثبت: ${measurementDate}`,
  });
}

/**
 * After renewing a plan, dismiss old renewal reminders for the old plan.
 */
export async function dismissOldRenewalReminders(planId: string): Promise<void> {
  await supabase
    .from('reminders')
    .update({ status: 'dismissed', updated_at: new Date().toISOString() })
    .eq('plan_id', planId)
    .eq('type', 'renewal')
    .eq('status', 'pending');
}
