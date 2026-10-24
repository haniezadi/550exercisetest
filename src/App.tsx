import { useCallback, useEffect, useMemo, useState } from 'react';
import {
  Dumbbell,
  LayoutDashboard,
  Plus,
  Search,
  Users,
  Apple,
  Trash2,
  Pencil,
  ArrowRight,
  Target,
  Calendar,
  ClipboardList,
  Loader2,
  FileDown,
  Inbox,
  LogOut,
  Bell,
  Ruler,
  RefreshCw,
  CreditCard,
  TrendingUp,
  Star,
  PlayCircle,
  ExternalLink,
  Lightbulb,
  FilterX,
} from 'lucide-react';
import { supabase, supabaseConfigured, todayInTehran, daysBetween, addDaysISO, getEmbedUrl } from '@/lib/supabase';
import type {
  Student,
  Template,
  AssignedProgram,
  IntakeRequest,
  StudentPlan,
  Measurement,
  Reminder,
  PlanType,
  PaymentStatus,
  Exercise,
  TemplateExercise,
  ProgramExercise,
  DietTemplateMeal,
  DietProgramMeal,
  DietProgramFoodItem,
  DietProgramTip,
  DietTip,
} from '@/lib/supabase';
import { DIET_TIP_CATEGORY_LABELS, type DietTipCategory } from '@/lib/supabase';
import {
  PLAN_TYPE_LABELS as PLAN_LABELS,
  PAYMENT_STATUS_LABELS as PAY_LABELS,
  PAYMENT_STATUS_COLORS as PAY_COLORS,
  PLAN_STATUS_LABELS as STATUS_LABELS,
  PLAN_STATUS_COLORS as STATUS_COLORS,
} from '@/lib/supabase';
import { useAuth } from '@/lib/auth';
import Modal from '@/components/Modal';
import StudentForm, { type StudentFormValues } from '@/components/StudentForm';
import WorkoutProgramModal, { type WorkoutSaveData } from '@/components/WorkoutProgramModal';
import DietProgramModal, { type DietSaveData } from '@/components/DietProgramModal';
import PlanForm, { type PlanFormValues } from '@/components/PlanForm';
import MeasurementForm, { type MeasurementFormValues } from '@/components/MeasurementForm';
import ExerciseForm, { type ExerciseFormValues } from '@/components/ExerciseForm';
import ExerciseBankView from '@/components/ExerciseBankView';
import ExerciseDetail from '@/components/ExerciseDetail';
import { type ExerciseAssignment } from '@/components/ExerciseListEditor';
import LoginScreen from '@/components/LoginScreen';
import IntakeForm from '@/components/IntakeForm';
import RequestsView from '@/components/RequestsView';
import RemindersView from '@/components/RemindersView';
import TemplateEditor from '@/components/TemplateEditor';
import PrintLayout, { type PrintMode } from '@/components/PrintLayout';
import StudentStatsCards, {
  type StudentStatFilter,
  filterStudentsByStat,
  type MultiFilter,
  type PlanStatusFilter,
  type PaymentFilter,
  type ProgramStatusFilter,
  type RequestStageFilter,
  type StudentSort,
  DEFAULT_MULTI_FILTER,
  hasActiveMultiFilter,
  applyMultiFilter,
} from '@/components/StudentStatsCards';
import { syncReminders, createNextMeasurementReminder, dismissOldRenewalReminders } from '@/lib/reminders';
import { formatJalaliShort, formatJalaliLong, formatJalaliDateTime, normalizePersianText } from '@/lib/jalali';

type View = 'dashboard' | 'students' | 'templates' | 'requests' | 'reminders' | 'exercises';

