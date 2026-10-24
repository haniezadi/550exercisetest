import { Users, UserCheck, UserX, Inbox, ClipboardEdit, CreditCard, Dumbbell, CheckCircle2, RefreshCw } from 'lucide-react';
import type { Student, StudentPlan, AssignedProgram, IntakeRequest } from '@/lib/supabase';

export type StudentStatFilter =
  | 'all'
  | 'active'
  | 'inactive'
  | 'new_requests'
  | 'needs_info'
  | 'awaiting_payment'
  | 'program_draft'
  | 'program_ready'
  | 'needs_renewal';

interface StatsCardsProps {
  students: Student[];
  plans: StudentPlan[];
  programs: AssignedProgram[];
  requests: IntakeRequest[];
  activeFilter: StudentStatFilter;
  onFilter: (f: StudentStatFilter) => void;
}

// A student is "active" if they have at least one plan that is active or expiring.
function isStudentActive(studentId: string, plans: StudentPlan[]): boolean {
  return plans.some(
    (p) => p.student_id === studentId && (p.plan_status === 'active' || p.plan_status === 'expiring'),
  );
}

// A student needs renewal if they have an expired plan and no active/expiring plan.
function needsRenewal(studentId: string, plans: StudentPlan[]): boolean {
  const hasExpired = plans.some((p) => p.student_id === studentId && p.plan_status === 'expired');
  const hasActive = isStudentActive(studentId, plans);
  return hasExpired && !hasActive;
}

export default function StudentStatsCards({
  students,
  plans,
  programs,
  requests,
  activeFilter,
  onFilter,
}: StatsCardsProps) {
  const totalStudents = students.length;
  const activeStudents = students.filter((s) => isStudentActive(s.id, plans)).length;
  const inactiveStudents = totalStudents - activeStudents;

  const newRequests = requests.filter((r) => r.status === 'new').length;
  const needsInfo = requests.filter((r) => r.status === 'needs_info').length;

  // Students awaiting payment: have a plan with payment_status 'unpaid' or 'partial'
  const studentIdsWithUnpaid = new Set(
    plans
      .filter((p) => (p.payment_status === 'unpaid' || p.payment_status === 'partial') && (p.plan_status === 'active' || p.plan_status === 'expiring'))
      .map((p) => p.student_id),
  );
  const awaitingPayment = studentIdsWithUnpaid.size;

  // Programs in draft (workout or diet status is 'draft' or has program but no exercises)
  const programDrafts = programs.filter(
    (p) => p.workout_status === 'draft' || p.diet_status === 'draft',
  ).length;

  // Programs ready (both workout and diet completed)
  const programReady = programs.filter(
    (p) => p.workout_status === 'completed' && p.diet_status === 'completed',
  ).length;

  // Students needing renewal
  const renewalStudents = students.filter((s) => needsRenewal(s.id, plans)).length;

  const cards: Array<{
    key: StudentStatFilter;
    label: string;
    value: number;
    icon: React.ReactNode;
    accent: string;
    isCount: 'students' | 'programs' | 'requests';
  }> = [
    { key: 'all', label: 'کل شاگردها', value: totalStudents, icon: <Users size={18} />, accent: 'brand', isCount: 'students' },
    { key: 'active', label: 'شاگردهای فعال', value: activeStudents, icon: <UserCheck size={18} />, accent: 'emerald', isCount: 'students' },
    { key: 'inactive', label: 'شاگردهای غیرفعال', value: inactiveStudents, icon: <UserX size={18} />, accent: 'gray', isCount: 'students' },
    { key: 'new_requests', label: 'درخواست‌های جدید', value: newRequests, icon: <Inbox size={18} />, accent: 'blue', isCount: 'requests' },
    { key: 'needs_info', label: 'منتظر تکمیل اطلاعات', value: needsInfo, icon: <ClipboardEdit size={18} />, accent: 'orange', isCount: 'requests' },
    { key: 'awaiting_payment', label: 'منتظر پرداخت', value: awaitingPayment, icon: <CreditCard size={18} />, accent: 'amber', isCount: 'students' },
    { key: 'program_draft', label: 'برنامه‌های نیمه‌تمام', value: programDrafts, icon: <Dumbbell size={18} />, accent: 'blue', isCount: 'programs' },
    { key: 'program_ready', label: 'برنامه‌های آماده تحویل', value: programReady, icon: <CheckCircle2 size={18} />, accent: 'emerald', isCount: 'programs' },
    { key: 'needs_renewal', label: 'نیازمند تمدید', value: renewalStudents, icon: <RefreshCw size={18} />, accent: 'red', isCount: 'students' },
  ];

  const accentClasses: Record<string, string> = {
    brand: 'bg-brand-50 text-brand-700',
    emerald: 'bg-emerald-50 text-emerald-700',
    gray: 'bg-gray-100 text-gray-600',
    blue: 'bg-blue-50 text-blue-700',
    orange: 'bg-orange-50 text-orange-700',
    amber: 'bg-amber-50 text-amber-700',
    red: 'bg-red-50 text-red-700',
  };

  return (
    <div className="grid grid-cols-3 gap-3">
      {cards.map((c) => {
        const isActive = activeFilter === c.key;
        return (
          <button
            key={c.key}
            onClick={() => onFilter(isActive ? 'all' : c.key)}
            className={`text-right rounded-2xl border p-4 transition-all ${
              isActive
                ? 'border-brand-500 bg-brand-50 ring-2 ring-brand-100'
                : 'border-gray-100 bg-white hover:border-gray-200 hover:shadow-card'
            }`}
          >
            <div className="flex items-center justify-between">
              <div className={`flex h-9 w-9 items-center justify-center rounded-xl ${accentClasses[c.accent]}`}>
                {c.icon}
              </div>
              <span className="text-2xl font-bold text-gray-800">{c.value}</span>
            </div>
            <p className="mt-2 text-xs font-medium text-gray-600">{c.label}</p>
            <p className="mt-0.5 text-[10px] text-gray-400">
              {c.isCount === 'students' ? 'تعداد شاگرد' : c.isCount === 'programs' ? 'تعداد برنامه' : 'تعداد درخواست'}
            </p>
          </button>
        );
      })}
    </div>
  );
}

