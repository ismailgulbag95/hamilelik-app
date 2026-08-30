import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../controllers/weekly_panel_controller.dart';
import '../../services/database_helper.dart';
import 'widgets/weekly_timeline_strip.dart';
import 'widgets/pregnancy_journey_tracker.dart';
import 'widgets/baby_growth_card.dart';
import 'widgets/medical_tests_checklist_card.dart';
import 'widgets/ad_reward_dialog.dart';

/// Hafta Hafta Tıbbi Bilgilendirme ve Test Takvimi Ekranı
class WeeklyPanelScreen extends StatefulWidget {
  const WeeklyPanelScreen({super.key});

  @override
  State<WeeklyPanelScreen> createState() => _WeeklyPanelScreenState();
}

class _WeeklyPanelScreenState extends State<WeeklyPanelScreen> {
  final WeeklyPanelController _controller = WeeklyPanelController();

  @override
  void initState() {
    super.initState();
    _controller.loadProfileWeek();
    _controller.addListener(() => setState(() {}));
    DatabaseHelper.appDataRevision.addListener(_onAppDataChanged);
  }

  void _onAppDataChanged() {
    if (mounted) {
      _controller.loadProfileWeek();
    }
  }

  @override
  void dispose() {
    DatabaseHelper.appDataRevision.removeListener(_onAppDataChanged);
    _controller.dispose();
    super.dispose();
  }

  int _getStageIndexForWeek(int week) {
    if (week <= 5) return 0;   // Haşhaş Tohumu (4-5. Hafta)
    if (week <= 8) return 1;   // Yaban Mersini (6-8. Hafta)
    if (week <= 10) return 2;  // Çilek / Zeytin (9-10. Hafta)
    if (week <= 13) return 3;  // Limon / İncir (11-13. Hafta)
    if (week <= 16) return 4;  // Avokado (14-16. Hafta)
    if (week <= 20) return 5;  // Muz / Mango (17-20. Hafta)
    if (week <= 24) return 6;  // Patlıcan / Mısır (21-24. Hafta)
    if (week <= 27) return 7;  // Hindistan Cevizi (25-27. Hafta)
    if (week <= 32) return 8;  // Ananas / Lahana (28-32. Hafta)
    if (week <= 36) return 9;  // Kavun / Kereviz (33-36. Hafta)
    return 10;                 // Bal Kabağı / Bebek (37-40. Hafta)
  }

  void _handleLockedWeekTapped(int week) {
    AdRewardDialog.show(
      context: context,
      title: '$week. Hafta İçeriğini Aç',
      subtitle: '$week. haftadaki bebeğinizin boyutunu, organ gelişimini ve yapılması gereken testleri görüntülemek için kısa bir video izleyin.',
      unlockTargetName: '$week. Hafta Rehberi',
      onRewardEarned: () {
        _controller.unlockWeek(week);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primaryPink)),
      );
    }

    final data = _controller.currentWeekData;
    final milestoneTest = data['milestone_test'] as Map<String, dynamic>?;
    final stageIndex = _getStageIndexForWeek(_controller.selectedWeek);
    final babyDisplayName = _controller.profile?.babyDisplayName;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              '${_controller.selectedWeek}. Hafta Rehberi',
              style: const TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            Text(
              '${_controller.selectedTrimester}. Trimester (${_controller.selectedWeek <= _controller.actualPregnancyWeek ? "Mevcut/Geçmiş" : "Gelecek"})',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1-40 Hafta Kaydırılabilir Şerit (Gelecek Haftalar Reklam Kilitli)
            WeeklyTimelineStrip(
              selectedWeek: _controller.selectedWeek,
              currentWeek: _controller.actualPregnancyWeek,
              unlockedWeeks: _controller.unlockedWeeks,
              onWeekSelected: (w) => _controller.selectWeek(w),
              onLockedWeekTapped: (w) => _handleLockedWeekTapped(w),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 3D Claymorphic Fetal Journey Tracker (Gelecek Meyveler Gizli + Soru İşaretli Reklam Kutusu)
                    PregnancyJourneyTracker(
                      currentWeek: _controller.actualPregnancyWeek,
                      initialIndex: stageIndex,
                    ),
                    const SizedBox(height: 16),

                    // Tıbbi Tarama & Test Takip Kartı (Varsa)
                    if (milestoneTest != null) ...[
                      MedicalTestsChecklistCard(
                        milestoneTest: milestoneTest,
                        week: _controller.selectedWeek,
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Bebek Büyüklüğü ve Gelişim Kartı
                    BabyGrowthCard(
                      week: _controller.selectedWeek,
                      weekData: data,
                      babyDisplayName: babyDisplayName,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
