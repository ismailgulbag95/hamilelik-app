import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/medical_specs.dart';
import '../../core/theme/clay_theme.dart';
import '../../controllers/emergency_controller.dart';
import 'widgets/emergency_sign_card.dart';
import 'widgets/medical_id_card_view.dart';

/// Gebelikte Acil Uyarı İşaretleri ve Kırmızı Alarm Panik Modülü
class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final EmergencyController _controller = EmergencyController();
  int _activeTabIndex = 0; // 0: Tehlike İşaretleri, 1: Acil Not Kartı

  @override
  void initState() {
    super.initState();
    _controller.loadEmergencyData();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🚨 ', style: TextStyle(fontSize: 20)),
            Text(
              'Kırmızı Alarm & Acil Durum',
              style: TextStyle(
                color: AppColors.medicalAlertRed,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tab Switcher
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ClayCard(
                color: AppColors.clayLavender,
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _activeTabIndex = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: _activeTabIndex == 0
                              ? ClayTheme.clayDecoration(
                                  color: AppColors.clayRose,
                                  borderRadius: 20,
                                )
                              : null,
                          child: Center(
                            child: Text(
                              'Tehlike İşaretleri (8)',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: _activeTabIndex == 0
                                    ? AppColors.primaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _activeTabIndex = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: _activeTabIndex == 1
                              ? ClayTheme.clayDecoration(
                                  color: AppColors.clayRose,
                                  borderRadius: 20,
                                )
                              : null,
                          child: Center(
                            child: Text(
                              'Acil Tıbbi Kartı',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: _activeTabIndex == 1
                                    ? AppColors.primaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: _activeTabIndex == 0
                  ? _buildEmergencySignsTab()
                  : _buildMedicalIdCardTab(),
            ),

            // Hızlı Acil Arama Butonu
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClayButton(
                color: AppColors.medicalAlertRed,
                height: 56,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🚨 112 Acil Yardım veya Doktorunuz Aranıyor...'),
                      backgroundColor: AppColors.medicalAlertRed,
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 22),
                    SizedBox(width: 10),
                    Text(
                      '112 Acil Çağrı / Doktoru Ara',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencySignsTab() {
    final signs = PregnancyMedicalSpecs.redFlagEmergencySigns;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: signs.length,
      itemBuilder: (context, index) {
        final sign = signs[index];
        return EmergencySignCard(
          title: sign['title']!,
          detail: sign['detail']!,
          urgency: sign['urgency']!,
        );
      },
    );
  }

  Widget _buildMedicalIdCardTab() {
    if (_controller.card == null) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primaryPink));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: MedicalIdCardView(card: _controller.card!),
    );
  }
}
