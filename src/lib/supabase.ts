import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL as string;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY as string;

export const supabaseConfigured = Boolean(supabaseUrl && supabaseAnonKey);

export const supabase = supabaseConfigured
  ? createClient(supabaseUrl, supabaseAnonKey, {
      auth: { persistSession: true, autoRefreshToken: true },
    })
  : (null as unknown as ReturnType<typeof createClient>);

export type TemplateType = 'workout' | 'diet';

export interface Student {
  id: string;
  name: string;
  age: number | null;
  height_cm: number | null;
  weight_kg: number | null;
  goal: string | null;
  source_request_id: string | null;
  created_at: string;
  phone: string | null;
  birth_date: string | null;
  coach_notes: string | null;
}

export interface Template {
  id: string;
  type: TemplateType;
  name: string;
  description: string;
  created_at: string;
}

export interface AssignedProgram {
  id: string;
  student_id: string;
  workout_template_id: string | null;
  diet_template_id: string | null;
  custom_name: string;
  custom_description: string;
  workout_status: 'none' | 'draft' | 'completed';
  diet_status: 'none' | 'draft' | 'completed';
  diet_target_calories: number | null;
  diet_target_protein_g: number | null;
  diet_pattern: string | null;
  created_at: string;
  updated_at: string;
}

export type RequestStatus =
  | 'new'
  | 'reviewing'
  | 'needs_info'
  | 'approved'
  | 'rejected'
  | 'converted';

export const REQUEST_STATUS_LABELS: Record<RequestStatus, string> = {
  new: 'جدید',
  reviewing: 'در حال بررسی',
  needs_info: 'نیازمند تکمیل اطلاعات',
  approved: 'تأییدشده',
  rejected: 'ردشده',
  converted: 'تبدیل‌شده به شاگرد',
};

export const REQUEST_STATUS_COLORS: Record<RequestStatus, string> = {
  new: 'bg-blue-50 text-blue-700',
  reviewing: 'bg-amber-50 text-amber-700',
  needs_info: 'bg-orange-50 text-orange-700',
  approved: 'bg-emerald-50 text-emerald-700',
  rejected: 'bg-red-50 text-red-700',
  converted: 'bg-brand-50 text-brand-700',
};

export interface IntakeRequest {
  id: string;
  status: RequestStatus;
  form_data: Record<string, unknown>;
  coach_note: string;
  converted_student_id: string | null;
  created_at: string;
  updated_at: string;
}

// --- Plans ---
export type PlanType = 'workout_only' | 'diet_only' | 'workout_diet' | 'vip' | 'custom';
export type PaymentStatus = 'paid' | 'unpaid' | 'partial';
export type PlanStatus = 'active' | 'expiring' | 'expired' | 'renewed';

export const PLAN_TYPE_LABELS: Record<PlanType, string> = {
  workout_only: 'فقط تمرین',
  diet_only: 'فقط تغذیه',
  workout_diet: 'تمرین و تغذیه',
  vip: 'VIP',
  custom: 'سفارشی',
};

export const PAYMENT_STATUS_LABELS: Record<PaymentStatus, string> = {
  paid: 'پرداخت‌شده',
  unpaid: 'پرداخت‌نشده',
  partial: 'پرداخت جزئی',
};

export const PAYMENT_STATUS_COLORS: Record<PaymentStatus, string> = {
  paid: 'bg-emerald-50 text-emerald-700',
  unpaid: 'bg-red-50 text-red-700',
  partial: 'bg-amber-50 text-amber-700',
};

export const PLAN_STATUS_LABELS: Record<PlanStatus, string> = {
  active: 'فعال',
  expiring: 'نزدیک به پایان',
  expired: 'منقضی‌شده',
  renewed: 'تمدیدشده',
};

export const PLAN_STATUS_COLORS: Record<PlanStatus, string> = {
  active: 'bg-emerald-50 text-emerald-700',
  expiring: 'bg-amber-50 text-amber-700',
  expired: 'bg-red-50 text-red-700',
  renewed: 'bg-brand-50 text-brand-700',
};

export interface StudentPlan {
  id: string;
  student_id: string;
  plan_type: PlanType;
  custom_type_label: string;
  start_date: string;
  end_date: string;
  amount: number;
  payment_status: PaymentStatus;
  plan_status: PlanStatus;
  notes: string;
  created_at: string;
  updated_at: string;
}

