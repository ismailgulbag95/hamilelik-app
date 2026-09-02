import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Aura Pregnancy - Organik Ortam Işığı & Sıcak Degrade Arka Plan Sarmalayıcısı
/// Düz renk yerine derinlik, ferahlık ve yumuşak ton geçişleri sunar.
class AmbientBackground extends StatelessWidget {
  final Widget child;
  final bool showAmbientOrbs;

  const AmbientBackground({
    super.key,
    required this.child,
    this.showAmbientOrbs = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!showAmbientOrbs) {
      return Container(
        decoration: const BoxDecoration(
          gradient: AppColors.ambientBackgroundGradient,
        ),
        child: child,
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.ambientBackgroundGradient,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Sağ Üst Yumuşak Pastel Gül/Şeftali Ortam Işığı Küresi
          Positioned(
            top: -60,
            right: -60,
            child: IgnorePointer(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.clayPeach.withValues(alpha: 0.35),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
                  child: const SizedBox(),
                ),
              ),
            ),
          ),

          // 2. Sol Orta-Alt Yumuşak Lavanta/Mavi Işık Küresi
          Positioned(
            bottom: 100,
            left: -80,
            child: IgnorePointer(
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.clayLavender.withValues(alpha: 0.30),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: const SizedBox(),
                ),
              ),
            ),
          ),

          // 3. Ana İçerik
          child,
        ],
      ),
    );
  }
}
