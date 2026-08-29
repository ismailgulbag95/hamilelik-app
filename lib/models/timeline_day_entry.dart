import 'daily_log_model.dart';
import 'diary_model.dart';

/// Aura Pregnancy - Birleştirilmiş Günlük Zaman Tüneli Modeli
class TimelineDayEntry {
  final String date;
  final int pregnancyWeek;
  final DailyLogModel? dailyLog;
  final List<DiaryModel> diaries;

  TimelineDayEntry({
    required this.date,
    required this.pregnancyWeek,
    this.dailyLog,
    this.diaries = const [],
  });

  bool get hasContent {
    final hasLog = dailyLog != null &&
        (dailyLog!.waterIntakeMl > 0 ||
            dailyLog!.caffeineMg > 0 ||
            dailyLog!.stepCount > 0 ||
            dailyLog!.weightEntry != null);
    return hasLog || diaries.isNotEmpty;
  }

  int get totalSteps => dailyLog?.stepCount ?? 0;
  int get totalWalkingMinutes => dailyLog?.walkingMinutes ?? 0;
  int get totalWaterMl => dailyLog?.waterIntakeMl ?? 0;
  int get totalCaffeineMg => dailyLog?.caffeineMg ?? 0;
  double? get weightEntry => dailyLog?.weightEntry;
  String? get symptomNotes => dailyLog?.symptomNotes;

  bool get hasDiaries => diaries.isNotEmpty;
  bool get hasPhotos => diaries.any((d) => d.photoPath != null && d.photoPath!.isNotEmpty);
  bool get hasAudios => diaries.any((d) => d.audioPath != null && d.audioPath!.isNotEmpty);
  bool get hasRomanticHighlight => diaries.any((d) => d.isRomanticHighlight);
}