// --- Measurements ---
export interface Measurement {
  id: string;
  student_id: string;
  recorded_at: string;
  weight_kg: number | null;
  waist_cm: number | null;
  hip_cm: number | null;
  chest_cm: number | null;
  thigh_cm: number | null;
  arm_cm: number | null;
  extra: Record<string, unknown>;
  notes: string;
  created_at: string;
}

// --- Reminders ---
export type ReminderType = 'measurement' | 'renewal';
export type ReminderStatus = 'pending' | 'done' | 'dismissed';

export const REMINDER_TYPE_LABELS: Record<ReminderType, string> = {
  measurement: 'اندازه‌گیری',
  renewal: 'تمدید پلن',
};

export const REMINDER_STATUS_LABELS: Record<ReminderStatus, string> = {
  pending: 'در انتظار',
  done: 'انجام‌شده',
  dismissed: 'نادیده گرفته‌شده',
};

export const REMINDER_STATUS_COLORS: Record<ReminderStatus, string> = {
  pending: 'bg-amber-50 text-amber-700',
  done: 'bg-emerald-50 text-emerald-700',
  dismissed: 'bg-gray-100 text-gray-500',
};

export interface Reminder {
  id: string;
  student_id: string;
  plan_id: string | null;
  type: ReminderType;
  due_date: string;
  status: ReminderStatus;
  title: string;
  detail: string;
  created_at: string;
  updated_at: string;
}

export type StudentInput = Omit<Student, 'id' | 'created_at' | 'source_request_id'>;
export type TemplateInput = Pick<Template, 'type' | 'name' | 'description'>;

// --- Exercises (بانک حرکات) ---
export type ExerciseType = 'strength' | 'cardio' | 'mobility' | 'stretching' | 'corrective';
export type ExerciseDifficulty = 'beginner' | 'intermediate' | 'advanced';
export type ExerciseLocation = 'home' | 'gym' | 'both';

export const EXERCISE_TYPE_LABELS: Record<ExerciseType, string> = {
  strength: 'قدرتی',
  cardio: 'هوازی',
  mobility: 'موبیلیتی',
  stretching: 'کششی',
  corrective: 'اصلاحی',
};

export const EXERCISE_TYPE_COLORS: Record<ExerciseType, string> = {
  strength: 'bg-brand-50 text-brand-700',
  cardio: 'bg-red-50 text-red-700',
  mobility: 'bg-blue-50 text-blue-700',
  stretching: 'bg-emerald-50 text-emerald-700',
  corrective: 'bg-purple-50 text-purple-700',
};

export const EXERCISE_DIFFICULTY_LABELS: Record<ExerciseDifficulty, string> = {
  beginner: 'مبتدی',
  intermediate: 'متوسط',
  advanced: 'پیشرفته',
};

export const EXERCISE_DIFFICULTY_COLORS: Record<ExerciseDifficulty, string> = {
  beginner: 'bg-emerald-50 text-emerald-700',
  intermediate: 'bg-amber-50 text-amber-700',
  advanced: 'bg-red-50 text-red-700',
};

export const EXERCISE_LOCATION_LABELS: Record<ExerciseLocation, string> = {
  home: 'خانه',
  gym: 'باشگاه',
  both: 'هر دو',
};

export const MUSCLE_OPTIONS = [
  'سینه', 'پشت', 'سرشانه', 'بازو', 'پشت‌بازو', 'جلو بازو',
  'چهارسر', 'پشت‌ران', 'باسن', 'ساق', 'شکمی', 'کمر',
  'ساعد', 'کول', 'ترپز', 'کل‌بدن',
];

export const EQUIPMENT_OPTIONS = [
  'بدون تجهیزات', 'هالتر', 'دمبل', 'ماشین', 'نیمکت', 'بارفیکس',
  'کتل‌بل', 'کش', 'دامبل', 'تی‌بار',
];

export const TAG_SUGGESTIONS = [
  'پایه', 'بالاتنه', 'پایین‌تنه', 'میان‌تنه', 'کل‌بدن',
  'بدون تجهیزات', 'هوازی', 'اصلاحی', 'کشش', 'موبیلیتی',
];

export interface Exercise {
  id: string;
  name_fa: string;
  name_en: string;
  primary_muscles: string[];
  secondary_muscles: string[];
  exercise_type: ExerciseType;
  equipment: string[];
  difficulty: ExerciseDifficulty;
  location: ExerciseLocation;
  instructions: string;
  tips: string;
  limitations: string;
  alternative_names: string;
  video_url: string;
  is_active: boolean;
  is_favorite: boolean;
  tags: string[];
  coach_notes: string;
  created_at: string;
  updated_at: string;
}