// Export helper for filtering students based on stat filter
export function filterStudentsByStat(
  students: Student[],
  plans: StudentPlan[],
  programs: AssignedProgram[],
  requests: IntakeRequest[],
  filter: StudentStatFilter,
): Set<string> {
  if (filter === 'all') return new Set(students.map((s) => s.id));

  if (filter === 'active') {
    return new Set(students.filter((s) => isStudentActive(s.id, plans)).map((s) => s.id));
  }
  if (filter === 'inactive') {
    return new Set(students.filter((s) => !isStudentActive(s.id, plans)).map((s) => s.id));
  }
  if (filter === 'awaiting_payment') {
    return new Set(
      plans
        .filter((p) => (p.payment_status === 'unpaid' || p.payment_status === 'partial') && (p.plan_status === 'active' || p.plan_status === 'expiring'))
        .map((p) => p.student_id),
    );
  }
  if (filter === 'needs_renewal') {
    return new Set(students.filter((s) => needsRenewal(s.id, plans)).map((s) => s.id));
  }
  if (filter === 'new_requests') {
    // Students whose source_request_id maps to a 'new' request
    const newReqIds = new Set(requests.filter((r) => r.status === 'new').map((r) => r.id));
    return new Set(students.filter((s) => s.source_request_id && newReqIds.has(s.source_request_id)).map((s) => s.id));
  }
  if (filter === 'needs_info') {
    const infoReqIds = new Set(requests.filter((r) => r.status === 'needs_info').map((r) => r.id));
    return new Set(students.filter((s) => s.source_request_id && infoReqIds.has(s.source_request_id)).map((s) => s.id));
  }
  if (filter === 'program_draft') {
    // Students whose program has draft status
    return new Set(
      programs
        .filter((p) => p.workout_status === 'draft' || p.diet_status === 'draft')
        .map((p) => p.student_id),
    );
  }
  if (filter === 'program_ready') {
    return new Set(
      programs
        .filter((p) => p.workout_status === 'completed' && p.diet_status === 'completed')
        .map((p) => p.student_id),
    );
  }
  return new Set(students.map((s) => s.id));
}

// --- Multi-filter system ---

export type PlanStatusFilter = 'all' | 'active' | 'expiring' | 'expired' | 'none';
export type PaymentFilter = 'all' | 'paid' | 'unpaid' | 'partial';
export type ProgramStatusFilter = 'all' | 'draft' | 'completed' | 'none';
export type RequestStageFilter = 'all' | 'new' | 'needs_info' | 'reviewing' | 'approved' | 'none';
export type StudentSort = 'created_desc' | 'created_asc' | 'updated_desc' | 'plan_end_asc';

