import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/clay_theme.dart';
import '../../services/database_helper.dart';
import '../onboarding/onboarding_screen.dart';
import '../main_navigation_scaffold.dart';

/// Aura Pregnancy - Detaylı ve Açıklayıcı Uygulama Rehberi & Yönlendiriciler
class AppGuideScreen extends StatefulWidget {
  final VoidCallback? onCompleteGuide;

  const AppGuideScreen({super.key, this.onCompleteGuide});

  @override
  State<AppGuideScreen> createState() => _AppGuideScreenState();
}

class _AppGuideScreenState extends State<AppGuideScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final List<Map<String, dynamic>> _guideSteps = [
    {
      'icon': Icons.calendar_month_rounded,
      'color': AppColors.clayRose,
      'title': '1. Kişiselleştirilmiş Gebelik Takibi',
      'subtitle': 'SAT ve Boy/Kilo Analiziniz',
      'description': 'Son Adet Tarihinizi (SAT) veya tahmini doğum gününüzü girerek güncel haftanızı ve kalan gün sayısını anında öğrenin. Hamilelik öncesi kilonuza göre IOM standartlarında ideal kilo artış hedefinizi takip edin.',
      'highlights': [
        'Naegele Kuralı ile kesin doğum tarihi hesabı',
        'Vücut Kitle İndeksi (VKİ) ve ideal kilo artış tablosu',
        'Bebeğin haftalık meyve ve milimetrik boyut benzetimi',
      ],
    },
    {
      'icon': Icons.medical_services_rounded,
      'color': AppColors.claySky,
      'title': '2. Kritik Tıbbi Tarama & Test Takvimi',
      'subtitle': 'Hangi Hafta Hangi Test Yapılmalı?',
      'description': 'Bebeğinizin sağlığı için hiçbir taramayı kaçırmayın. Kritik haftalarda uygulama otomatik hatırlatıcılar ve kontrol listeleri üretir.',
      'highlights': [
        '10. Hafta: NIPT (Serbest Fetal DNA Kromozom Taraması)',
        '11 - 13. Hafta: Ense Kalınlığı (NT) & İkili Tarama',
        '20 - 22. Hafta: Ayrıntılı Ultrason (Detaylı Organ Taraması)',
        '24 - 28. Hafta: Gestasyonel Diyabet (Şeker Yükleme)',
      ],
    },
    {
      'icon': Icons.water_drop_rounded,
      'color': AppColors.clayPeach,
      'title': '3. Günlük Sağlık & 200 mg Kafein Alarmı',
      'subtitle': 'Su, Beslenme ve Tıbbi Güvenlik',
      'description': 'Anne ve bebeğin sıvı dengesi için 2.5 Litre hedefli su takip modülü ve aşırı kafein alımını önleyen tıbbi güvenlik alarmı her an yanınızda.',
      'highlights': [
        'Tek dokunuşla bardak (+250 ml) ve şişe (+500 ml) su kaydı',
        'Günlük 200 mg kafein sınırı aşıldığında kırmızı alarm uyarısı',
        '1., 2. ve 3. Trimester ek kalori ve besin tavsiyeleri',
      ],
    },
    {
      'icon': Icons.menu_book_rounded,
      'color': AppColors.clayLavender,
      'title': '4. Aura Journal & Yolculuk Videosu',
      'subtitle': 'Romantik Anılar ve Sesli Mektuplar',
      'description': 'Bebeğinize hissettiğiniz duyguları, kalp atışlarını ve ultrason fotoğraflarını kaydedin. Doğum anında tek tıkla FFmpeg destekli Time-Lapse Yolculuk Videosuna dönüştürün.',
      'highlights': [
        '5 Seviyeli Günlük Ruh Hali (Mood) Takibi',
        'Ultrason fotoğrafları ve sesli mektup kayıtları',
        'Romantik melodi ile otomatik video derleme',
      ],
    },
    {
      'icon': Icons.emergency_rounded,
      'color': AppColors.medicalAlertBg,
      'title': '5. Kırmızı Alarm & Acil Durum Kartı',
      'subtitle': 'Beklenmedik Anlarda Hayati Destek',
      'description': 'Gebelikte acil hekim başvurusu gerektiren 8 tehlike işareti ve acil serviste sağlık ekiplerine gösterebileceğiniz Acil Tıbbi Bilgi Kartı (Emergency ID).',
      'highlights': [
        '8 Kritik tehlike işareti ve açıklamaları',
        'Kan grubu, alerji, ilaç ve doktor bilgisini içeren acil kart',
        'Tek dokunuşla 112 Acil Yardım veya Doktoru arama',
      ],
    },
  ];

  void _nextStep() {
    if (_currentStep < _guideSteps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    } else {
      _finishGuide(goToOnboarding: true);
    }
  }

  Future<void> _finishGuide({bool goToOnboarding = true}) async {
    if (widget.onCompleteGuide != null) {
      widget.onCompleteGuide!();
      return;
    }

    if (goToOnboarding) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    } else {
      await DatabaseHelper.instance.ensureDefaultProfile();
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const MainNavigationScaffold(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Uygulama Rehberi',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: _finishGuide,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Atla',
                    style: TextStyle(
                      color: AppColors.primaryPink,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded, color: AppColors.primaryPink, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // İlerleme Çubukları
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: List.generate(_guideSteps.length, (index) {
                  final isActive = index <= _currentStep;
                  return Expanded(
                    child: Container(
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primaryPink : AppColors.backgroundSubtle,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (idx) => setState(() => _currentStep = idx),
                itemCount: _guideSteps.length,
                itemBuilder: (context, index) {
                  final step = _guideSteps[index];
                  final highlights = step['highlights'] as List<String>;
                  final stepIcon = step['icon'] as IconData;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // İkon & Başlık Kartı
                        ClayCard(
                          color: step['color'] as Color,
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: ClayTheme.clayDecoration(
                                      color: Colors.white,
                                      borderRadius: 16,
                                    ),
                                    child: Center(
                                      child: Icon(stepIcon, color: AppColors.primaryDark, size: 24),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          step['title'] as String,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          step['subtitle'] as String,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.secondaryPeach,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                step['description'] as String,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Öne Çıkan Yönlendirici Maddeler
                        ClayCard(
                          color: AppColors.clayCardSurface,
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.stars_rounded, color: AppColors.accentGold, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Önemli Özellikler ve İpuçları:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ...highlights.map((h) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.successGreen),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            h,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimary,
                                              height: 1.35,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Alt İlerleme ve Başlama Butonu
            Padding(
              padding: const EdgeInsets.all(24),
              child: ClayButton(
                color: _currentStep == _guideSteps.length - 1 ? AppColors.clayMint : AppColors.clayRose,
                height: 56,
                onPressed: _nextStep,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentStep == _guideSteps.length - 1 ? 'Profilini Oluştur ve Başla' : 'Sonraki Özellik',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: _currentStep == _guideSteps.length - 1 ? AppColors.successGreen : AppColors.primaryDark,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: _currentStep == _guideSteps.length - 1 ? AppColors.successGreen : AppColors.primaryDark,
                      size: 18,
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
}
