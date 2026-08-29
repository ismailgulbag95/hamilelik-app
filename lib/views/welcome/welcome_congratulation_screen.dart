import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/clay_theme.dart';
import 'app_guide_screen.dart';

/// Aura Pregnancy - Hoş Geldiniz ve Tebrikler Ekranı
class WelcomeCongratulationScreen extends StatelessWidget {
  final VoidCallback? onNext;

  const WelcomeCongratulationScreen({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),

              // Üst Karşılama ve Tebrik Kartı
              Column(
                children: [
                  // 3D Claymorphic Kalp & Anne/Bebek Aura Logosu
                  Container(
                    width: 110,
                    height: 110,
                    decoration: ClayTheme.clayDecoration(
                      color: AppColors.clayRose,
                      borderRadius: 55,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(55),
                      child: Image.asset(
                        'assets/images/aura_logo.png',
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Text('🌸', style: TextStyle(fontSize: 48)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tebrik Başlığı
                  const Text(
                    'Tebrikler Anne Adayı! 🎉',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'Hayatının en mucizevi ve sevgi dolu yolculuğu başladı.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryPeach,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Duygusal & Güven Veren Mesaj Kartı
                  ClayCard(
                    color: AppColors.clayCardSurface,
                    padding: const EdgeInsets.all(22),
                    child: const Column(
                      children: [
                        Text(
                          'Aura Pregnancy, hamileliğinizin her anında bebeğinizin gelişimini uzman tıbbi referanslarla izlemeniz ve bu eşsiz 40 haftayı romantik anılarla ölümsüzleştirmeniz için tasarlandı.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('✨ Sevgiyle Tasarlandı', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primaryPink)),
                            SizedBox(width: 12),
                            Text('🩺 Tıbbi Doğruluk', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.waterBlue)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Alt Butonlar
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClayButton(
                    color: AppColors.clayRose,
                    height: 56,
                    onPressed: () {
                      if (onNext != null) {
                        onNext!();
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const AppGuideScreen(),
                          ),
                        );
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Uygulama Rehberini İncele ✨',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, color: AppColors.primaryDark, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
