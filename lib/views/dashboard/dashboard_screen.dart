import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/clay_theme.dart';
import '../../core/constants/weekly_medical_data.dart';
import '../../core/constants/medical_specs.dart';
import '../../services/database_helper.dart';
import '../../services/medical_calculator.dart';
import '../../models/profile_model.dart';
import '../../models/daily_log_model.dart';
import '../../utils/date_utils.dart';
import 'widgets/profile_edit_sheet.dart';
import 'widgets/animated_womb_baby_widget.dart';

/// Aura Pregnancy - Sade, Ferah & Romantik Ana Sayfa (Dashboard)
class DashboardScreen extends StatefulWidget {
  final Function(int) onNavigateTab;

  const DashboardScreen({super.key, required this.onNavigateTab});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ProfileModel? _profile;
  DailyLogModel? _todayLog;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
    DatabaseHelper.appDataRevision.addListener(_onAppDataChanged);
  }

  void _onAppDataChanged() {
    if (mounted) {
      _loadDashboardData();
    }
  }

  @override
  void dispose() {
    DatabaseHelper.appDataRevision.removeListener(_onAppDataChanged);
    super.dispose();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    try {
      _profile = await DatabaseHelper.instance.getProfile();
      final today = AppDateUtils.todayIso();
      _todayLog = await DatabaseHelper.instance.getOrCreateDailyLog(today);
    } catch (e) {
      debugPrint('Dashboard load error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _openProfileEditor() {
    if (_profile == null) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ProfileEditSheet(
        profile: _profile!,
        onSaved: _loadDashboardData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primaryPink)),
      );
    }

    final currentWeek = _profile?.currentWeek ?? 12;
    final dueDateStr = _profile?.dueDate ?? '2026-10-15';
    final daysRemaining = AppDateUtils.daysUntil(dueDateStr);
    final weekData = WeeklyMedicalData.getInfoForWeek(currentWeek);
    final babyName = _profile?.babyDisplayName ?? 'Bebeğiniz';
    final momName = _profile?.momName ?? 'Anne Adayı';

    // Detaylı Yaş Hesaplama (Kaçıncı haftanın kaçıncı gününde)
    DateTime lmpDate;
    if (_profile?.lmpDate != null && _profile!.lmpDate!.isNotEmpty) {
      lmpDate = DateTime.tryParse(_profile!.lmpDate!) ?? DateTime.now().subtract(Duration(days: (currentWeek - 1) * 7));
    } else {
      lmpDate = DateTime.now().subtract(Duration(days: (currentWeek - 1) * 7));
    }
    final detailedAge = MedicalCalculator.getDetailedPregnancyAge(lmpDate);
    final weekNumber = detailedAge['weeks'] ?? currentWeek;
    final dayNumber = (detailedAge['days'] ?? 0) + 1; // 1-7. Gün
    final trimester = MedicalCalculator.getTrimester(weekNumber);

    // Bu Haftanın Tıbbi Testi Var mı? (Yoksa alan tamamen gizlenir)
    final medicalMilestone = PregnancyMedicalSpecs.medicalMilestones[weekNumber];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🌸 Hoş Geldin, $momName',
              style: const TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            Text(
              AppDateUtils.formatToday(),
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Profil Ayarları',
            icon: const Icon(Icons.settings_suggest_rounded, color: AppColors.primaryDark),
            onPressed: _openProfileEditor,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () => widget.onNavigateTab(5), // Acil Durum sekmesi
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.medicalAlertBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.medicalAlertRed, width: 1.2),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🚨', style: TextStyle(fontSize: 13)),
                    SizedBox(width: 4),
                    Text(
                      'Acil',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.medicalAlertRed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadDashboardData,
          color: AppColors.primaryPink,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. ANNE KARNINDA HAREKETLİ BEBEK ANİMASYONU KARTI
                ClayCard(
                  color: AppColors.clayCardSurface,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  onTap: () => widget.onNavigateTab(1), // Haftalık Detay sekmesine
                  child: Column(
                    children: [
                      // Üst Trimester ve Doğuma Kalan Rozetleri
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.clayLavender,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.lavenderPurple.withOpacity(0.25)),
                            ),
                            child: Text(
                              '$trimester. Trimester',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.lavenderPurple,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.clayRose,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.primaryPink.withOpacity(0.25)),
                            ),
                            child: Row(
                              children: [
                                const Text('⏳', style: TextStyle(fontSize: 12)),
                                const SizedBox(width: 4),
                                Text(
                                  'Doğuma $daysRemaining Gün',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Hareketli Uterus / Amniyotik Bebek Görseli
                      AnimatedWombBabyWidget(
                        currentWeek: weekNumber,
                        babyName: babyName,
                        gender: _profile?.babyGender ?? 'surprise',
                      ),
                      const SizedBox(height: 18),

                      // Kaçıncı Haftanın Kaçıncı Gününde Başlığı
                      Text(
                        '$weekNumber. Hafta + $dayNumber. Gün',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryDark,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Bebeğin Meyve Büyüklüğü
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.clayPeach,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(weekData['fruit'] as String? ?? '🍋', style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Text(
                              'Bebeğiniz ${weekData['fruit_name']} Büyüklüğünde',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Boy & Kilo Detayı
                      Text(
                        'Ortalama Boy: ${weekData['size_cm']} cm  •  Ağırlık: ~${weekData['weight_gr']} gr',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 2. HAFTANIN YAPILMASI GEREKEN TIBBİ TESTİ / KONTROLÜ (VARSA GÖSTER, YOKSA GİZLE)
                if (medicalMilestone != null) ...[
                  ClayCard(
                    color: const Color(0xFFFFF3E0), // Sıcak uyarı turuncusu
                    padding: const EdgeInsets.all(16),
                    onTap: () => widget.onNavigateTab(1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: ClayTheme.clayDecoration(
                            color: Colors.white,
                            borderRadius: 14,
                          ),
                          child: const Center(
                            child: Text('🩺', style: TextStyle(fontSize: 22)),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE65100),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Bu Haftanın Tıbbi Testi',
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                medicalMilestone['test'] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF5D4037),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                medicalMilestone['desc'] ?? '',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF795548),
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFFE65100)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // 3. HAMİLELİĞİN BU GÜNÜ & DİNGİN GÜNLÜK ÖZET KARTI
                ClayCard(
                  color: AppColors.clayRose,
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text('✨', style: TextStyle(fontSize: 18)),
                          SizedBox(width: 8),
                          Text(
                            'Hamileliğin Bu Günü',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        weekData['summary'] as String? ??
                            'Bugün bebeğinle sakin ve huzurlu bir bağ kur. Derin nefes al ve minik kalbin atışlarını hisset.',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClayButton(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            onPressed: () => widget.onNavigateTab(2), // Günlük Takip Sekmesine
                            child: const Row(
                              children: [
                                Text('Günlük Rutinleri İncele', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primaryPink)),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.primaryPink),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