function useHashRoute(): [string, (h: string) => void] {
  const [hash, setHash] = useState(() => window.location.hash.replace(/^#/, '') || '/');
  useEffect(() => {
    const onChange = () => setHash(window.location.hash.replace(/^#/, '') || '/');
    window.addEventListener('hashchange', onChange);
    return () => window.removeEventListener('hashchange', onChange);
  }, []);
  const navigate = (h: string) => {
    window.location.hash = h;
  };
  return [hash, navigate];
}

export default function App() {
  const [hash, navigate] = useHashRoute();
  const { session, loading: authLoading, signOut } = useAuth();

  // Public form route: #/form
  if (hash === '/form') {
    if (!supabaseConfigured) return <ConfigErrorScreen />;
    return <IntakeForm />;
  }

  // Missing Supabase configuration — show a clear message instead of crashing to a black screen.
  if (!supabaseConfigured) {
    return <ConfigErrorScreen />;
  }

  // Coach panel — requires auth
  if (authLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center text-gray-400">
        <Loader2 className="animate-spin" size={28} />
      </div>
    );
  }

  if (!session) {
    return <LoginScreen />;
  }

  return <CoachPanel onSignOut={signOut} />;
}

function ConfigErrorScreen() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-[#f6f7f9] p-4" dir="rtl">
      <div className="max-w-md w-full bg-white rounded-2xl border border-red-100 shadow-card p-8 text-center">
        <div className="mx-auto flex h-14 w-14 items-center justify-center rounded-full bg-red-50 text-red-600">
          <Loader2 className="animate-spin" size={26} />
        </div>
        <h1 className="mt-5 text-lg font-bold text-gray-800">پیکربندی ناقص است</h1>
        <p className="mt-2 text-sm text-gray-500 leading-7">
          متغیرهای محیطی Supabase در دسترس نیستند. لطفاً مطمئن شو فایل <span dir="ltr">.env</span> در مسیر پروژه موجود است و کلیدهای <span dir="ltr">VITE_SUPABASE_URL</span> و <span dir="ltr">VITE_SUPABASE_ANON_KEY</span> در آن تعریف شده‌اند، سپس پیش‌نمایش را هارد‌ریفرش کنید.
        </p>
      </div>
    </div>
  );
}

function CoachPanel({ onSignOut }: { onSignOut: () => void }) {
  const [view, setView] = useState<View>('dashboard');
  const [students, setStudents] = useState<Student[]>([]);
  const [templates, setTemplates] = useState<Template[]>([]);
  const [programs, setPrograms] = useState<AssignedProgram[]>([]);
  const [requests, setRequests] = useState<IntakeRequest[]>([]);
  const [plans, setPlans] = useState<StudentPlan[]>([]);
  const [measurements, setMeasurements] = useState<Measurement[]>([]);
  const [reminders, setReminders] = useState<Reminder[]>([]);
  const [exercises, setExercises] = useState<Exercise[]>([]);
  const [templateExercises, setTemplateExercises] = useState<TemplateExercise[]>([]);
  const [programExercises, setProgramExercises] = useState<ProgramExercise[]>([]);
  const [dietTemplateMeals, setDietTemplateMeals] = useState<DietTemplateMeal[]>([]);
  const [dietProgramMeals, setDietProgramMeals] = useState<DietProgramMeal[]>([]);
  const [dietProgramFoodItems, setDietProgramFoodItems] = useState<DietProgramFoodItem[]>([]);
  const [dietProgramTips, setDietProgramTips] = useState<DietProgramTip[]>([]);
  const [dietTips, setDietTips] = useState<DietTip[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // modal state
  const [studentModalOpen, setStudentModalOpen] = useState(false);
  const [editingStudent, setEditingStudent] = useState<Student | null>(null);
  const [detailStudent, setDetailStudent] = useState<Student | null>(null);
  const [workoutModalOpen, setWorkoutModalOpen] = useState(false);
  const [dietModalOpen, setDietModalOpen] = useState(false);
  const [planModalOpen, setPlanModalOpen] = useState(false);
  const [editingPlan, setEditingPlan] = useState<StudentPlan | null>(null);
  const [measurementModalOpen, setMeasurementModalOpen] = useState(false);
  const [exerciseModalOpen, setExerciseModalOpen] = useState(false);
  const [editingExercise, setEditingExercise] = useState<Exercise | null>(null);
  const [viewingExercise, setViewingExercise] = useState<Exercise | null>(null);
  const [deleteExerciseTarget, setDeleteExerciseTarget] = useState<Exercise | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<Student | null>(null);
  const [saving, setSaving] = useState(false);
  const [printMode, setPrintMode] = useState<PrintMode | null>(null);

  // Full initial load — runs once on mount. Fetches everything.
  const loadData = useCallback(async () => {
    setLoading(true);
    setError(null);
    const [studentsRes, templatesRes, programsRes, requestsRes, plansRes, measurementsRes, remindersRes, exercisesRes, templateExRes, programExRes, dtmRes, dpmRes, dpfRes, dptRes, dtipsRes] = await Promise.all([
      supabase.from('students').select('*').order('created_at', { ascending: false }),
      supabase.from('templates').select('*').order('type, created_at'),
      supabase.from('assigned_programs').select('*'),
      supabase.from('intake_requests').select('*').order('created_at', { ascending: false }),
      supabase.from('student_plans').select('*').order('created_at', { ascending: false }),
      supabase.from('measurements').select('*').order('recorded_at', { ascending: false }),
      supabase.from('reminders').select('*').order('due_date', { ascending: true }),
      supabase.from('exercises').select('*').order('created_at', { ascending: false }),
      supabase.from('template_exercises').select('*').order('sort_order'),
      supabase.from('program_exercises').select('*').order('sort_order'),
      supabase.from('diet_template_meals').select('*').order('sort_order'),
      supabase.from('diet_program_meals').select('*').order('sort_order'),
      supabase.from('diet_program_food_items').select('*').order('sort_order'),
      supabase.from('diet_program_tips').select('*').order('sort_order'),
      supabase.from('diet_tips').select('*').order('sort_order'),
    ]);
    if (studentsRes.error || templatesRes.error || programsRes.error || requestsRes.error || plansRes.error || measurementsRes.error || remindersRes.error || exercisesRes.error || templateExRes.error || programExRes.error || dtmRes.error || dpmRes.error || dpfRes.error || dptRes.error || dtipsRes.error) {
      setError('خطا در بارگذاری اطلاعات از دیتابیس');
      setLoading(false);
      return;
    }
    setStudents(studentsRes.data ?? []);
    setTemplates(templatesRes.data ?? []);
    setPrograms(programsRes.data ?? []);
    setRequests((requestsRes.data ?? []) as IntakeRequest[]);
    setPlans((plansRes.data ?? []) as StudentPlan[]);
    setMeasurements((measurementsRes.data ?? []) as Measurement[]);
    setReminders((remindersRes.data ?? []) as Reminder[]);
    setExercises((exercisesRes.data ?? []) as Exercise[]);
    setTemplateExercises((templateExRes.data ?? []) as TemplateExercise[]);
    setProgramExercises((programExRes.data ?? []) as ProgramExercise[]);
    setDietTemplateMeals((dtmRes.data ?? []) as DietTemplateMeal[]);
    setDietProgramMeals((dpmRes.data ?? []) as DietProgramMeal[]);
    setDietProgramFoodItems((dpfRes.data ?? []) as DietProgramFoodItem[]);
    setDietProgramTips((dptRes.data ?? []) as DietProgramTip[]);
    setDietTips((dtipsRes.data ?? []) as DietTip[]);
    setLoading(false);
  }, []);

  // Targeted refresh helpers — re-fetch only the affected table(s) after a
  // mutation, so a single save does NOT trigger 10 parallel queries.
  const refreshStudents = useCallback(async () => {
    const r = await supabase.from('students').select('*').order('created_at', { ascending: false });
    if (!r.error) setStudents(r.data ?? []);
  }, []);
  const refreshProgramsAndExercises = useCallback(async () => {
    const [pRes, peRes, dpmRes, dpfRes, dptRes, dtmRes] = await Promise.all([
      supabase.from('assigned_programs').select('*'),
      supabase.from('program_exercises').select('*').order('sort_order'),
      supabase.from('diet_program_meals').select('*').order('sort_order'),
      supabase.from('diet_program_food_items').select('*').order('sort_order'),
      supabase.from('diet_program_tips').select('*').order('sort_order'),
      supabase.from('diet_template_meals').select('*').order('sort_order'),
    ]);
    if (!pRes.error) setPrograms(pRes.data ?? []);
    if (!peRes.error) setProgramExercises((peRes.data ?? []) as ProgramExercise[]);
    if (!dpmRes.error) setDietProgramMeals((dpmRes.data ?? []) as DietProgramMeal[]);
    if (!dpfRes.error) setDietProgramFoodItems((dpfRes.data ?? []) as DietProgramFoodItem[]);
    if (!dptRes.error) setDietProgramTips((dptRes.data ?? []) as DietProgramTip[]);
    if (!dtmRes.error) setDietTemplateMeals((dtmRes.data ?? []) as DietTemplateMeal[]);
  }, []);
  const refreshPlans = useCallback(async () => {
    const r = await supabase.from('student_plans').select('*').order('created_at', { ascending: false });
    if (!r.error) setPlans((r.data ?? []) as StudentPlan[]);
  }, []);
  const refreshMeasurements = useCallback(async () => {
    const r = await supabase.from('measurements').select('*').order('recorded_at', { ascending: false });
    if (!r.error) setMeasurements((r.data ?? []) as Measurement[]);
  }, []);
  const refreshReminders = useCallback(async () => {
    const r = await supabase.from('reminders').select('*').order('due_date', { ascending: true });
    if (!r.error) setReminders((r.data ?? []) as Reminder[]);
  }, []);
  const refreshExercises = useCallback(async () => {
    const r = await supabase.from('exercises').select('*').order('created_at', { ascending: false });
    if (!r.error) setExercises((r.data ?? []) as Exercise[]);
  }, []);
  const refreshRequests = useCallback(async () => {
    const r = await supabase.from('intake_requests').select('*').order('created_at', { ascending: false });
    if (!r.error) setRequests((r.data ?? []) as IntakeRequest[]);
  }, []);
  const refreshPlansAndReminders = useCallback(async () => {
    await Promise.all([refreshPlans(), refreshReminders()]);
  }, [refreshPlans, refreshReminders]);

  useEffect(() => {
    (async () => {
      await loadData();
    })();
  }, [loadData]);

  // Sync reminders once after initial load (not on every loadData cycle)
  const [remindersSynced, setRemindersSynced] = useState(false);

  useEffect(() => {
    if (!loading && !remindersSynced) {
      (async () => {
        await syncReminders(students, plans, measurements);
        await refreshReminders();
        setRemindersSynced(true);
      })();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [loading, remindersSynced]);

  const programsByStudent = useMemo(() => {
    const map = new Map<string, AssignedProgram>();
    for (const p of programs) map.set(p.student_id, p);
    return map;
  }, [programs]);

  // --- student CRUD ---
  const openAddStudent = () => {
    setEditingStudent(null);
    setStudentModalOpen(true);
  };
  const openEditStudent = (s: Student) => {
    setEditingStudent(s);
    setStudentModalOpen(true);
  };

  const handleStudentSubmit = async (vals: StudentFormValues) => {
    setSaving(true);
    const payload = {
      name: vals.name.trim(),
      age: vals.age ? Number(vals.age) : null,
      height_cm: vals.height_cm ? Number(vals.height_cm) : null,
      weight_kg: vals.weight_kg ? Number(vals.weight_kg) : null,
      goal: vals.goal.trim() || null,
      phone: vals.phone.trim() || null,
      birth_date: vals.birth_date || null,
      coach_notes: vals.coach_notes.trim(),
    };
    let result;
    if (editingStudent) {
      result = await supabase
        .from('students')
        .update(payload)
        .eq('id', editingStudent.id)
        .select()
        .single();
    } else {
      result = await supabase.from('students').insert(payload).select().single();
    }
    setSaving(false);
    if (result.error) {
      setError('ذخیرهٔ شاگرد ناموفق بود');
      return;
    }
    setStudentModalOpen(false);
    setEditingStudent(null);
    await refreshStudents();
  };

  const handleDeleteStudent = async () => {
    if (!deleteTarget) return;
    setSaving(true);
    const { error: delErr } = await supabase
      .from('students')
      .delete()
      .eq('id', deleteTarget.id);
    setSaving(false);
    if (delErr) {
      setError('حذف شاگرد ناموفق بود');
      return;
    }
    setDeleteTarget(null);
    if (detailStudent?.id === deleteTarget.id) setDetailStudent(null);
    await Promise.all([refreshStudents(), refreshProgramsAndExercises(), refreshPlansAndReminders(), refreshMeasurements()]);
  };

  // --- program assignment ---
  const programForDetail = detailStudent
    ? programsByStudent.get(detailStudent.id) ?? null
    : null;

  // Ensure a program row exists for the student, returns the program id
  const ensureProgramRow = async (): Promise<string | null> => {
    if (!detailStudent) return null;
    const existing = programForDetail;
    if (existing) return existing.id;
    const { data, error } = await supabase
      .from('assigned_programs')
      .insert({
        student_id: detailStudent.id,
        workout_template_id: null,
        diet_template_id: null,
        custom_name: '',
        custom_description: '',
      })
      .select()
      .single();
    if (error || !data) {
      setError('ایجاد برنامه ناموفق بود');
      return null;
    }
    return data.id;
  };

  const handleWorkoutSave = async (data: WorkoutSaveData) => {
    if (!detailStudent) return;
    setSaving(true);
    const programId = await ensureProgramRow();
    if (!programId) { setSaving(false); return; }
    const workoutStatus = data.assignments.length > 0 ? 'completed' : 'none';
    const { error: updErr } = await supabase
      .from('assigned_programs')
      .update({
        workout_template_id: null,
        custom_name: data.customName,
        workout_status: workoutStatus,
        updated_at: new Date().toISOString(),
      })
      .eq('id', programId);
    if (updErr) {
      setSaving(false);
      setError('ذخیرهٔ برنامه تمرینی ناموفق بود');
      return;
    }
    await supabase.from('program_exercises').delete().eq('program_id', programId);
    if (data.assignments.length > 0) {
      const exRows = data.assignments.map((a, i) => ({
        program_id: programId,
        exercise_id: a.exercise_id,
        source_template_id: a.source_template_id ?? null,
        sort_order: i,
        sets: a.sets ? Number(a.sets) : null,
        reps: a.reps.trim(),
        rest_seconds: a.rest_seconds ? Number(a.rest_seconds) : null,
        rpe: a.rpe ? Number(a.rpe) : null,
        day_label: a.day_label.trim(),
        coach_notes: a.coach_notes.trim(),
        exercise_name_fa: a.exercise_name_fa,
        exercise_name_en: a.exercise_name_en,
        exercise_video_url: a.exercise_video_url,
      }));
      const { error: exInsErr } = await supabase.from('program_exercises').insert(exRows);
      if (exInsErr) {
        setSaving(false);
        setError('ذخیرهٔ حرکات برنامه ناموفق بود');
        return;
      }
    }
    setSaving(false);
    setWorkoutModalOpen(false);
    await refreshProgramsAndExercises();
  };

  const handleDietSave = async (data: DietSaveData) => {
    if (!detailStudent) return;
    setSaving(true);
    const programId = await ensureProgramRow();
    if (!programId) { setSaving(false); return; }
    const hasContent = data.description || data.meals.length > 0 || data.tips.length > 0 || data.targetCalories || data.targetProteinG;
    const dietStatus = hasContent ? 'completed' : (data.templateId ? 'draft' : 'none');
    const { error: updErr } = await supabase
      .from('assigned_programs')
      .update({
        diet_template_id: data.templateId,
        custom_description: data.description,
        diet_status: dietStatus,
        diet_target_calories: data.targetCalories,
        diet_target_protein_g: data.targetProteinG,
        diet_pattern: data.pattern,
        updated_at: new Date().toISOString(),
      })
      .eq('id', programId);
    if (updErr) {
      setSaving(false);
      setError('ذخیرهٔ برنامه غذایی ناموفق بود');
      return;
    }
    // Replace diet program meals + food items + tips (delete then re-insert)
    await supabase.from('diet_program_meals').delete().eq('program_id', programId);
    await supabase.from('diet_program_tips').delete().eq('program_id', programId);
    for (let mi = 0; mi < data.meals.length; mi++) {
      const meal = data.meals[mi];
      const { data: mealRow, error: mealErr } = await supabase
        .from('diet_program_meals')
        .insert({
          program_id: programId,
          source_template_id: data.templateId,
          sort_order: mi,
          name: meal.name.trim(),
          notes: meal.notes.trim(),
          fasting_start: meal.fasting_start.trim(),
          fasting_end: meal.fasting_end.trim(),
        })
        .select()
        .single();
      if (mealErr || !mealRow) continue;
      const foodRows = meal.foodItems.map((f, fi) => ({
        meal_id: mealRow.id,
        sort_order: fi,
        name: f.name.trim(),
        amount: f.amount.trim(),
        unit: f.unit.trim(),
        is_raw: f.is_raw,
        alternatives: f.alternatives.trim(),
        notes: f.notes.trim(),
      }));
      if (foodRows.length > 0) {
        await supabase.from('diet_program_food_items').insert(foodRows);
      }
    }
    const tipRows = data.tips.map((t, ti) => ({
      program_id: programId,
      tip_id: t.tip_id,
      custom_text: t.custom_text.trim(),
      sort_order: ti,
      pdf_mode: t.pdf_mode ?? 'full',
    }));
    if (tipRows.length > 0) {
      await supabase.from('diet_program_tips').insert(tipRows);
    }
    setSaving(false);
    setDietModalOpen(false);
    await refreshProgramsAndExercises();
  };

  const templateById = useMemo(() => {
    const map = new Map<string, Template>();
    for (const t of templates) map.set(t.id, t);
    return map;
  }, [templates]);

  // --- search & stat filter ---
  const [query, setQuery] = useState('');
  const [statFilter, setStatFilter] = useState<StudentStatFilter>('all');
  const [multiFilter, setMultiFilter] = useState<MultiFilter>(DEFAULT_MULTI_FILTER);
  const filteredStudents = useMemo(() => {
    const q = normalizePersianText(query);
    const statIds = filterStudentsByStat(students, plans, programs, requests, statFilter);
    let list = students.filter((s) => statIds.has(s.id));
    if (q) {
      list = list.filter((s) => {
        const name = normalizePersianText(s.name);
        const phone = s.phone ? normalizePersianText(s.phone) : '';
        const goal = s.goal ? normalizePersianText(s.goal) : '';
        return name.includes(q) || phone.includes(q) || goal.includes(q);
      });
    }
    // Apply multi-filter dimensions (AND-combined with stat filter + search)
    list = applyMultiFilter(list, plans, programs, requests, multiFilter);
    return list;
  }, [students, plans, programs, requests, query, statFilter, multiFilter]);

  const workoutTemplates = templates.filter((t) => t.type === 'workout');
  const dietTemplates = templates.filter((t) => t.type === 'diet');

  const newRequestsCount = requests.filter((r) => r.status === 'new').length;
  const todayStr = todayInTehran();
  const todayRemindersCount = reminders.filter(
    (r) => r.status === 'pending' && r.due_date <= todayStr,
  ).length;

  // --- plan handlers ---
  const plansForStudent = useMemo(() => {
    const map = new Map<string, StudentPlan[]>();
    for (const p of plans) {
      const arr = map.get(p.student_id) ?? [];
      arr.push(p);
      map.set(p.student_id, arr);
    }
    return map;
  }, [plans]);

  const measurementsForStudent = useMemo(() => {
    const map = new Map<string, Measurement[]>();
    for (const m of measurements) {
      const arr = map.get(m.student_id) ?? [];
      arr.push(m);
      map.set(m.student_id, arr);
    }
    return map;
  }, [measurements]);

  const openAddPlan = () => {
    setEditingPlan(null);
    setPlanModalOpen(true);
  };
  const openEditPlan = (p: StudentPlan) => {
    setEditingPlan(p);
    setPlanModalOpen(true);
  };

  const handlePlanSubmit = async (vals: PlanFormValues) => {
    if (!detailStudent) return;
    setSaving(true);
    const payload = {
      student_id: detailStudent.id,
      plan_type: vals.plan_type,
      custom_type_label: vals.custom_type_label.trim(),
      start_date: vals.start_date,
      end_date: vals.end_date,
      amount: vals.amount ? Number(vals.amount) : 0,
      payment_status: vals.payment_status,
      notes: vals.notes.trim(),
    };
    let result;
    if (editingPlan) {
      result = await supabase
        .from('student_plans')
        .update({ ...payload, updated_at: new Date().toISOString() })
        .eq('id', editingPlan.id)
        .select()
        .single();
    } else {
      result = await supabase
        .from('student_plans')
        .insert(payload)
        .select()
        .single();
    }
    setSaving(false);
    if (result.error) {
      setError('ذخیرهٔ پلن ناموفق بود');
      return;
    }
    setPlanModalOpen(false);
    setEditingPlan(null);
    await refreshPlansAndReminders();
  };

  const handleRenewPlan = async (plan: StudentPlan) => {
    if (!detailStudent) return;
    setSaving(true);
    // Mark old plan as renewed
    await supabase
      .from('student_plans')
      .update({ plan_status: 'renewed', updated_at: new Date().toISOString() })
      .eq('id', plan.id);
    // Dismiss old renewal reminders
    await dismissOldRenewalReminders(plan.id);
    // Create new plan with same type, shifted dates
    const newStart = todayInTehran();
    const oldDuration = daysBetween(plan.start_date, plan.end_date);
    const newEnd = addDaysISO(newStart, oldDuration > 0 ? oldDuration : 30);
    const { error: insertErr } = await supabase.from('student_plans').insert({
      student_id: detailStudent.id,
      plan_type: plan.plan_type,
      custom_type_label: plan.custom_type_label,
      start_date: newStart,
      end_date: newEnd,
      amount: plan.amount,
      payment_status: 'unpaid',
      plan_status: 'active',
      notes: `تمدید از پلن قبلی (${plan.start_date} تا ${plan.end_date})`,
    });
    setSaving(false);
    if (insertErr) {
      setError('تمدید پلن ناموفق بود');
      return;
    }
    await refreshPlansAndReminders();
  };

  // --- measurement handlers ---
  const handleMeasurementSubmit = async (vals: MeasurementFormValues) => {
    if (!detailStudent) return;
    setSaving(true);
    const payload = {
      student_id: detailStudent.id,
      recorded_at: vals.recorded_at,
      weight_kg: vals.weight_kg ? Number(vals.weight_kg) : null,
      waist_cm: vals.waist_cm ? Number(vals.waist_cm) : null,
      hip_cm: vals.hip_cm ? Number(vals.hip_cm) : null,
      chest_cm: vals.chest_cm ? Number(vals.chest_cm) : null,
      thigh_cm: vals.thigh_cm ? Number(vals.thigh_cm) : null,
      arm_cm: vals.arm_cm ? Number(vals.arm_cm) : null,
      notes: vals.notes.trim(),
    };
    const { error: insertErr } = await supabase.from('measurements').insert(payload);
    if (insertErr) {
      setSaving(false);
      setError('ثبت اندازه‌گیری ناموفق بود');
      return;
    }
    // Create next measurement reminder (14 days ahead) + mark old ones done
    await createNextMeasurementReminder(detailStudent.id, vals.recorded_at);
    setSaving(false);
    setMeasurementModalOpen(false);
    await Promise.all([refreshMeasurements(), refreshReminders()]);
  };

  // --- reminder handlers ---
  const handleMarkReminderDone = async (id: string) => {
    const { error: updErr } = await supabase
      .from('reminders')
      .update({ status: 'done', updated_at: new Date().toISOString() })
      .eq('id', id);
    if (updErr) {
      setError('به‌روزرسانی یادآور ناموفق بود');
      return;
    }
    await refreshReminders();
  };

  const handleOpenStudentFromReminder = (studentId: string) => {
    const s = students.find((x) => x.id === studentId);
    if (s) setDetailStudent(s);
  };

  // --- exercise handlers ---
  const exerciseDuplicateNames = useMemo(
    () => exercises.filter((e) => e.is_active).map((e) => `${e.name_fa}$${e.name_en}`),
    [exercises],
  );

  const openAddExercise = () => {
    setEditingExercise(null);
    setExerciseModalOpen(true);
  };
  const openEditExercise = (e: Exercise) => {
    setEditingExercise(e);
    setExerciseModalOpen(true);
  };

  const handleExerciseSubmit = async (vals: ExerciseFormValues) => {
    setSaving(true);
    const payload = {
      name_fa: vals.name_fa.trim(),
      name_en: vals.name_en.trim(),
      primary_muscles: vals.primary_muscles,
      secondary_muscles: vals.secondary_muscles,
      exercise_type: vals.exercise_type,
      equipment: vals.equipment,
      difficulty: vals.difficulty,
      location: vals.location,
      instructions: vals.instructions.trim(),
      tips: vals.tips.trim(),
      limitations: vals.limitations.trim(),
      alternative_names: vals.alternative_names.trim(),
      video_url: vals.video_url.trim(),
      is_active: vals.is_active,
      is_favorite: vals.is_favorite,
      tags: vals.tags,
      coach_notes: vals.coach_notes.trim(),
    };
    let result;
    if (editingExercise) {
      result = await supabase
        .from('exercises')
        .update({ ...payload, updated_at: new Date().toISOString() })
        .eq('id', editingExercise.id)
        .select()
        .single();
    } else {
      result = await supabase
        .from('exercises')
        .insert(payload)
        .select()
        .single();
    }
    setSaving(false);
    if (result.error) {
      setError('ذخیرهٔ حرکت ناموفق بود');
      return;
    }
    setExerciseModalOpen(false);
    setEditingExercise(null);
    await refreshExercises();
  };

  const handleToggleFavorite = async (e: Exercise) => {
    const { error: updErr } = await supabase
      .from('exercises')
      .update({ is_favorite: !e.is_favorite, updated_at: new Date().toISOString() })
      .eq('id', e.id);
    if (updErr) {
      setError('به‌روزرسانی حرکت ناموفق بود');
      return;
    }
    await refreshExercises();
  };

  const handleDeleteExercise = async () => {
    if (!deleteExerciseTarget) return;
    setSaving(true);
    const { error: delErr } = await supabase
      .from('exercises')
      .delete()
      .eq('id', deleteExerciseTarget.id);
    setSaving(false);
    if (delErr) {
      setError('حذف حرکت ناموفق بود');
      return;
    }
    setDeleteExerciseTarget(null);
    await refreshExercises();
  };

  // --- program exercise assignments ---
  const programExercisesForDetail = useMemo(() => {
    if (!programForDetail) return [];
    return programExercises.filter((pe) => pe.program_id === programForDetail.id);
  }, [programExercises, programForDetail]);

  const workoutAssignmentsForModal: ExerciseAssignment[] = programExercisesForDetail.map((pe) => ({
    id: pe.id,
    exercise_id: pe.exercise_id,
    exercise_name_fa: pe.exercise_name_fa,
    exercise_name_en: pe.exercise_name_en,
    exercise_video_url: pe.exercise_video_url,
    source_template_id: pe.source_template_id ?? null,
    sort_order: pe.sort_order,
    sets: pe.sets != null ? String(pe.sets) : '',
    reps: pe.reps,
    rest_seconds: pe.rest_seconds != null ? String(pe.rest_seconds) : '',
    rpe: pe.rpe != null ? String(pe.rpe) : '',
    day_label: pe.day_label || 'روز ۱',
    coach_notes: pe.coach_notes,
  }));

  // --- diet program data for detail view ---
  const dietMealsForDetail = useMemo(() => {
    if (!programForDetail) return [];
    return dietProgramMeals
      .filter((m) => m.program_id === programForDetail.id)
      .sort((a, b) => a.sort_order - b.sort_order);
  }, [dietProgramMeals, programForDetail]);

  const dietFoodItemsByMeal = useMemo(() => {
    const map = new Map<string, DietProgramFoodItem[]>();
    for (const f of dietProgramFoodItems) {
      const arr = map.get(f.meal_id) ?? [];
      arr.push(f);
      map.set(f.meal_id, arr);
    }
    for (const arr of map.values()) arr.sort((a, b) => a.sort_order - b.sort_order);
    return map;
  }, [dietProgramFoodItems]);

  const dietTipsForDetail = useMemo(() => {
    if (!programForDetail) return [];
    return dietProgramTips
      .filter((t) => t.program_id === programForDetail.id)
      .sort((a, b) => a.sort_order - b.sort_order);
  }, [dietProgramTips, programForDetail]);

  return (
    <div className="min-h-screen bg-[#f6f7f9] text-gray-800" dir="rtl">
      {/* Sidebar */}
      <aside className="no-print fixed inset-y-0 right-0 w-60 bg-white border-l border-gray-100 flex flex-col">
        <div className="px-5 py-6 border-b border-gray-100">
          <div className="flex items-center gap-2.5">
            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-brand-600 text-white">
              <Dumbbell size={20} />
            </div>
            <div>
              <h1 className="text-sm font-bold text-gray-800 leading-tight">
                پنل طراحی برنامه هانی ایزدی
              </h1>
              <p className="text-[11px] text-gray-400">طراحی برنامه تمرینی و غذایی</p>
            </div>
          </div>
        </div>
        <nav className="flex-1 px-3 py-4 flex flex-col gap-1">
          <NavItem
            icon={<LayoutDashboard size={18} />}
            label="داشبورد"
            active={view === 'dashboard'}
            onClick={() => setView('dashboard')}
          />
          <NavItem
            icon={<Inbox size={18} />}
            label="درخواست‌های جدید"
            badge={newRequestsCount > 0 ? newRequestsCount : undefined}
            active={view === 'requests'}
            onClick={() => setView('requests')}
          />
          <NavItem
            icon={<Users size={18} />}
            label="شاگردها"
            active={view === 'students' || !!detailStudent}
            onClick={() => {
              setDetailStudent(null);
              setView('students');
            }}
          />
          <NavItem
            icon={<Bell size={18} />}
            label="یادآورها"
            badge={todayRemindersCount > 0 ? todayRemindersCount : undefined}
            active={view === 'reminders'}
            onClick={() => setView('reminders')}
          />
          <NavItem
            icon={<Dumbbell size={18} />}
            label="بانک حرکات"
            active={view === 'exercises'}
            onClick={() => setView('exercises')}
          />
          <NavItem
            icon={<ClipboardList size={18} />}
            label="قالب‌های آماده"
            active={view === 'templates'}
            onClick={() => setView('templates')}
          />
        </nav>
        <div className="px-3 py-4 border-t border-gray-100">
          <button
            onClick={onSignOut}
            className="flex items-center gap-2 rounded-xl px-3.5 py-2.5 text-sm font-medium text-gray-500 hover:bg-gray-50 hover:text-gray-700 transition-colors w-full"
          >
            <LogOut size={16} />
            خروج از حساب
          </button>
        </div>
      </aside>

      {/* Main */}
      <main className="mr-60 min-h-screen">
        <div className="mx-auto max-w-5xl px-8 py-8">
          {error && (
            <div className="mb-4 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 flex items-center justify-between">
              <span>{error}</span>
              <button onClick={() => setError(null)} className="text-red-400 hover:text-red-600">
                بستن
              </button>
            </div>
          )}

          {loading ? (
            <div className="flex items-center justify-center py-24 text-gray-400">
              <Loader2 className="animate-spin" size={28} />
            </div>
          ) : detailStudent ? (
            <StudentDetail
              student={detailStudent}
              program={programForDetail}
              templateById={templateById}
              dietTemplate={
                programForDetail?.diet_template_id
                  ? templateById.get(programForDetail.diet_template_id) ?? null
                  : null
              }
              plans={plansForStudent.get(detailStudent.id) ?? []}
              measurements={measurementsForStudent.get(detailStudent.id) ?? []}
              onBack={() => setDetailStudent(null)}
              onEdit={() => openEditStudent(detailStudent)}
              programExercises={programExercisesForDetail}
              dietMeals={dietMealsForDetail}
              dietFoodItemsByMeal={dietFoodItemsByMeal}
              dietProgramTips={dietTipsForDetail}
              dietTips={dietTips}
              onEditWorkout={() => setWorkoutModalOpen(true)}
              onEditDiet={() => setDietModalOpen(true)}
              onExportPdf={(mode: PrintMode) => setPrintMode(mode)}
              onAddPlan={openAddPlan}
              onEditPlan={openEditPlan}
              onRenewPlan={handleRenewPlan}
              onAddMeasurement={() => setMeasurementModalOpen(true)}
            />
          ) : view === 'dashboard' ? (
            <Dashboard
              studentCount={students.length}
              workoutCount={workoutTemplates.length}
              dietCount={dietTemplates.length}
              exerciseCount={exercises.filter((e) => e.is_active).length}
              newRequestsCount={newRequestsCount}
              todayRemindersCount={todayRemindersCount}
              recentStudents={students.slice(0, 4)}
              onAddStudent={openAddStudent}
              onGoStudents={() => setView('students')}
              onOpenStudent={(s) => setDetailStudent(s)}
              onGoRequests={() => setView('requests')}
              onGoReminders={() => setView('reminders')}
              onGoExercises={() => setView('exercises')}
            />
          ) : view === 'reminders' ? (
            <RemindersView
              reminders={reminders}
              students={students}
              onMarkDone={handleMarkReminderDone}
              onOpenStudent={handleOpenStudentFromReminder}
              loading={loading}
            />
          ) : view === 'requests' ? (
            <RequestsView
              requests={requests}
              loading={loading}
              onRefresh={loadData}
            />
          ) : view === 'students' ? (
            <StudentsView
              students={filteredStudents}
              query={query}
              onQuery={setQuery}
              onAdd={openAddStudent}
              onOpen={(s) => setDetailStudent(s)}
              onEdit={openEditStudent}
              onDelete={(s) => setDeleteTarget(s)}
              programsByStudent={programsByStudent}
              allStudents={students}
              plans={plans}
              programs={programs}
              requests={requests}
              statFilter={statFilter}
              onStatFilter={setStatFilter}
              multiFilter={multiFilter}
              onMultiFilter={setMultiFilter}
            />
          ) : view === 'exercises' ? (
            <ExerciseBankView
              exercises={exercises}
              onAdd={openAddExercise}
              onEdit={openEditExercise}
              onDelete={(e) => setDeleteExerciseTarget(e)}
              onToggleFavorite={handleToggleFavorite}
              onView={(e) => setViewingExercise(e)}
              loading={loading}
            />
          ) : (
            <TemplateEditor
              templates={templates}
              templateExercises={templateExercises}
              exercises={exercises}
              onRefresh={async () => {
                const [tRes, teRes] = await Promise.all([
                  supabase.from('templates').select('*').order('type, created_at'),
                  supabase.from('template_exercises').select('*').order('sort_order'),
                ]);
                if (!tRes.error) setTemplates(tRes.data ?? []);
                if (!teRes.error) setTemplateExercises((teRes.data ?? []) as TemplateExercise[]);
              }}
            />
          )}
        </div>
      </main>

      {/* Student modal */}
      <Modal
        open={studentModalOpen}
        title={editingStudent ? 'ویرایش شاگرد' : 'ثبت شاگرد جدید'}
        onClose={() => {
          setStudentModalOpen(false);
          setEditingStudent(null);
        }}
      >
        <StudentForm
          initial={editingStudent ?? undefined}
          onSubmit={handleStudentSubmit}
          onCancel={() => {
            setStudentModalOpen(false);
            setEditingStudent(null);
          }}
          submitLabel={saving ? 'در حال ذخیره...' : editingStudent ? 'به‌روزرسانی' : 'ثبت شاگرد'}
        />
      </Modal>

      {/* Workout program modal */}
      <Modal
        open={workoutModalOpen}
        title="برنامه تمرینی"
        onClose={() => setWorkoutModalOpen(false)}
      >
        <WorkoutProgramModal
          open={workoutModalOpen}
          templates={workoutTemplates}
          templateExercises={templateExercises}
          exercises={exercises}
          existingCustomName={programForDetail?.custom_name ?? ''}
          existingAssignments={workoutAssignmentsForModal}
          onSave={handleWorkoutSave}
          onClose={() => setWorkoutModalOpen(false)}
          saving={saving}
        />
      </Modal>

      {/* Diet program modal */}
      <Modal
        open={dietModalOpen}
        title="برنامه غذایی"
        onClose={() => setDietModalOpen(false)}
      >
        <DietProgramModal
          open={dietModalOpen}
          templates={dietTemplates}
          dietTemplateMeals={dietTemplateMeals}
          dietTips={dietTips}
          existingProgramId={programForDetail?.id ?? null}
          existingTemplateId={programForDetail?.diet_template_id ?? null}
          existingDescription={programForDetail?.custom_description ?? ''}
          existingTargetCalories={programForDetail?.diet_target_calories ?? null}
          existingTargetProteinG={programForDetail?.diet_target_protein_g ?? null}
          existingPattern={programForDetail?.diet_pattern ?? null}
          existingMeals={dietMealsForDetail}
          existingFoodItemsByMeal={dietFoodItemsByMeal}
          existingTips={dietTipsForDetail}
          onSave={handleDietSave}
          onClose={() => setDietModalOpen(false)}
          saving={saving}
        />
      </Modal>

      {/* Plan modal */}
      <Modal
        open={planModalOpen}
        title={editingPlan ? 'ویرایش پلن' : 'ثبت پلن جدید'}
        onClose={() => {
          setPlanModalOpen(false);
          setEditingPlan(null);
        }}
      >
        <PlanForm
          initial={editingPlan ?? undefined}
          onSubmit={handlePlanSubmit}
          onCancel={() => {
            setPlanModalOpen(false);
            setEditingPlan(null);
          }}
          submitLabel={saving ? 'در حال ذخیره...' : editingPlan ? 'به‌روزرسانی' : 'ثبت پلن'}
        />
      </Modal>

      {/* Measurement modal */}
      <Modal
        open={measurementModalOpen}
        title="ثبت اندازه‌گیری جدید"
        onClose={() => setMeasurementModalOpen(false)}
      >
        <MeasurementForm
          onSubmit={handleMeasurementSubmit}
          onCancel={() => setMeasurementModalOpen(false)}
          submitLabel={saving ? 'در حال ذخیره...' : 'ثبت اندازه‌گیری'}
        />
      </Modal>

      {/* Exercise form modal */}
      <Modal
        open={exerciseModalOpen}
        title={editingExercise ? 'ویرایش حرکت' : 'افزودن حرکت جدید'}
        onClose={() => {
          setExerciseModalOpen(false);
          setEditingExercise(null);
        }}
      >
        <ExerciseForm
          initial={editingExercise ?? undefined}
          duplicateNames={exerciseDuplicateNames}
          onSubmit={handleExerciseSubmit}
          onCancel={() => {
            setExerciseModalOpen(false);
            setEditingExercise(null);
          }}
          submitLabel={saving ? 'در حال ذخیره...' : editingExercise ? 'به‌روزرسانی' : 'ثبت حرکت'}
        />
      </Modal>

      {/* Exercise detail modal */}
      <Modal
        open={!!viewingExercise}
        title="مشاهدهٔ حرکت"
        onClose={() => setViewingExercise(null)}
      >
        {viewingExercise && (
          <ExerciseDetail
            exercise={viewingExercise}
            onClose={() => setViewingExercise(null)}
          />
        )}
      </Modal>

      {/* Exercise delete confirm */}
      <Modal
        open={!!deleteExerciseTarget}
        title="حذف حرکت"
        onClose={() => setDeleteExerciseTarget(null)}
        footer={
          <div className="flex justify-start gap-2">
            <button
              onClick={handleDeleteExercise}
              disabled={saving}
              className="px-5 py-2.5 rounded-xl bg-red-600 text-white text-sm font-medium hover:bg-red-700 transition-colors disabled:opacity-50"
            >
              {saving ? 'در حال حذف...' : 'حذف کن'}
            </button>
            <button
              onClick={() => setDeleteExerciseTarget(null)}
              className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200 transition-colors"
            >
              انصراف
            </button>
          </div>
        }
      >
        <p className="text-sm text-gray-600 leading-7">
          آیا از حذف حرکت «{deleteExerciseTarget?.name_fa || deleteExerciseTarget?.name_en}» مطمئن هستید؟
        </p>
      </Modal>

      {/* Delete confirm */}
      <Modal
        open={!!deleteTarget}
        title="حذف شاگرد"
        onClose={() => setDeleteTarget(null)}
        footer={
          <div className="flex justify-start gap-2">
            <button
              onClick={handleDeleteStudent}
              disabled={saving}
              className="px-5 py-2.5 rounded-xl bg-red-600 text-white text-sm font-medium hover:bg-red-700 transition-colors disabled:opacity-50"
            >
              {saving ? 'در حال حذف...' : 'حذف کن'}
            </button>
            <button
              onClick={() => setDeleteTarget(null)}
              className="px-5 py-2.5 rounded-xl bg-gray-100 text-gray-700 text-sm font-medium hover:bg-gray-200 transition-colors"
            >
              انصراف
            </button>
          </div>
        }
      >
        <p className="text-sm text-gray-600 leading-7">
          آیا از حذف پروندهٔ «{deleteTarget?.name}» مطمئن هستید؟ این عمل قابل بازگشت
          نیست و برنامهٔ اختصاص‌یافتهٔ این شاگرد نیز حذف خواهد شد.
        </p>
      </Modal>

      {/* Professional PDF print layout */}
      {printMode && detailStudent && (
        <PrintLayout
          mode={printMode}
          student={detailStudent}
          program={programForDetail}
          activePlan={
            (plansForStudent.get(detailStudent.id) ?? []).find(
              (p) => p.plan_status === 'active' || p.plan_status === 'expiring',
            ) ?? null
          }
          programExercises={programExercisesForDetail}
          dietMeals={dietMealsForDetail}
          dietFoodItemsByMeal={dietFoodItemsByMeal}
          dietProgramTips={dietTipsForDetail}
          dietTips={dietTips}
          dietTemplate={
            programForDetail?.diet_template_id
              ? templateById.get(programForDetail.diet_template_id) ?? null
              : null
          }
          onDone={() => setPrintMode(null)}
        />
      )}
    </div>
  );
}

function NavItem({
  icon,
  label,
  active,
  onClick,
  badge,
}: {
  icon: React.ReactNode;
  label: string;
  active: boolean;
  onClick: () => void;
  badge?: number;
}) {
  return (
    <button
      onClick={onClick}
      className={`flex items-center gap-3 rounded-xl px-3.5 py-2.5 text-sm font-medium transition-colors ${
        active
          ? 'bg-brand-50 text-brand-700'
          : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700'
      }`}
    >
      {icon}
      <span className="flex-1 text-right">{label}</span>
      {badge != null && badge > 0 && (
        <span className="flex h-5 min-w-5 items-center justify-center rounded-full bg-brand-600 px-1.5 text-[10px] font-bold text-white">
          {badge}
        </span>
      )}
    </button>
  );
}

function Dashboard({
  studentCount,
  workoutCount,
  dietCount,
  exerciseCount,
  newRequestsCount,
  todayRemindersCount,
  recentStudents,
  onAddStudent,
  onGoStudents,
  onOpenStudent,
  onGoRequests,
  onGoReminders,
  onGoExercises,
}: {
  studentCount: number;
  workoutCount: number;
  dietCount: number;
  exerciseCount: number;
  newRequestsCount: number;
  todayRemindersCount: number;
  recentStudents: Student[];
  onAddStudent: () => void;
  onGoStudents: () => void;
  onOpenStudent: (s: Student) => void;
  onGoRequests: () => void;
  onGoReminders: () => void;
  onGoExercises: () => void;
}) {
  return (
    <div>
      <Header title="داشبورد" subtitle="نمای کلی از شاگردها و قالب‌های شما" />
      <div className="grid grid-cols-4 gap-4">
        <StatCard
          icon={<Users size={20} />}
          label="شاگردها"
          value={studentCount}
          accent="brand"
        />
        <StatCard
          icon={<Inbox size={20} />}
          label="درخواست جدید"
          value={newRequestsCount}
          accent="blue"
        />
        <StatCard
          icon={<Bell size={20} />}
          label="یادآور امروز"
          value={todayRemindersCount}
          accent="amber"
        />
        <StatCard
          icon={<Dumbbell size={20} />}
          label="بانک حرکات"
          value={exerciseCount}
          accent="emerald"
        />
      </div>

      <button
        onClick={onGoExercises}
        className="mt-4 flex w-full items-center justify-between rounded-2xl border border-emerald-100 bg-emerald-50/60 p-4 text-right hover:bg-emerald-50 transition-colors"
      >
        <div className="flex items-center gap-3">
          <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-emerald-100 text-emerald-700">
            <Dumbbell size={18} />
          </div>
          <div>
            <p className="text-sm font-semibold text-emerald-900">
              {exerciseCount} حرکت در بانک
            </p>
            <p className="text-xs text-emerald-600">برای افزودن یا ویرایش حرکات کلیک کنید</p>
          </div>
        </div>
        <ArrowRight size={16} className="text-emerald-400" />
      </button>

      {todayRemindersCount > 0 && (
        <button
          onClick={onGoReminders}
          className="mt-4 flex w-full items-center justify-between rounded-2xl border border-amber-100 bg-amber-50/60 p-4 text-right hover:bg-amber-50 transition-colors"
        >
          <div className="flex items-center gap-3">
            <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-amber-100 text-amber-700">
              <Bell size={18} />
            </div>
            <div>
              <p className="text-sm font-semibold text-amber-900">
                {todayRemindersCount} یادآور برای امروز
              </p>
              <p className="text-xs text-amber-600">برای مشاهده و پیگیری کلیک کنید</p>
            </div>
          </div>
          <ArrowRight size={16} className="text-amber-400" />
        </button>
      )}

      {newRequestsCount > 0 && (
        <button
          onClick={onGoRequests}
          className="mt-4 flex w-full items-center justify-between rounded-2xl border border-blue-100 bg-blue-50/60 p-4 text-right hover:bg-blue-50 transition-colors"
        >
          <div className="flex items-center gap-3">
            <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-blue-100 text-blue-700">
              <Inbox size={18} />
            </div>
            <div>
              <p className="text-sm font-semibold text-blue-900">
                {newRequestsCount} درخواست جدید در انتظار بررسی
              </p>
              <p className="text-xs text-blue-600">برای مشاهده و پاسخ کلیک کنید</p>
            </div>
          </div>
          <ArrowRight size={16} className="text-blue-400" />
        </button>
      )}

      <div className="mt-6 flex items-center justify-between">
        <h2 className="text-base font-semibold text-gray-800">آخرین شاگردها</h2>
        <button
          onClick={onGoStudents}
          className="flex items-center gap-1 text-sm text-brand-600 hover:text-brand-700 font-medium"
        >
          همهٔ شاگردها
          <ArrowRight size={16} />
        </button>
      </div>

      {recentStudents.length === 0 ? (
        <div className="mt-3 rounded-2xl border border-dashed border-gray-200 bg-white p-10 text-center">
          <Users className="mx-auto text-gray-300" size={32} />
          <p className="mt-3 text-sm text-gray-500">هنوز شاگردی ثبت نشده است.</p>
        </div>
      ) : (
        <div className="mt-3 grid grid-cols-2 gap-3">
          {recentStudents.map((s) => (
            <button
              key={s.id}
              onClick={() => onOpenStudent(s)}
              className="flex items-center justify-between rounded-2xl border border-gray-100 bg-white p-4 text-right shadow-card hover:shadow-cardHover transition-all"
            >
              <div className="flex items-center gap-3">
                <div className="flex h-10 w-10 items-center justify-center rounded-full bg-brand-50 text-brand-700 text-sm font-semibold">
                  {s.name.charAt(0)}
                </div>
                <div>
                  <p className="text-sm font-semibold text-gray-800">{s.name}</p>
                  <p className="text-xs text-gray-400">
                    {s.goal ?? 'بدون هدف مشخص'}
                  </p>
                </div>
              </div>
              <ArrowRight size={16} className="text-gray-300" />
            </button>
          ))}
        </div>
      )}

      <button
        onClick={onAddStudent}
        className="mt-6 flex items-center gap-2 rounded-xl bg-brand-600 px-5 py-3 text-white text-sm font-medium hover:bg-brand-700 transition-colors shadow-sm"
      >
        <Plus size={18} />
        ثبت شاگرد جدید
      </button>
    </div>
  );
}

const accentMap: Record<string, string> = {
  brand: 'bg-brand-50 text-brand-700',
  blue: 'bg-blue-50 text-blue-700',
  emerald: 'bg-emerald-50 text-emerald-700',
  amber: 'bg-amber-50 text-amber-700',
};

function StatCard({
  icon,
  label,
  value,
  accent,
}: {
  icon: React.ReactNode;
  label: string;
  value: number;
  accent: string;
}) {
  return (
    <div className="rounded-2xl border border-gray-100 bg-white p-5 shadow-card">
      <div
        className={`flex h-10 w-10 items-center justify-center rounded-xl ${accentMap[accent]}`}
      >
        {icon}
      </div>
      <p className="mt-3 text-3xl font-bold text-gray-800">{value}</p>
      <p className="text-sm text-gray-500">{label}</p>
    </div>
  );
}

function StudentFilterBar({
  multiFilter,
  onMultiFilter,
  hasStatFilter,
  onClearStat,
}: {
  multiFilter: MultiFilter;
  onMultiFilter: (mf: MultiFilter) => void;
  hasStatFilter: boolean;
  onClearStat: () => void;
}) {
  const hasActive = hasActiveMultiFilter(multiFilter) || hasStatFilter;
  const update = (patch: Partial<MultiFilter>) => onMultiFilter({ ...multiFilter, ...patch });
  const clearAll = () => {
    onMultiFilter(DEFAULT_MULTI_FILTER);
    onClearStat();
  };

  const selectClass =
    'rounded-lg border border-gray-200 bg-white px-2.5 py-1.5 text-xs outline-none focus:border-brand-500 focus:ring-1 focus:ring-brand-100';

  return (
    <div className="mt-3 flex items-center gap-2 flex-wrap">
      <select
        value={multiFilter.planStatus}
        onChange={(e) => update({ planStatus: e.target.value as PlanStatusFilter })}
        className={selectClass}
      >
        <option value="all">وضعیت پلن: همه</option>
        <option value="active">پلن فعال</option>
        <option value="expiring">نزدیک به پایان</option>
        <option value="expired">منقضی‌شده</option>
        <option value="none">بدون پلن</option>
      </select>

      <select
        value={multiFilter.payment}
        onChange={(e) => update({ payment: e.target.value as PaymentFilter })}
        className={selectClass}
      >
        <option value="all">پرداخت: همه</option>
        <option value="paid">پرداخت‌شده</option>
        <option value="unpaid">پرداخت‌نشده</option>
        <option value="partial">پرداخت جزئی</option>
      </select>

      <select
        value={multiFilter.programStatus}
        onChange={(e) => update({ programStatus: e.target.value as ProgramStatusFilter })}
        className={selectClass}
      >
        <option value="all">برنامه: همه</option>
        <option value="draft">در حال طراحی</option>
        <option value="completed">تکمیل‌شده</option>
        <option value="none">بدون برنامه</option>
      </select>

      <select
        value={multiFilter.requestStage}
        onChange={(e) => update({ requestStage: e.target.value as RequestStageFilter })}
        className={selectClass}
      >
        <option value="all">درخواست: همه</option>
        <option value="new">جدید</option>
        <option value="needs_info">نیازمند تکمیل</option>
        <option value="reviewing">در حال بررسی</option>
        <option value="approved">تأییدشده</option>
        <option value="none">بدون درخواست</option>
      </select>

      <select
        value={multiFilter.sort}
        onChange={(e) => update({ sort: e.target.value as StudentSort })}
        className={selectClass}
      >
        <option value="created_desc">جدیدترین ثبت‌نام</option>
        <option value="created_asc">قدیمی‌ترین ثبت‌نام</option>
        <option value="updated_desc">آخرین تغییر</option>
        <option value="plan_end_asc">نزدیک‌ترین پایان پلن</option>
      </select>

      {hasActive && (
        <button
          onClick={clearAll}
          className="flex items-center gap-1 rounded-lg bg-red-50 px-2.5 py-1.5 text-xs font-medium text-red-600 hover:bg-red-100 transition-colors"
        >
          <FilterX size={13} />
          پاک‌کردن همه فیلترها
        </button>
      )}
    </div>
  );
}

function StudentsView({
  students,
  query,
  onQuery,
  onAdd,
  onOpen,
  onEdit,
  onDelete,
  programsByStudent,
  allStudents,
  plans,
  programs,
  requests,
  statFilter,
  onStatFilter,
  multiFilter,
  onMultiFilter,
}: {
  students: Student[];
  query: string;
  onQuery: (q: string) => void;
  onAdd: () => void;
  onOpen: (s: Student) => void;
  onEdit: (s: Student) => void;
  onDelete: (s: Student) => void;
  programsByStudent: Map<string, AssignedProgram>;
  allStudents: Student[];
  plans: StudentPlan[];
  programs: AssignedProgram[];
  requests: IntakeRequest[];
  statFilter: StudentStatFilter;
  onStatFilter: (f: StudentStatFilter) => void;
  multiFilter: MultiFilter;
  onMultiFilter: (mf: MultiFilter) => void;
}) {
  return (
    <div>
      <div className="flex items-center justify-between gap-4">
        <Header title="شاگردها" subtitle={`${allStudents.length} شاگرد ثبت شده`} />
        <button
          onClick={onAdd}
          className="flex items-center gap-2 rounded-xl bg-brand-600 px-4 py-2.5 text-white text-sm font-medium hover:bg-brand-700 transition-colors shadow-sm"
        >
          <Plus size={18} />
          شاگرد جدید
        </button>
      </div>

      {/* Stats cards */}
      <div className="mt-5">
        <StudentStatsCards
          students={allStudents}
          plans={plans}
          programs={programs}
          requests={requests}
          activeFilter={statFilter}
          onFilter={onStatFilter}
        />
      </div>

      <div className="relative mt-5">
        <Search
          size={18}
          className="absolute right-3.5 top-1/2 -translate-y-1/2 text-gray-400"
        />
        <input
          value={query}
          onChange={(e) => onQuery(e.target.value)}
          placeholder="جست‌وجو بر اساس نام یا شماره تماس..."
          className="w-full rounded-xl border border-gray-200 bg-white py-2.5 pr-11 pl-4 text-sm outline-none transition-colors focus:border-brand-500 focus:ring-2 focus:ring-brand-100"
        />
      </div>

      {/* Multi-filter bar */}
      <StudentFilterBar
        multiFilter={multiFilter}
        onMultiFilter={onMultiFilter}
        hasStatFilter={statFilter !== 'all'}
        onClearStat={() => onStatFilter('all')}
      />

      {/* Result count */}
      {students.length > 0 && (
        <p className="mt-3 text-xs text-gray-400">
          {students.length.toLocaleString('fa-IR')} نتیجه از {allStudents.length.toLocaleString('fa-IR')} شاگرد
        </p>
      )}

      {students.length === 0 ? (
        <div className="mt-4 rounded-2xl border border-dashed border-gray-200 bg-white p-12 text-center">
          <Users className="mx-auto text-gray-300" size={32} />
          <p className="mt-3 text-sm text-gray-500">
            {query ? 'نتیجه‌ای یافت نشد.' : 'هنوز شاگردی ثبت نشده است.'}
          </p>
        </div>
      ) : (
        <div className="mt-4 overflow-hidden rounded-2xl border border-gray-100 bg-white shadow-card">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-gray-100 bg-gray-50/60 text-gray-500 text-xs">
                <th className="px-5 py-3 text-right font-medium">نام</th>
                <th className="px-5 py-3 text-right font-medium">سن</th>
                <th className="px-5 py-3 text-right font-medium">قد / وزن</th>
                <th className="px-5 py-3 text-right font-medium">هدف</th>
                <th className="px-5 py-3 text-right font-medium">برنامه</th>
                <th className="px-5 py-3 text-left font-medium">عملیات</th>
              </tr>
            </thead>
            <tbody>
              {students.map((s) => {
                const hasProgram = programsByStudent.has(s.id);
                return (
                  <tr
                    key={s.id}
                    className="border-b border-gray-50 last:border-0 hover:bg-gray-50/50 transition-colors"
                  >
                    <td className="px-5 py-3.5">
                      <button
                        onClick={() => onOpen(s)}
                        className="flex items-center gap-2.5 text-right"
                      >
                        <span className="flex h-8 w-8 items-center justify-center rounded-full bg-brand-50 text-brand-700 text-xs font-semibold">
                          {s.name.charAt(0)}
                        </span>
                        <span className="font-medium text-gray-800 hover:text-brand-700">
                          {s.name}
                        </span>
                      </button>
                    </td>
                    <td className="px-5 py-3.5 text-gray-600">
                      {s.age != null ? `${s.age} سال` : '—'}
                    </td>
                    <td className="px-5 py-3.5 text-gray-600">
                      {s.height_cm != null || s.weight_kg != null
                        ? `${s.height_cm ?? '—'} / ${s.weight_kg ?? '—'}`
                        : '—'}
                    </td>
                    <td className="px-5 py-3.5 text-gray-600 max-w-[200px] truncate">
                      {s.goal ?? '—'}
                    </td>
                    <td className="px-5 py-3.5">
                      <span
                        className={`inline-flex rounded-full px-2.5 py-0.5 text-xs font-medium ${
                          hasProgram
                            ? 'bg-emerald-50 text-emerald-700'
                            : 'bg-gray-100 text-gray-500'
                        }`}
                      >
                        {hasProgram ? 'دارد' : 'ندارد'}
                      </span>
                    </td>
                    <td className="px-5 py-3.5">
                      <div className="flex items-center justify-end gap-1">
                        <button
                          onClick={() => onEdit(s)}
                          className="p-1.5 rounded-lg text-gray-400 hover:text-brand-600 hover:bg-brand-50 transition-colors"
                          title="ویرایش"
                        >
                          <Pencil size={16} />
                        </button>
                        <button
                          onClick={() => onDelete(s)}
                          className="p-1.5 rounded-lg text-gray-400 hover:text-red-600 hover:bg-red-50 transition-colors"
                          title="حذف"
                        >
                          <Trash2 size={16} />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

function StudentDetail({
  student,
  program,
  templateById,
  dietTemplate,
  plans,
  measurements,
  programExercises,
  dietMeals,
  dietFoodItemsByMeal,
  dietProgramTips,
  dietTips,
  onBack,
  onEdit,
  onEditWorkout,
  onEditDiet,
  onExportPdf,
  onAddPlan,
  onEditPlan,
  onRenewPlan,
  onAddMeasurement,
}: {
  student: Student;
  program: AssignedProgram | null;
  templateById: Map<string, Template>;
  dietTemplate: Template | null;
  plans: StudentPlan[];
  measurements: Measurement[];
  programExercises: ProgramExercise[];
  dietMeals: DietProgramMeal[];
  dietFoodItemsByMeal: Map<string, DietProgramFoodItem[]>;
  dietProgramTips: DietProgramTip[];
  dietTips: DietTip[];
  onBack: () => void;
  onEdit: () => void;
  onEditWorkout: () => void;
  onEditDiet: () => void;
  onExportPdf: (mode: PrintMode) => void;
  onAddPlan: () => void;
  onEditPlan: (p: StudentPlan) => void;
  onRenewPlan: (p: StudentPlan) => void;
  onAddMeasurement: () => void;
}) {
  const activePlan = plans.find((p) => p.plan_status === 'active' || p.plan_status === 'expiring') ?? null;
  const sortedMeasurements = [...measurements].sort((a, b) => b.recorded_at.localeCompare(a.recorded_at));
  const latestMeasurement = sortedMeasurements[0] ?? null;

  return (
    <div>
      <button
        onClick={onBack}
        className="no-print flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-700 mb-4"
      >
        <ArrowRight size={16} className="rotate-180" />
        بازگشت به فهرست
      </button>

      <div className="flex items-start justify-between gap-4">
        <div className="flex items-center gap-4">
          <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-brand-600 text-white text-xl font-semibold">
            {student.name.charAt(0)}
          </div>
          <div>
            <h1 className="text-xl font-bold text-gray-800">{student.name}</h1>
            <p className="text-sm text-gray-500 mt-0.5">
              {student.goal ?? 'بدون هدف مشخص'}
            </p>
          </div>
        </div>
        <div className="flex items-center gap-2 no-print">
          <button
            onClick={onEdit}
            className="flex items-center gap-1.5 rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
          >
            <Pencil size={15} />
            ویرایش پرونده
          </button>
          <PdfExportMenu onExport={onExportPdf} />
        </div>
      </div>

      <div className="mt-5 grid grid-cols-4 gap-3">
        <InfoTile icon={<Calendar size={16} />} label="سن" value={student.age != null ? `${student.age} سال` : '—'} />
        <InfoTile label="قد" value={student.height_cm != null ? `${student.height_cm} cm` : '—'} />
        <InfoTile label="وزن" value={student.weight_kg != null ? `${student.weight_kg} kg` : '—'} />
        <InfoTile icon={<Target size={16} />} label="هدف" value={student.goal ?? '—'} />
      </div>

      {/* Contact & registration info */}
      <div className="mt-3 grid grid-cols-3 gap-3">
        <InfoTile label="شماره تماس" value={student.phone ?? '—'} />
        <InfoTile icon={<Calendar size={16} />} label="تاریخ تولد" value={formatJalaliShort(student.birth_date)} />
        <InfoTile icon={<Calendar size={16} />} label="تاریخ ثبت‌نام" value={formatJalaliDateTime(student.created_at)} />
      </div>

      {/* Coach notes (internal) */}
      {student.coach_notes && (
        <div className="no-print mt-3 rounded-2xl border border-amber-100 bg-amber-50/40 p-4">
          <div className="flex items-center gap-1.5 text-amber-700">
            <ClipboardList size={14} />
            <span className="text-xs font-semibold">یادداشت داخلی مربی</span>
          </div>
          <p className="mt-1.5 text-sm text-gray-700 leading-7 whitespace-pre-wrap">{student.coach_notes}</p>
        </div>
      )}

      {/* Plan section */}
      <div className="mt-6 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <CreditCard size={18} className="text-gray-500" />
            <h2 className="text-base font-semibold text-gray-800">پلن شاگرد</h2>
          </div>
          <button
            onClick={onAddPlan}
            className="no-print flex items-center gap-1.5 rounded-xl bg-brand-600 px-4 py-2 text-sm font-medium text-white hover:bg-brand-700 transition-colors"
          >
            <Plus size={15} />
            {activePlan ? 'پلن جدید' : 'ثبت پلن'}
          </button>
        </div>

        {!activePlan && plans.length === 0 ? (
          <div className="mt-4 rounded-xl border border-dashed border-gray-200 p-8 text-center">
            <CreditCard className="mx-auto text-gray-300" size={28} />
            <p className="mt-2 text-sm text-gray-500">
              هنوز پلنی برای این شاگرد ثبت نشده است.
            </p>
          </div>
        ) : (
          <div className="mt-4 space-y-3">
            {/* Active plan card */}
            {activePlan && (
              <div className={`rounded-xl border p-4 ${
                activePlan.plan_status === 'expiring'
                  ? 'border-amber-200 bg-amber-50/40'
                  : 'border-emerald-200 bg-emerald-50/40'
              }`}>
                <div className="flex items-start justify-between gap-3">
                  <div className="flex-1">
                    <div className="flex items-center gap-2 flex-wrap">
                      <span className="text-sm font-semibold text-gray-800">
                        {PLAN_LABELS[activePlan.plan_type]}
                        {activePlan.plan_type === 'custom' && activePlan.custom_type_label
                          ? ` (${activePlan.custom_type_label})`
                          : ''}
                      </span>
                      <span className={`inline-flex rounded-full px-2.5 py-0.5 text-xs font-medium ${STATUS_COLORS[activePlan.plan_status]}`}>
                        {STATUS_LABELS[activePlan.plan_status]}
                      </span>
                      <span className={`inline-flex rounded-full px-2.5 py-0.5 text-xs font-medium ${PAY_COLORS[activePlan.payment_status]}`}>
                        {PAY_LABELS[activePlan.payment_status]}
                      </span>
                    </div>
                    <div className="mt-2 grid grid-cols-3 gap-2 text-xs text-gray-600">
                      <div>
                        <span className="text-gray-400">شروع: </span>
                        {formatDate(activePlan.start_date)}
                      </div>
                      <div>
                        <span className="text-gray-400">پایان: </span>
                        {formatDate(activePlan.end_date)}
                      </div>
                      <div>
                        <span className="text-gray-400">مبلغ: </span>
                        {activePlan.amount > 0 ? activePlan.amount.toLocaleString('fa-IR') + ' ت' : '—'}
                      </div>
                    </div>
                    {activePlan.notes && (
                      <p className="mt-2 text-xs text-gray-500 leading-6">{activePlan.notes}</p>
                    )}
                  </div>
                  <div className="flex items-center gap-1 no-print">
                    <button
                      onClick={() => onEditPlan(activePlan)}
                      className="p-1.5 rounded-lg text-gray-400 hover:text-brand-600 hover:bg-brand-50 transition-colors"
                      title="ویرایش پلن"
                    >
                      <Pencil size={15} />
                    </button>
                    <button
                      onClick={() => onRenewPlan(activePlan)}
                      className="flex items-center gap-1 rounded-lg bg-brand-50 px-2.5 py-1.5 text-xs font-medium text-brand-700 hover:bg-brand-100 transition-colors"
                      title="تمدید پلن"
                    >
                      <RefreshCw size={13} />
                      تمدید
                    </button>
                  </div>
                </div>
              </div>
            )}

            {/* Plan history */}
            {plans.length > 1 && (
              <div className="rounded-xl border border-gray-100 bg-gray-50/40 p-4">
                <p className="text-xs font-semibold text-gray-500 mb-2">تاریخچه پلن‌های قبلی</p>
                <div className="space-y-1.5">
                  {plans.filter((p) => p.id !== activePlan?.id).map((p) => (
                    <div key={p.id} className="flex items-center justify-between text-xs text-gray-600">
                      <span>
                        {PLAN_LABELS[p.plan_type]}
                        {p.plan_type === 'custom' && p.custom_type_label ? ` (${p.custom_type_label})` : ''}
                      </span>
                      <span className="text-gray-400">
                        {formatDate(p.start_date)} تا {formatDate(p.end_date)}
                      </span>
                      <span className={`inline-flex rounded-full px-2 py-0.5 text-[10px] font-medium ${STATUS_COLORS[p.plan_status]}`}>
                        {STATUS_LABELS[p.plan_status]}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        )}
      </div>

      {/* Measurement section */}
      <div className="mt-6 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Ruler size={18} className="text-gray-500" />
            <h2 className="text-base font-semibold text-gray-800">اندازه‌گیری‌ها</h2>
          </div>
          <button
            onClick={onAddMeasurement}
            className="no-print flex items-center gap-1.5 rounded-xl bg-brand-600 px-4 py-2 text-sm font-medium text-white hover:bg-brand-700 transition-colors"
          >
            <Plus size={15} />
            ثبت اندازه‌گیری
          </button>
        </div>

        {sortedMeasurements.length === 0 ? (
          <div className="mt-4 rounded-xl border border-dashed border-gray-200 p-8 text-center">
            <Ruler className="mx-auto text-gray-300" size={28} />
            <p className="mt-2 text-sm text-gray-500">
              هنوز اندازه‌گیری‌ای ثبت نشده است.
            </p>
          </div>
        ) : (
          <div className="mt-4 overflow-hidden rounded-xl border border-gray-100">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-gray-100 bg-gray-50/60 text-gray-500 text-xs">
                  <th className="px-4 py-2.5 text-right font-medium">تاریخ</th>
                  <th className="px-4 py-2.5 text-right font-medium">وزن</th>
                  <th className="px-4 py-2.5 text-right font-medium">کمر</th>
                  <th className="px-4 py-2.5 text-right font-medium">باسن</th>
                  <th className="px-4 py-2.5 text-right font-medium">سینه</th>
                  <th className="px-4 py-2.5 text-right font-medium">ران</th>
                  <th className="px-4 py-2.5 text-right font-medium">بازو</th>
                </tr>
              </thead>
              <tbody>
                {sortedMeasurements.map((m) => (
                  <tr key={m.id} className="border-b border-gray-50 last:border-0">
                    <td className="px-4 py-2.5 text-gray-700 font-medium">{formatDate(m.recorded_at)}</td>
                    <td className="px-4 py-2.5 text-gray-600">{m.weight_kg != null ? `${m.weight_kg}` : '—'}</td>
                    <td className="px-4 py-2.5 text-gray-600">{m.waist_cm != null ? `${m.waist_cm}` : '—'}</td>
                    <td className="px-4 py-2.5 text-gray-600">{m.hip_cm != null ? `${m.hip_cm}` : '—'}</td>
                    <td className="px-4 py-2.5 text-gray-600">{m.chest_cm != null ? `${m.chest_cm}` : '—'}</td>
                    <td className="px-4 py-2.5 text-gray-600">{m.thigh_cm != null ? `${m.thigh_cm}` : '—'}</td>
                    <td className="px-4 py-2.5 text-gray-600">{m.arm_cm != null ? `${m.arm_cm}` : '—'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {latestMeasurement && (
          <p className="mt-3 text-xs text-gray-400">
            آخرین اندازه‌گیری: {formatDate(latestMeasurement.recorded_at)} — یادآور بعدی ۱۴ روز پس از این تاریخ
          </p>
        )}
      </div>

      {/* Workout program section */}
      <div className="mt-6 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Dumbbell size={18} className="text-brand-600" />
            <h2 className="text-base font-semibold text-gray-800">برنامه تمرینی</h2>
            <ProgramStatusBadge status={program?.workout_status ?? 'none'} />
          </div>
          <button
            onClick={onEditWorkout}
            className="no-print flex items-center gap-1.5 rounded-xl bg-brand-600 px-4 py-2 text-sm font-medium text-white hover:bg-brand-700 transition-colors"
          >
            <Pencil size={15} />
            {programExercises.length > 0 ? 'ویرایش تمرینی' : 'طراحی تمرینی'}
          </button>
        </div>

        {programExercises.length === 0 ? (
          <div className="mt-4 rounded-xl border border-dashed border-gray-200 p-8 text-center">
            <Dumbbell className="mx-auto text-gray-300" size={28} />
            <p className="mt-2 text-sm text-gray-500">
              برنامه تمرینی طراحی نشده است.
            </p>
          </div>
        ) : (
          <div className="mt-4 flex flex-col gap-4">
            {program?.custom_name && (
              <div>
                <p className="text-xs text-gray-400">نام برنامه</p>
                <p className="text-sm font-semibold text-gray-800 mt-0.5">
                  {program.custom_name}
                </p>
              </div>
            )}
            {(() => {
              const sourceIds = [...new Set(programExercises.map((pe) => pe.source_template_id).filter(Boolean))] as string[];
              if (sourceIds.length === 0) return null;
              return (
                <div className="rounded-xl border border-gray-100 bg-gray-50/60 p-4">
                  <div className="flex items-center gap-1.5 text-gray-500">
                    <ClipboardList size={14} />
                    <span className="text-xs">قالب‌های مبدا</span>
                  </div>
                  <div className="mt-1.5 flex flex-wrap gap-1.5">
                    {sourceIds.map((id) => {
                      const t = templateById.get(id);
                      return (
                        <span key={id} className="inline-flex rounded-lg bg-white border border-gray-200 px-2.5 py-1 text-xs font-medium text-gray-700">
                          {t?.name ?? 'قالب حذف‌شده'}
                        </span>
                      );
                    })}
                  </div>
                </div>
              );
            })()}
            {programExercises.length > 0 && (
              <div>
                <p className="text-xs font-semibold text-gray-500 mb-2">حرکات برنامه</p>
                <ProgramExerciseList programExercises={programExercises} />
              </div>
            )}
          </div>
        )}
      </div>

      {/* Diet program section */}
      <div className="mt-6 rounded-2xl border border-gray-100 bg-white p-6 shadow-card">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Apple size={18} className="text-brand-600" />
            <h2 className="text-base font-semibold text-gray-800">برنامه غذایی</h2>
            <ProgramStatusBadge status={program?.diet_status ?? 'none'} />
          </div>
          <button
            onClick={onEditDiet}
            className="no-print flex items-center gap-1.5 rounded-xl bg-brand-600 px-4 py-2 text-sm font-medium text-white hover:bg-brand-700 transition-colors"
          >
            <Pencil size={15} />
            {dietTemplate || program?.custom_description ? 'ویرایش غذایی' : 'طراحی غذایی'}
          </button>
        </div>

        {!dietTemplate && !program?.custom_description && dietMeals.length === 0 ? (
          <div className="mt-4 rounded-xl border border-dashed border-gray-200 p-8 text-center">
            <Apple className="mx-auto text-gray-300" size={28} />
            <p className="mt-2 text-sm text-gray-500">
              برنامه غذایی طراحی نشده است.
            </p>
          </div>
        ) : (
          <div className="mt-4 flex flex-col gap-4">
            {/* Diet targets: calories + protein only (student-facing) */}
            {(program?.diet_target_calories != null || program?.diet_target_protein_g != null || program?.diet_pattern) && (
              <div className="rounded-xl border border-brand-100 bg-brand-50/30 p-4">
                <div className="flex items-center gap-2 flex-wrap">
                  {program?.diet_pattern && (
                    <span className="inline-flex rounded-full bg-brand-100 px-3 py-1 text-xs font-semibold text-brand-700">
                      {program.diet_pattern}
                    </span>
                  )}
                  {program?.diet_target_calories != null && (
                    <span className="text-sm font-semibold text-gray-700">
                      کالری هدف: <span className="text-brand-700">{program.diet_target_calories.toLocaleString('fa-IR')}</span>
                    </span>
                  )}
                  {program?.diet_target_protein_g != null && (
                    <span className="text-sm font-semibold text-gray-700">
                      پروتئین هدف: <span className="text-brand-700">{program.diet_target_protein_g.toLocaleString('fa-IR')} گرم</span>
                    </span>
                  )}
                </div>
              </div>
            )}
            {dietTemplate && (
              <div className="no-print rounded-xl border border-gray-100 bg-gray-50/60 p-4">
                <div className="flex items-center gap-1.5 text-gray-500">
                  <ClipboardList size={14} />
                  <span className="text-xs">قالب مبدا</span>
                </div>
                <p className="mt-1.5 text-sm font-semibold text-gray-800">{dietTemplate.name}</p>
                {dietTemplate.description && (
                  <p className="mt-1 text-xs leading-6 text-gray-500">{dietTemplate.description}</p>
                )}
              </div>
            )}
            {/* Structured meals */}
            {dietMeals.length > 0 && (
              <div className="space-y-3">
                {dietMeals.map((meal, mi) => {
                  const foods = dietFoodItemsByMeal.get(meal.id) ?? [];
                  return (
                    <div key={meal.id} className="rounded-xl border border-gray-100 bg-gray-50/40 p-4 break-inside-avoid">
                      <div className="flex items-center gap-2">
                        <span className="flex h-6 w-6 items-center justify-center rounded-full bg-brand-100 text-brand-700 text-xs font-bold">{(mi + 1).toLocaleString('fa-IR')}</span>
                        <h3 className="text-sm font-semibold text-gray-800">{meal.name || `وعده ${(mi + 1).toLocaleString('fa-IR')}`}</h3>
                      </div>
                      {(meal.fasting_start || meal.fasting_end) && (
                        <p className="mt-1 text-[11px] text-amber-600">
                          بازه ناشتایی: {meal.fasting_start} تا {meal.fasting_end}
                        </p>
                      )}
                      {foods.length > 0 && (
                        <ul className="mt-2 space-y-1.5">
                          {foods.map((f, fi) => (
                            <li key={f.id} className="flex items-start gap-2 text-sm break-inside-avoid">
                              <span className="text-gray-400 text-xs mt-0.5 shrink-0">{(fi + 1).toLocaleString('fa-IR')}.</span>
                              <div className="flex-1 min-w-0">
                                <span className="font-medium text-gray-700">{f.name}</span>
                                {f.amount && <span className="text-gray-500"> — {f.amount}{f.unit ? ` ${f.unit}` : ''}</span>}
                                {f.is_raw != null && (
                                  <span className="text-[10px] text-gray-400 mr-1">({f.is_raw ? 'خام' : 'پخته'})</span>
                                )}
                                {f.alternatives && (
                                  <p className="text-[11px] text-gray-400 leading-5">جایگزین: {f.alternatives}</p>
                                )}
                                {f.notes && (
                                  <p className="text-[11px] text-gray-400 leading-5">{f.notes}</p>
                                )}
                              </div>
                            </li>
                          ))}
                        </ul>
                      )}
                      {meal.notes && (
                        <p className="mt-1.5 text-[11px] text-gray-400 leading-5">{meal.notes}</p>
                      )}
                    </div>
                  );
                })}
              </div>
            )}
            {/* Diet tips (student-facing) */}
            {dietProgramTips.length > 0 && (
              <div className="rounded-xl border border-amber-100 bg-amber-50/20 p-4 break-inside-avoid">
                <div className="flex items-center gap-1.5 text-amber-700">
                  <Lightbulb size={15} />
                  <span className="text-sm font-semibold">نکات اجرایی</span>
                </div>
                <div className="mt-2 space-y-2">
                  {dietProgramTips.map((pt, ti) => {
                    const tip = dietTips.find((d) => d.id === pt.tip_id);
                    const category = tip?.category ?? 'custom';
                    return (
                      <div key={pt.id} className="break-inside-avoid">
                        <div className="flex items-center gap-2">
                          <span className="text-[10px] rounded-full bg-amber-100 px-2 py-0.5 text-amber-700 font-medium">
                            {DIET_TIP_CATEGORY_LABELS[category as DietTipCategory] ?? category}
                          </span>
                          {tip?.title && <span className="text-xs font-semibold text-gray-700">{tip.title}</span>}
                        </div>
                        <p className="mt-0.5 text-xs text-gray-600 leading-6">{pt.custom_text}</p>
                      </div>
                    );
                  })}
                </div>
              </div>
            )}
            {program?.custom_description && (
              <div>
                <p className="text-xs text-gray-400">توضیحات تکمیلی</p>
                <p className="text-sm text-gray-600 mt-0.5 leading-7 whitespace-pre-wrap">
                  {program.custom_description}
                </p>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}

function InfoTile({
  icon,
  label,
  value,
}: {
  icon?: React.ReactNode;
  label: string;
  value: string;
}) {
  return (
    <div className="rounded-xl border border-gray-100 bg-white p-4 shadow-card">
      <div className="flex items-center gap-1.5 text-gray-400">
        {icon}
        <span className="text-xs">{label}</span>
      </div>
      <p className="mt-1.5 text-sm font-semibold text-gray-800 truncate">{value}</p>
    </div>
  );
}

const PROG_STATUS_LABELS: Record<string, string> = {
  none: 'طراحی نشده',
  draft: 'پیش‌نویس',
  completed: 'تکمیل شده',
};
const PROG_STATUS_CLASSES: Record<string, string> = {
  none: 'bg-gray-100 text-gray-500',
  draft: 'bg-amber-50 text-amber-700',
  completed: 'bg-emerald-50 text-emerald-700',
};
function ProgramStatusBadge({ status }: { status: 'none' | 'draft' | 'completed' }) {
  return <span className={`inline-flex rounded-full px-2.5 py-0.5 text-[10px] font-medium ${PROG_STATUS_CLASSES[status] ?? PROG_STATUS_CLASSES.none}`}>{PROG_STATUS_LABELS[status] ?? PROG_STATUS_LABELS.none}</span>;
}

function ProgramExerciseList({ programExercises }: { programExercises: ProgramExercise[] }) {
  const [activeExercise, setActiveExercise] = useState<ProgramExercise | null>(null);
  const days = useMemo(() => {
    const seen: string[] = [];
    for (const pe of programExercises) {
      if (!seen.includes(pe.day_label)) seen.push(pe.day_label);
    }
    return seen.length > 0 ? seen : [''];
  }, [programExercises]);
  return (
    <div className="space-y-3">
      {days.map((day) => {
        const items = programExercises.filter((pe) => pe.day_label === day);
        if (items.length === 0) return null;
        return (
          <div key={day} className="rounded-xl border border-gray-100 bg-gray-50/40 p-3">
            {day && <p className="text-xs font-semibold text-gray-600 mb-2">{day}</p>}
            <div className="space-y-1.5">
              {items.map((pe, i) => (
                <div key={pe.id} className="rounded-lg border border-gray-100 bg-white p-3 break-inside-avoid">
                  <div className="flex items-start gap-2">
                    <span className="text-xs font-bold text-gray-400 mt-0.5">{(i + 1).toLocaleString('fa-IR')}</span>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 flex-wrap">
                        {pe.exercise_video_url ? (
                          <>
                            <button
                              type="button"
                              onClick={() => setActiveExercise((cur) => cur?.id === pe.id ? null : pe)}
                              className="no-print text-right text-sm font-medium text-gray-800 hover:text-brand-700 transition-colors"
                            >
                              {pe.exercise_name_fa || pe.exercise_name_en}
                            </button>
                          </>
                        ) : (
                          <span className="text-sm font-medium text-gray-800">
                            {pe.exercise_name_fa || pe.exercise_name_en}
                          </span>
                        )}
                      </div>
                      <div className="mt-1 flex items-center gap-3 text-[11px] text-gray-500">
                        {pe.sets != null && <span>{pe.sets} ست</span>}
                        {pe.reps && <span>{pe.reps} تکرار</span>}
                        {pe.rest_seconds != null && <span>{pe.rest_seconds}s استراحت</span>}
                        {pe.rpe != null && <span>RPE {pe.rpe}</span>}
                      </div>
                      {pe.coach_notes && (
                        <p className="mt-1 text-[11px] text-gray-400 leading-5">{pe.coach_notes}</p>
                      )}
                      {pe.exercise_video_url && (
                        <a
                          href={pe.exercise_video_url}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="no-print mt-1 inline-flex items-center gap-1 text-[10px] font-medium text-blue-600 hover:text-blue-700"
                        >
                          <PlayCircle size={11} />
                          مشاهده ویدئو
                        </a>
                      )}
                    </div>
                    {pe.exercise_video_url && (
                      <a
                        href={pe.exercise_video_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="no-print shrink-0 rounded-lg bg-blue-50 px-2 py-1 text-[10px] font-medium text-blue-700 hover:bg-blue-100 transition-colors"
                      >
                        تب جدید
                      </a>
                    )}
                  </div>
                  {activeExercise?.id === pe.id && (
                    <div className="no-print">
                      <InlineExerciseVideo
                        videoUrl={pe.exercise_video_url}
                        nameFa={pe.exercise_name_fa}
                        nameEn={pe.exercise_name_en}
                      />
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        );
      })}
    </div>
  );
}

function InlineExerciseVideo({ videoUrl, nameFa, nameEn }: { videoUrl: string; nameFa: string; nameEn: string }) {
  const embedUrl = getEmbedUrl(videoUrl);
  return (
    <div className="mt-3 rounded-xl border border-gray-100 bg-gray-50/60 p-3">
      <div className="mb-2 flex items-center gap-1.5 text-gray-500">
        <PlayCircle size={14} />
        <span className="text-xs">پخش ویدئو — {nameFa || nameEn}</span>
      </div>
      {embedUrl ? (
        <div className="overflow-hidden rounded-lg bg-black" style={{ aspectRatio: '16 / 9' }}>
          <iframe
            src={embedUrl}
            title={`ویدئو ${nameFa || nameEn}`}
            allow="autoplay; encrypted-media; picture-in-picture"
            allowFullScreen
            className="h-full w-full"
            loading="lazy"
          />
        </div>
      ) : (
        <div className="rounded-lg border border-dashed border-gray-200 bg-white p-4 text-center">
          <p className="text-xs text-gray-500 leading-6">
            این لینک قابل پخش مستقیم نیست. ممکن است لینک نامعتبر باشد یا سایت میزمان اجازه‌ی نمایش داخل پنل را ندهد.
          </p>
          <a
            href={videoUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="mt-2 inline-flex items-center gap-1 rounded-lg bg-blue-50 px-3 py-1.5 text-xs font-medium text-blue-700 hover:bg-blue-100 transition-colors"
          >
            <ExternalLink size={12} />
            مشاهده در تب جدید
          </a>
        </div>
      )}
      <p className="mt-2 text-[10px] text-gray-400 leading-5">
        اگر ویدئو نمایش داده نشد، فایل ممکن است خصوصی باشد. برای Google Drive، دسترسی «هر کسی با لینک» را فعال کنید. برای YouTube باید ویدئو عمومی یا «بدون فهرست‌بندی» باشد.
      </p>
    </div>
  );
}

function PdfExportMenu({ onExport }: { onExport: (mode: PrintMode) => void }) {
  const [open, setOpen] = useState(false);
  return (
    <div className="relative">
      <button
        onClick={() => setOpen((v) => !v)}
        className="flex items-center gap-1.5 rounded-xl bg-brand-600 px-4 py-2 text-sm font-medium text-white hover:bg-brand-700 transition-colors"
      >
        <FileDown size={15} />
        خروجی PDF
      </button>
      {open && (
        <>
          <div className="fixed inset-0 z-40" onClick={() => setOpen(false)} />
          <div className="absolute left-0 z-50 mt-2 w-52 rounded-xl border border-gray-100 bg-white shadow-cardHover p-1.5">
            <button
              onClick={() => { onExport('full'); setOpen(false); }}
              className="flex w-full items-center gap-2 rounded-lg px-3 py-2.5 text-right text-sm text-gray-700 hover:bg-gray-50 transition-colors"
            >
              <FileDown size={15} className="text-brand-600" />
              <div>
                <p className="font-medium">PDF کامل</p>
                <p className="text-[10px] text-gray-400">برنامه تمرینی، غذایی و نکات</p>
              </div>
            </button>
            <button
              onClick={() => { onExport('diet'); setOpen(false); }}
              className="flex w-full items-center gap-2 rounded-lg px-3 py-2.5 text-right text-sm text-gray-700 hover:bg-gray-50 transition-colors"
            >
              <Apple size={15} className="text-brand-600" />
              <div>
                <p className="font-medium">PDF برنامه غذایی</p>
                <p className="text-[10px] text-gray-400">وعده‌ها، مواد غذایی و نکات</p>
              </div>
            </button>
            <button
              onClick={() => { onExport('tips'); setOpen(false); }}
              className="flex w-full items-center gap-2 rounded-lg px-3 py-2.5 text-right text-sm text-gray-700 hover:bg-gray-50 transition-colors"
            >
              <Lightbulb size={15} className="text-amber-500" />
              <div>
                <p className="font-medium">PDF نکات اجرایی</p>
                <p className="text-[10px] text-gray-400">فقط توصیه‌های انتخاب‌شده</p>
              </div>
            </button>
          </div>
        </>
      )}
    </div>
  );
}

function Header({ title, subtitle }: { title: string; subtitle?: string }) {
  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-800">{title}</h1>
      {subtitle && <p className="text-sm text-gray-500 mt-1">{subtitle}</p>}
    </div>
  );
}

function formatDate(iso: string): string {
  return formatJalaliLong(iso);
}