export interface TemplateExercise {
  id: string;
  template_id: string;
  exercise_id: string;
  sort_order: number;
  sets: number | null;
  reps: string;
  rest_seconds: number | null;
  rpe: number | null;
  day_label: string;
  coach_notes: string;
  created_at: string;
}

export interface ProgramExercise {
  id: string;
  program_id: string;
  exercise_id: string;
  source_template_id: string | null;
  sort_order: number;
  sets: number | null;
  reps: string;
  rest_seconds: number | null;
  rpe: number | null;
  day_label: string;
  coach_notes: string;
  exercise_name_fa: string;
  exercise_name_en: string;
  exercise_video_url: string;
  created_at: string;
}

export function formatExerciseName(e: { name_fa: string; name_en: string }): string {
  if (e.name_fa && e.name_en) return `${e.name_fa} (${e.name_en})`;
  return e.name_fa || e.name_en || '';
}

export function extractDriveFileId(url: string): string | null {
  if (!url) return null;
  const patterns = [
    /\/file\/d\/([a-zA-Z0-9-_]+)/,
    /[?&]id=([a-zA-Z0-9-_]+)/,
    /\/d\/([a-zA-Z0-9-_]+)/,
  ];
  for (const p of patterns) {
    const m = url.match(p);
    if (m) return m[1];
  }
  return null;
}

