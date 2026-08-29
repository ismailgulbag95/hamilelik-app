import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';
import '../../../services/debug_seeder_service.dart';
import '../../journal/widgets/timelapse_video_dialog.dart';

/// Aura Pregnancy - Geliştirici & Test Kontrol Paneli (Debug Panel)
class DebugPanelBottomSheet extends StatefulWidget {
  final VoidCallback onDataChanged;

  const DebugPanelBottomSheet({super.key, required this.onDataChanged});

  @override
  State<DebugPanelBottomSheet> createState() => _DebugPanelBottomSheetState();
}

class _DebugPanelBottomSheetState extends State<DebugPanelBottomSheet> {
  Map<String, dynamic>? _stats;
  bool _isLoading = false;
  double _sliderWeek = 12.0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final stats = await DebugSeederService.instance.getDatabaseStats();
    if (mounted) {
      setState(() {
        _stats = stats;
        _sliderWeek = (stats['currentWeek'] as int).toDouble().clamp(1.0, 40.0);
      });
    }
  }

  Future<void> _seedData() async {
    setState(() => _isLoading = true);
    final result = await DebugSeederService.instance.seedFullPregnancyData();
    await _loadStats();
    widget.onDataChanged();
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.successGreen,
          content: Text('🎉 40 Haftalık Test Verisi Yüklendi (${result['logs']} Günlük Log, ${result['diaries']} Anı & Fotoğraf)'),
        ),
      );
    }
  }

  Future<void> _resetData() async {
    setState(() => _isLoading = true);
    await DebugSeederService.instance.resetAllDatabase();
    await _loadStats();
    widget.onDataChanged();
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.medicalAlertRed,
          content: Text('🗑️ Tüm veritabanı temizlendi ve sıfırlandı.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFDF7F4),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Üst Tutamaç
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Başlık
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('🛠️', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    Text(
                      'Geliştirici & Test Paneli',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2D232E),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE07A5F).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('DEBUG MODE', style: TextStyle(color: Color(0xFFE07A5F), fontWeight: FontWeight.w800, fontSize: 10)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Tüm sistemleri ve zaman tünelini test etmek için hızlı aksiyonlar:',
              style: TextStyle(fontSize: 11.5, color: Color(0xFF7A6E78), fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Canlı DB İstatistikleri Kartı
            if (_stats != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('📅 Hafta', '${_stats!['currentWeek']}'),
                    _buildStatItem('📝 Günlük Log', '${_stats!['totalLogs']}'),
                    _buildStatItem('📖 Anı & Not', '${_stats!['totalDiaries']}'),
                    _buildStatItem('📷 Fotoğraf', '${_stats!['totalPhotos']}'),
                  ],
                ),
              ),
            const SizedBox(height: 16),

            // 1. BUTON: 40 Haftalık Test Verisi Doldur
            ClayButton(
              color: const Color(0xFFD4EBD6), // Nane Yeşili
              onPressed: _isLoading ? null : _seedData,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🎲', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    _isLoading ? 'Yükleniyor...' : '40 Haftalık Test Verisi Doldur',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF2E6135),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // 2. BUTON: Time-lapse Video Hikayesi Oluştur & Oynat
            ClayButton(
              color: AppColors.clayRose,
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => const TimelapseVideoDialog(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🎬', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    'Time-lapse Video Oluştur & Oynat',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 3. HAFTA DEĞİŞTİRİCİ SLIDER
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '⏩ Aktif Haftayı Değiştir: ${_sliderWeek.toInt()}. Hafta',
                        style: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 13, color: const Color(0xFF2D232E)),
                      ),
                      Text(
                        _sliderWeek <= 12 ? '1. Trimester' : _sliderWeek <= 27 ? '2. Trimester' : '3. Trimester',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryPink),
                      ),
                    ],
                  ),
                  Slider(
                    value: _sliderWeek,
                    min: 1.0,
                    max: 40.0,
                    divisions: 39,
                    activeColor: AppColors.primaryPink,
                    inactiveColor: const Color(0xFFFDE8ED),
                    onChanged: (val) {
                      setState(() => _sliderWeek = val);
                    },
                    onChangeEnd: (val) async {
                      await DebugSeederService.instance.jumpToWeek(val.toInt());
                      await _loadStats();
                      widget.onDataChanged();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 4. BUTON: Veritabanını Sıfırla
            ClayButton(
              color: const Color(0xFFFFEBEE),
              onPressed: _isLoading ? null : _resetData,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🗑️', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    'Tüm Veritabanını Sıfırla',
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.medicalAlertRed,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF7A6E78))),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF2D232E))),
      ],
    );
  }
}
