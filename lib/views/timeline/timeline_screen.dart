import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/clay_theme.dart';
import '../../models/daily_log_model.dart';
import '../../models/diary_model.dart';
import '../../models/profile_model.dart';
import '../../models/timeline_day_entry.dart';
import '../../services/database_helper.dart';
import '../../utils/date_utils.dart';
import '../journal/widgets/journal_entry_card.dart';
import '../journal/new_entry_screen.dart';

enum TimelineFilter { all, diaries, steps, waterCaffeine, weight }

/// Aura Pregnancy - Birleştirilmiş Girişler Zaman Tüneli (Timeline)
class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  ProfileModel? _profile;
  List<TimelineDayEntry> _timelineEntries = [];
  bool _isLoading = true;
  TimelineFilter _selectedFilter = TimelineFilter.all;

  // İstatistik Sayaçları
  int _totalSteps = 0;
  int _totalWaterMl = 0;
  int _totalDiariesCount = 0;
  int _totalAudioLettersCount = 0;

  @override
  void initState() {
    super.initState();
    _loadTimelineData();
    DatabaseHelper.appDataRevision.addListener(_onAppDataChanged);
  }

  void _onAppDataChanged() {
    if (mounted) {
      _loadTimelineData();
    }
  }

  @override
  void dispose() {
    DatabaseHelper.appDataRevision.removeListener(_onAppDataChanged);
    super.dispose();
  }

  Future<void> _loadTimelineData() async {
    setState(() => _isLoading = true);
    try {
      _profile = await DatabaseHelper.instance.getProfile();
      final currentWeek = _profile?.currentWeek ?? 12;

      final allLogs = await DatabaseHelper.instance.getAllDailyLogs();
      final allDiaries = await DatabaseHelper.instance.getAllDiaries();

      // İstatistik toplamları
      _totalSteps = allLogs.fold(0, (sum, log) => sum + log.stepCount);
      _totalWaterMl = allLogs.fold(0, (sum, log) => sum + log.waterIntakeMl);
      _totalDiariesCount = allDiaries.length;
      _totalAudioLettersCount = allDiaries.where((d) => d.audioPath != null && d.audioPath!.isNotEmpty).length;

      // Tarihlere göre birleştirme haritası
      final Map<String, TimelineDayEntry> map = {};

      // 1. Günlük Takipleri ekle
      for (final log in allLogs) {
        map[log.date] = TimelineDayEntry(
          date: log.date,
          pregnancyWeek: currentWeek,
          dailyLog: log,
          diaries: [],
        );
      }

      // 2. Anıları tarihlerine göre eşleştir
      for (final diary in allDiaries) {
        if (map.containsKey(diary.date)) {
          final existing = map[diary.date]!;
          map[diary.date] = TimelineDayEntry(
            date: diary.date,
            pregnancyWeek: diary.pregnancyWeek,
            dailyLog: existing.dailyLog,
            diaries: [...existing.diaries, diary],
          );
        } else {
          map[diary.date] = TimelineDayEntry(
            date: diary.date,
            pregnancyWeek: diary.pregnancyWeek,
            dailyLog: null,
            diaries: [diary],
          );
        }
      }

      // Bugünün tarihi haritada yoksa ekle
      final today = AppDateUtils.todayIso();
      if (!map.containsKey(today)) {
        final todayLog = await DatabaseHelper.instance.getOrCreateDailyLog(today);
        map[today] = TimelineDayEntry(
          date: today,
          pregnancyWeek: currentWeek,
          dailyLog: todayLog,
          diaries: [],
        );
      }

      // Tarihe göre sırala (En yeniden eskiye)
      final sortedList = map.values.toList();
      sortedList.sort((a, b) => b.date.compareTo(a.date));

      _timelineEntries = sortedList;
    } catch (e) {
      debugPrint('Timeline load error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<TimelineDayEntry> get _filteredEntries {
    switch (_selectedFilter) {
      case TimelineFilter.all:
        return _timelineEntries;
      case TimelineFilter.diaries:
        return _timelineEntries.where((e) => e.hasDiaries).toList();
      case TimelineFilter.steps:
        return _timelineEntries.where((e) => e.totalSteps > 0).toList();
      case TimelineFilter.waterCaffeine:
        return _timelineEntries.where((e) => e.totalWaterMl > 0 || e.totalCaffeineMg > 0).toList();
      case TimelineFilter.weight:
        return _timelineEntries.where((e) => e.weightEntry != null).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primaryPink)),
      );
    }

    final filtered = _filteredEntries;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'Yolculuk Akışı',
              style: TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            Text(
              'Hamilelik Serüveniniz & Günlük Kayıtlar',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadTimelineData,
        color: AppColors.primaryPink,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Genel İstatistik Hero Kartı
              _buildOverallSummaryCard(),
              const SizedBox(height: 16),

              // 2. Filtre Butonları (Chips)
              _buildFilterChips(),
              const SizedBox(height: 18),

              // 3. Zaman Tüneli Akışı
              if (filtered.isEmpty)
                _buildEmptyState()
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final dayEntry = filtered[index];
                    return _buildTimelineDayItem(dayEntry, isFirst: index == 0, isLast: index == filtered.length - 1);
                  },
                ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryPink,
        elevation: 4,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewEntryScreen(
                currentWeek: _profile?.currentWeek ?? 12,
                onSave: (entry) async {
                  await DatabaseHelper.instance.insertDiary(entry);
                  _loadTimelineData();
                },
              ),
            ),
          );
          _loadTimelineData();
        },
        icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
        label: const Text(
          'Anı Yaz',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
    );
  }

  /// Genel Toplam İstatistik Kartı
  Widget _buildOverallSummaryCard() {
    final distanceKm = (_totalSteps * 0.0007).toStringAsFixed(1);
    final waterLiters = (_totalWaterMl / 1000.0).toStringAsFixed(1);

    return ClayCard(
      color: AppColors.clayLavender,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('✨', style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text(
                'Hamilelik Yolculuğu Özeti',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryBox('👟 Toplam Adım', '$_totalSteps', '$distanceKm km mesafe', AppColors.clayMint),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryBox('💧 Toplam Su', '$waterLiters L', '$_totalWaterMl ml kayıt', AppColors.claySky),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildSummaryBox('📖 Toplam Anı', '$_totalDiariesCount Adet', 'Kaydedilen günlük', AppColors.clayRose),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryBox('🎙️ Sesli Mektup', '$_totalAudioLettersCount Adet', 'Bebeğe özel kayıt', AppColors.clayPeach),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String title, String mainValue, String subValue, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
          const SizedBox(height: 2),
          Text(mainValue, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.primaryDark)),
          Text(subValue, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  /// Filtreleme Butonları
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('🌟 Tümü', TimelineFilter.all),
          _buildFilterChip('📖 Anılar & Sesler', TimelineFilter.diaries),
          _buildFilterChip('👟 Yürüyüş & Adım', TimelineFilter.steps),
          _buildFilterChip('💧 Su & Kafein', TimelineFilter.waterCaffeine),
          _buildFilterChip('⚖️ Kilo Ölçümleri', TimelineFilter.weight),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, TimelineFilter filter) {
    final isSelected = _selectedFilter == filter;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = filter),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryPink : Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: isSelected ? AppColors.primaryPink.withOpacity(0.3) : Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  /// Zaman Tüneli Tek Bir Günlük Kartı
  Widget _buildTimelineDayItem(TimelineDayEntry day, {required bool isFirst, required bool isLast}) {
    final isToday = day.date == AppDateUtils.todayIso();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sol Dikey Çizgi ve Düğüm (Timeline Node)
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isToday ? AppColors.primaryPink : AppColors.clayRose,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPink.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  isToday ? '★' : '•',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: isToday ? Colors.white : AppColors.primaryPink,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 160 + (day.diaries.length * 120.0),
                color: AppColors.primaryPink.withOpacity(0.2),
              ),
          ],
        ),
        const SizedBox(width: 12),

        // Sağ Ana Kart Gövdesi
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ClayCard(
              color: isToday ? AppColors.clayRose : AppColors.clayCardSurface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gün Başlığı ve Hafta Rozeti
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            AppDateUtils.formatDisplay(day.date),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          if (isToday) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primaryPink,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('Bugün', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${day.pregnancyWeek}. Hafta',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.secondaryPeach),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Günlük Takip Rozetleri (Adım, Su, Kafein, Kilo)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (day.totalSteps > 0)
                        _buildBadgeChip('👟 ${day.totalSteps} Adım', AppColors.clayMint, AppColors.successGreen),
                      if (day.totalWaterMl > 0)
                        _buildBadgeChip('💧 ${day.totalWaterMl} ml Su', AppColors.claySky, AppColors.waterBlue),
                      if (day.totalCaffeineMg > 0)
                        _buildBadgeChip(
                          '☕ ${day.totalCaffeineMg} mg Kafein',
                          day.totalCaffeineMg > 200 ? AppColors.medicalAlertBg : AppColors.clayPeach,
                          day.totalCaffeineMg > 200 ? AppColors.medicalAlertRed : AppColors.secondaryPeach,
                        ),
                      if (day.weightEntry != null)
                        _buildBadgeChip('⚖️ ${day.weightEntry} kg', AppColors.clayLavender, AppColors.primaryDark),
                    ],
                  ),

                  // Semptom Notu (Varsa)
                  if (day.symptomNotes != null && day.symptomNotes!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Text('🩺', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              day.symptomNotes!,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Bu Güne Ait Anı Kartları (Varsa)
                  if (day.diaries.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: Colors.black12),
                    const SizedBox(height: 12),
                    ...day.diaries.map((diary) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: JournalEntryCard(
                          entry: diary,
                          onDelete: () async {
                            if (diary.id != null) {
                              await DatabaseHelper.instance.deleteDiary(diary.id!);
                              _loadTimelineData();
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeChip(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: textColor),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            const Text('🌸', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            const Text(
              'Bu kategoride henüz kayıt yok',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
            ),
            const SizedBox(height: 6),
            const Text(
              'Günlük takiplerinizi yaptıkça ve anı yazdıkça zaman tüneliniz burada güzelleşecek ✨',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
