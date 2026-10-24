import { Star, Play, ExternalLink, X, AlertTriangle, Dumbbell } from 'lucide-react';
import {
  type Exercise,
  EXERCISE_TYPE_LABELS,
  EXERCISE_TYPE_COLORS,
  EXERCISE_DIFFICULTY_LABELS,
  EXERCISE_DIFFICULTY_COLORS,
  EXERCISE_LOCATION_LABELS,
  getEmbedUrl,
  formatExerciseName,
} from '@/lib/supabase';

export default function ExerciseDetail({
  exercise,
  onClose,
}: {
  exercise: Exercise;
  onClose: () => void;
}) {
  const videoUrl = exercise.video_url || '';
  const embedUrl = videoUrl ? getEmbedUrl(videoUrl) : null;
  const isDrive = videoUrl.includes('drive.google.com');

  return (
    <div className="flex flex-col gap-4">
      <div className="flex items-start justify-between gap-2">
        <div className="flex-1">
          <h2 className="text-lg font-bold text-gray-800">{formatExerciseName(exercise)}</h2>
          <div className="mt-2 flex items-center gap-1.5 flex-wrap">
            <span className={`inline-flex rounded-full px-2.5 py-0.5 text-xs font-medium ${EXERCISE_TYPE_COLORS[exercise.exercise_type]}`}>
              {EXERCISE_TYPE_LABELS[exercise.exercise_type]}
            </span>
            <span className={`inline-flex rounded-full px-2.5 py-0.5 text-xs font-medium ${EXERCISE_DIFFICULTY_COLORS[exercise.difficulty]}`}>
              {EXERCISE_DIFFICULTY_LABELS[exercise.difficulty]}
            </span>
            <span className="inline-flex rounded-full bg-gray-100 px-2.5 py-0.5 text-xs font-medium text-gray-600">
              {EXERCISE_LOCATION_LABELS[exercise.location]}
            </span>
            {exercise.is_favorite && (
              <span className="inline-flex items-center gap-1 rounded-full bg-amber-50 px-2.5 py-0.5 text-xs font-medium text-amber-700">
                <Star size={12} className="fill-amber-500 text-amber-500" />
                پرکاربرد
              </span>
            )}
          </div>
        </div>
        <button onClick={onClose} className="p-1 rounded-lg text-gray-400 hover:text-gray-600 hover:bg-gray-50">
          <X size={20} />
        </button>
      </div>

      {/* Video */}
      {embedUrl ? (
        <div>
          {isDrive && (
            <div className="mb-2 flex items-center gap-2 rounded-lg bg-blue-50 px-3 py-2 text-xs text-blue-700">
              <AlertTriangle size={14} />
              اگر ویدئو نمایش داده نشد، ممکن است دسترسی خصوصی باشد. دکمه «باز کردن در تب جدید» را امتحان کنید.
            </div>
          )}
          <div className="overflow-hidden rounded-xl border border-gray-200" style={{ aspectRatio: '16/9' }}>
            <iframe
              src={embedUrl}
              allow="autoplay; fullscreen"
              className="h-full w-full"
              title={formatExerciseName(exercise)}
            />
          </div>
          <a
            href={videoUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="mt-2 flex items-center gap-1.5 text-xs text-brand-600 hover:text-brand-700"
          >
            <ExternalLink size={12} />
            باز کردن در تب جدید
          </a>
        </div>
      ) : (
        <div className="flex items-center justify-center rounded-xl border border-dashed border-gray-200 bg-gray-50 py-8">
          <div className="text-center">
            <Play className="mx-auto text-gray-300" size={28} />
            <p className="mt-2 text-xs text-gray-400">ویدئویی برای این حرکت ثبت نشده است.</p>
          </div>
        </div>
      )}

      {/* Muscles */}
      {exercise.primary_muscles.length > 0 && (
        <div>
          <p className="text-xs font-semibold text-gray-500">عضلات اصلی</p>
          <div className="mt-1.5 flex flex-wrap gap-1.5">
            {exercise.primary_muscles.map((m) => (
              <span key={m} className="rounded-lg bg-brand-50 px-2.5 py-1 text-xs font-medium text-brand-700">{m}</span>
            ))}
          </div>
        </div>
      )}
      {exercise.secondary_muscles.length > 0 && (
        <div>
          <p className="text-xs font-semibold text-gray-500">عضلات کمکی</p>
          <div className="mt-1.5 flex flex-wrap gap-1.5">
            {exercise.secondary_muscles.map((m) => (
              <span key={m} className="rounded-lg bg-gray-100 px-2.5 py-1 text-xs font-medium text-gray-600">{m}</span>
            ))}
          </div>
        </div>
      )}

      {/* Equipment */}
      {exercise.equipment.length > 0 && (
        <div>
          <p className="text-xs font-semibold text-gray-500">تجهیزات</p>
          <div className="mt-1.5 flex flex-wrap gap-1.5">
            {exercise.equipment.map((eq) => (
              <span key={eq} className="rounded-lg bg-blue-50 px-2.5 py-1 text-xs font-medium text-blue-700">{eq}</span>
            ))}
          </div>
        </div>
      )}

      {/* Instructions */}
      {exercise.instructions && (
        <div>
          <p className="text-xs font-semibold text-gray-500">روش اجرا</p>
          <p className="mt-1.5 text-sm leading-7 text-gray-700">{exercise.instructions}</p>
        </div>
      )}

      {/* Tips */}
      {exercise.tips && (
        <div>
          <p className="text-xs font-semibold text-gray-500">نکات و خطاهای رایج</p>
          <p className="mt-1.5 text-sm leading-7 text-gray-700">{exercise.tips}</p>
        </div>
      )}

      {/* Limitations */}
      {exercise.limitations && (
        <div>
          <p className="text-xs font-semibold text-gray-500">محدودیت‌ها</p>
          <p className="mt-1.5 text-sm leading-7 text-gray-700">{exercise.limitations}</p>
        </div>
      )}

      {/* Alternatives */}
      {exercise.alternative_names && (
        <div>
          <p className="text-xs font-semibold text-gray-500">حرکات جایگزین</p>
          <p className="mt-1.5 text-sm leading-7 text-gray-700">{exercise.alternative_names}</p>
        </div>
      )}

      {/* Tags */}
      {exercise.tags.length > 0 && (
        <div>
          <p className="text-xs font-semibold text-gray-500">برچسب‌ها</p>
          <div className="mt-1.5 flex flex-wrap gap-1.5">
            {exercise.tags.map((t) => (
              <span key={t} className="rounded-lg bg-gray-50 px-2 py-0.5 text-[10px] text-gray-500">{t}</span>
            ))}
          </div>
        </div>
      )}

      {/* Coach notes */}
      {exercise.coach_notes && (
        <div className="rounded-xl bg-amber-50/60 p-3">
          <p className="text-xs font-semibold text-amber-700">یادداشت مربی</p>
          <p className="mt-1 text-sm leading-7 text-amber-800">{exercise.coach_notes}</p>
        </div>
      )}

      <button
        onClick={onClose}
        className="self-start rounded-xl bg-gray-100 px-5 py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-200 transition-colors"
      >
        بستن
      </button>
    </div>
  );
}