export interface MultiFilter {
  planStatus: PlanStatusFilter;
  payment: PaymentFilter;
  programStatus: ProgramStatusFilter;
  requestStage: RequestStageFilter;
  sort: StudentSort;
}

export const DEFAULT_MULTI_FILTER: MultiFilter = {
  planStatus: 'all',
  payment: 'all',
  programStatus: 'all',
  requestStage: 'all',
  sort: 'created_desc',
};

export function hasActiveMultiFilter(mf: MultiFilter): boolean {
  return (
    mf.planStatus !== 'all' ||
    mf.payment !== 'all' ||
    mf.programStatus !== 'all' ||
    mf.requestStage !== 'all'
  );
}

// Apply multi-filter dimensions on top of the stat-card + search results.
// Each dimension is AND-combined. Returns the filtered student list.
export function applyMultiFilter(
  students: Student[],
  plans: StudentPlan[],
  programs: AssignedProgram[],
  requests: IntakeRequest[],
  mf: MultiFilter,
): Student[] {
  let list = [...students];

  // Plan status
  if (mf.planStatus !== 'all') {
    if (mf.planStatus === 'none') {
      const withPlan = new Set(plans.map((p) => p.student_id));
      list = list.filter((s) => !withPlan.has(s.id));
    } else {
      const ids = new Set(
        plans.filter((p) => p.plan_status === mf.planStatus).map((p) => p.student_id),
      );
      list = list.filter((s) => ids.has(s.id));
    }
  }

  // Payment status
  if (mf.payment !== 'all') {
    const ids = new Set(
      plans
        .filter((p) => p.payment_status === mf.payment && (p.plan_status === 'active' || p.plan_status === 'expiring'))
        .map((p) => p.student_id),
    );
    list = list.filter((s) => ids.has(s.id));
  }

  // Program status
  if (mf.programStatus !== 'all') {
    const progByStudent = new Map<string, AssignedProgram>();
    for (const p of programs) progByStudent.set(p.student_id, p);
    if (mf.programStatus === 'none') {
      list = list.filter((s) => !progByStudent.has(s.id));
    } else if (mf.programStatus === 'draft') {
      list = list.filter((s) => {
        const p = progByStudent.get(s.id);
        return p && (p.workout_status === 'draft' || p.diet_status === 'draft');
      });
    } else if (mf.programStatus === 'completed') {
      list = list.filter((s) => {
        const p = progByStudent.get(s.id);
        return p && p.workout_status === 'completed' && p.diet_status === 'completed';
      });
    }
  }

  // Request stage
  if (mf.requestStage !== 'all') {
    if (mf.requestStage === 'none') {
      list = list.filter((s) => !s.source_request_id);
    } else {
      const reqIds = new Set(
        requests.filter((r) => r.status === mf.requestStage).map((r) => r.id),
      );
      list = list.filter((s) => s.source_request_id && reqIds.has(s.source_request_id));
    }
  }

  // Sort
  switch (mf.sort) {
    case 'created_asc':
      list.sort((a, b) => a.created_at.localeCompare(b.created_at));
      break;
    case 'updated_desc': {
      const latestUpdate = (sid: string) => {
        const prog = programs.find((p) => p.student_id === sid);
        const plan = plans
          .filter((p) => p.student_id === sid)
          .sort((a, b) => b.updated_at.localeCompare(a.updated_at))[0];
        const candidates = [prog?.updated_at ?? '', plan?.updated_at ?? ''];
        return candidates.sort().reverse()[0] ?? '';
      };
      list.sort((a, b) => latestUpdate(b.id).localeCompare(latestUpdate(a.id)));
      break;
    }
    case 'plan_end_asc': {
      const earliestEnd = (sid: string) => {
        const studentPlans = plans.filter((p) => p.student_id === sid);
        if (studentPlans.length === 0) return '9999-12-31';
        return studentPlans.sort((a, b) => a.end_date.localeCompare(b.end_date))[0].end_date;
      };
      list.sort((a, b) => earliestEnd(a.id).localeCompare(earliestEnd(b.id)));
      break;
    }
    case 'created_desc':
    default:
      list.sort((a, b) => b.created_at.localeCompare(a.created_at));
      break;
  }

  return list;
}