export function getEmbedUrl(url: string): string | null {
  const fileId = extractDriveFileId(url);
  if (fileId) return `https://drive.google.com/file/d/${fileId}/preview`;
  if (url.includes('youtube.com/watch?v=') || url.includes('youtu.be/')) {
    const ytId = url.match(/(?:watch\?v=|youtu\.be\/)([a-zA-Z0-9-_]+)/)?.[1];
    if (ytId) return `https://www.youtube.com/embed/${ytId}`;
  }
  // Direct video file links (mp4, webm, mov, m4v, ogg)
  if (/^https?:\/\/.+\.(mp4|webm|mov|m4v|ogg)(\?.*)?$/i.test(url)) return url;
  // Vimeo share links
  const vimeoId = url.match(/vimeo\.com\/(\d+)/)?.[1];
  if (vimeoId) return `https://player.vimeo.com/video/${vimeoId}`;
  // Other http(s) links: only embed if clearly an embeddable player URL
  if (/\/(?:embed|player)\//i.test(url)) return url;
  return null;
}

// --- Timezone helper (Asia/Tehran) ---
export const TEHRAN_TZ = 'Asia/Tehran';

export function todayInTehran(): string {
  return new Date().toLocaleDateString('en-CA', { timeZone: TEHRAN_TZ });
}

export function dateInTehran(d: Date): string {
  return d.toLocaleDateString('en-CA', { timeZone: TEHRAN_TZ });
}

export function addDaysISO(dateStr: string, days: number): string {
  const d = new Date(dateStr + 'T00:00:00');
  d.setDate(d.getDate() + days);
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${y}-${m}-${day}`;
}

// --- Diet structured data ---

export interface DietTemplateMeal {
  id: string;
  template_id: string;
  sort_order: number;
  name: string;
  notes: string;
  fasting_start: string;
  fasting_end: string;
  created_at: string;
}

export interface DietTemplateFoodItem {
  id: string;
  meal_id: string;
  sort_order: number;
  name: string;
  amount: string;
  unit: string;
  is_raw: boolean | null;
  alternatives: string;
  notes: string;
  created_at: string;
}

export interface DietProgramMeal {
  id: string;
  program_id: string;
  source_template_id: string | null;
  sort_order: number;
  name: string;
  notes: string;
  fasting_start: string;
  fasting_end: string;
  created_at: string;
}

export interface DietProgramFoodItem {
  id: string;
  meal_id: string;
  sort_order: number;
  name: string;
  amount: string;
  unit: string;
  is_raw: boolean | null;
  alternatives: string;
  notes: string;
  created_at: string;
}

export type DietTipCategory =
  | 'daily'
  | 'fasting'
  | 'flex_meal'
  | 'restaurant'
  | 'travel'
  | 'sick_day'
  | 'maintenance'
  | 'relapse'
  | 'custom';

export const DIET_TIP_CATEGORY_LABELS: Record<DietTipCategory, string> = {
  daily: 'نکات روزانه',
  fasting: 'نکات فستینگ',
  flex_meal: 'وعده انعطاف‌پذیر',
  restaurant: 'رستوران و مهمانی',
  travel: 'سفر',
  sick_day: 'روز بیماری',
  maintenance: 'کالری تثبیت',
  relapse: 'خروج از برنامه',
  custom: 'سایر',
};

export interface DietTip {
  id: string;
  category: string;
  title: string;
  body: string;
  is_active: boolean;
  sort_order: number;
  created_at: string;
}

export type DietTipPdfMode = 'full' | 'tips_only' | 'none';

export interface DietProgramTip {
  id: string;
  program_id: string;
  tip_id: string | null;
  custom_text: string;
  sort_order: number;
  pdf_mode: DietTipPdfMode;
  created_at: string;
}

export const DIET_PATTERNS = [
  'معمولی و انعطاف‌پذیر',
  'فستینگ متناوب',
  'کربوسایکلینگ',
  'رژیم اقتصادی',
  'پروتئین بالا',
  'کالری تثبیت',
  'سفارشی',
] as const;

export function daysBetween(from: string, to: string): number {
  const a = new Date(from + 'T00:00:00');
  const b = new Date(to + 'T00:00:00');
  return Math.round((b.getTime() - a.getTime()) / 86400000);
}

// ── Food Bank ──
export type FoodCategory =
  | 'grain' | 'protein' | 'vegetable' | 'fruit'
  | 'dairy' | 'fat' | 'bread' | 'snack' | 'beverage' | 'other';

export const FOOD_CATEGORY_LABELS: Record<FoodCategory, string> = {
  grain: 'غلات و برنج',
  protein: 'پروتئین',
  vegetable: 'سبزیجات',
  fruit: 'میوه',
  dairy: 'لبنیات',
  fat: 'چربی',
  bread: 'نان',
  snack: 'میان‌وعده',
  beverage: 'نوشیدنی',
  other: 'سایر',
};

export interface Food {
  id: string;
  name: string;
  category: FoodCategory;
  calories_per_100g: number | null;
  protein_per_100g: number | null;
  carbs_per_100g: number | null;
  fat_per_100g: number | null;
  default_unit: string;
  household_unit: string | null;
  household_unit_grams: number | null;
  is_raw: boolean;
  notes: string;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

// ── Student Favorite Foods ──
export type FavoriteFoodCategory =
  | 'breakfast' | 'lunch' | 'dinner' | 'snack' | 'pre_workout' | 'post_workout';

export const FAVORITE_FOOD_CATEGORY_LABELS: Record<FavoriteFoodCategory, string> = {
  breakfast: 'صبحانه',
  lunch: 'ناهار',
  dinner: 'شام',
  snack: 'میان‌وعده',
  pre_workout: 'قبل تمرین',
  post_workout: 'بعد تمرین',
};

export interface StudentFavoriteFood {
  id: string;
  student_id: string;
  category: FavoriteFoodCategory;
  food_name: string;
  food_id: string | null;
  sort_order: number;
  created_at: string;
}

// ── Food Substitution Groups ──
export interface FoodSubstitutionGroup {
  id: string;
  name: string;
  sort_order: number;
  created_at: string;
}

export interface FoodSubstitutionItem {
  id: string;
  group_id: string;
  food_name: string;
  amount: string;
  unit: string;
  equivalent_note: string;
  sort_order: number;
  created_at: string;
}

// ── Weekly Diet Program ──
export type DayOfWeek = 'شنبه' | 'یکشنبه' | 'دوشنبه' | 'سه‌شنبه' | 'چهارشنبه' | 'پنجشنبه' | 'جمعه';
export type MealType = 'breakfast' | 'lunch' | 'dinner' | 'snack' | 'pre_workout' | 'post_workout';

export const DAY_OF_WEEK_LABELS: DayOfWeek[] = ['شنبه', 'یکشنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنجشنبه', 'جمعه'];

export const MEAL_TYPE_LABELS: Record<MealType, string> = {
  breakfast: 'صبحانه',
  lunch: 'ناهار',
  dinner: 'شام',
  snack: 'میان‌وعده',
  pre_workout: 'قبل تمرین',
  post_workout: 'بعد تمرین',
};

export interface WeeklyDietProgram {
  id: string;
  program_id: string;
  is_active: boolean;
  notes: string;
  created_at: string;
  updated_at: string;
}

export interface WeeklyDietMeal {
  id: string;
  weekly_program_id: string;
  day_of_week: DayOfWeek;
  meal_type: MealType;
  meal_name: string;
  sort_order: number;
  is_active: boolean;
  notes: string;
  created_at: string;
}

export interface WeeklyDietFoodItem {
  id: string;
  weekly_meal_id: string;
  sort_order: number;
  food_id: string | null;
  name: string;
  amount: string;
  unit: string;
  household_unit: string;
  household_grams: number | null;
  is_raw: boolean;
  calories: number | null;
  protein_g: number | null;
  notes: string;
  created_at: string;
}

// ── Meal Substitutions ──
export interface MealSubstitution {
  id: string;
  weekly_meal_id: string;
  substitution_name: string;
  sort_order: number;
  notes: string;
  created_at: string;
}

export interface MealSubstitutionFoodItem {
  id: string;
  substitution_id: string;
  sort_order: number;
  food_id: string | null;
  name: string;
  amount: string;
  unit: string;
  household_unit: string;
  household_grams: number | null;
  is_raw: boolean;
  calories: number | null;
  protein_g: number | null;
  notes: string;
  created_at: string;
}

// ── Cheat Meal ──
export interface CheatMealConfig {
  id: string;
  program_id: string;
  is_enabled: boolean;
  food_name: string;
  amount: string;
  placement: string;
  notes: string;
  created_at: string;
  updated_at: string;
}

// ── Progress Reports (biweekly) ──
export type AdherenceLevel = '' | 'ضعیف' | 'متوسط' | 'خوب' | 'عالی';

export interface ProgressReport {
  id: string;
  student_id: string;
  report_date: string;
  period_label: string;
  weight_kg: number | null;
  diet_adherence: string;
  workout_adherence: string;
  hunger_level: string;
  energy_level: string;
  sleep_quality: string;
  workout_performance: string;
  pain_issues: string;
  student_notes: string;
  coach_private_notes: string;
  report_link_id: string | null;
  created_at: string;
}

// ── Progress Evaluations (monthly) ──
export interface ProgressEvaluation {
  id: string;
  student_id: string;
  evaluation_date: string;
  period_label: string;
  weight_kg: number | null;
  waist_cm: number | null;
  hip_cm: number | null;
  chest_cm: number | null;
  thigh_cm: number | null;
  arm_cm: number | null;
  notes: string;
  report_link_id: string | null;
  created_at: string;
}

// ── Progress Photos ──
export interface ProgressPhoto {
  id: string;
  evaluation_id: string;
  photo_type: string;
  storage_path: string;
  public_url: string;
  sort_order: number;
  created_at: string;
}

// ── Report Links ──
export type ReportLinkStatus = 'active' | 'used' | 'expired' | 'revoked';

export const REPORT_LINK_STATUS_LABELS: Record<ReportLinkStatus, string> = {
  active: 'فعال',
  used: 'استفاده‌شده',
  expired: 'منقضی',
  revoked: 'لغوشده',
};

export const REPORT_LINK_STATUS_COLORS: Record<ReportLinkStatus, string> = {
  active: 'bg-emerald-50 text-emerald-700',
  used: 'bg-blue-50 text-blue-700',
  expired: 'bg-gray-100 text-gray-500',
  revoked: 'bg-red-50 text-red-700',
};

export interface ReportLink {
  id: string;
  student_id: string;
  token: string;
  link_type: string;
  due_date: string | null;
  status: ReportLinkStatus;
  title: string;
  created_at: string;
  expires_at: string | null;
  used_at: string | null;
}

// ── Corrective Issues ──
export interface CorrectiveIssue {
  id: string;
  name_fa: string;
  name_en: string;
  description: string;
  suggested_tags: string[];
  is_active: boolean;
  sort_order: number;
  created_at: string;
}

export interface CorrectiveIssueExercise {
  id: string;
  issue_id: string;
  exercise_id: string;
  sort_order: number;
  created_at: string;
}

// ── Guides ──
export type GuideCategory = 'food' | 'general';

export interface Guide {
  id: string;
  slug: string;
  title: string;
  category: GuideCategory;
  content: string;
  is_active: boolean;
  sort_order: number;
  created_at: string;
  updated_at: string;
}
