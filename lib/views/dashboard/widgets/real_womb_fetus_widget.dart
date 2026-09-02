import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Aura Pregnancy - 6 Evreli Gerçekçi Rahim İçi (In-Utero) Fetus Fotoğrafı ve Canlı Animasyon
class RealWombFetusWidget extends StatefulWidget {
  final int currentWeek;
  final int currentDay; // 1-7
  final String babyName;
  final String eddDate;
  final VoidCallback? onTap;

  const RealWombFetusWidget({
    super.key,
    required this.currentWeek,
    this.currentDay = 3,
    this.babyName = 'Bebeğimiz',
    this.eddDate = '2026-10-15',
    this.onTap,
  });

  @override
  State<RealWombFetusWidget> createState() => _RealWombFetusWidgetState();
}

class _RealWombFetusWidgetState extends State<RealWombFetusWidget>
    with TickerProviderStateMixin {
  late AnimationController _breatheController;
  late AnimationController _heartbeatController;

  @override
  void initState() {
    super.initState();

    // 1. Organik Fetal Solunum & Süzülme (3.8 saniye)
    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..repeat(reverse: true);

    // 2. Canlı Kalp Atışı Nabzı (140-160 BPM ritmi)
    _heartbeatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breatheController.dispose();
    _heartbeatController.dispose();
    super.dispose();
  }

  int _getStageForWeek(int week) {
    if (week <= 8) return 1;
    if (week <= 13) return 2;
    if (week <= 20) return 3;
    if (week <= 27) return 4; // 24. Hafta Morfoloji
    if (week <= 34) return 5;
    return 6; // 38. Hafta Tam Bebek
  }

  String _getHeartRateRange(int week) {
    if (week <= 8) {
      return '110 - 130 bpm';
    } else if (week <= 13) {
      return '145 - 165 bpm';
    } else if (week <= 27) {
      return '130 - 155 bpm';
    } else {
      return '120 - 150 bpm';
    }
  }

  String _getStageTitle(int week) {
    if (week <= 8) return '1. Evre: Erken Embriyo (8. Hafta)';
    if (week <= 13) return '2. Evre: 1. Trimester Fetus (12. Hafta)';
    if (week <= 20) return '3. Evre: 2. Trimester Fetus (18. Hafta)';
    if (week <= 27) return '4. Evre: 2. Trimester Fetus & Kordon (24. Hafta)';
    if (week <= 34) return '5. Evre: 3. Trimester Fetal Büyüme (30. Hafta)';
    return '6. Evre: 3. Trimester Doğuma Hazır Bebek (38. Hafta)';
  }

  @override
  Widget build(BuildContext context) {
    final week = widget.currentWeek;
    final day = widget.currentDay;
    final stage = _getStageForWeek(week);
    final heartRateRange = _getHeartRateRange(week);
    final stageTitle = _getStageTitle(week);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E0A12), // Derin Rahim İçi Arka Planı
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE899AE).withValues(alpha: 0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD85A7F).withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.55),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ÜST HUD BİLGİ BARI
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: const Color(0xFF2C1019),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF4081), // Canlı Pembe LED
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'IN UTERO LIVE VIEW',
                      style: TextStyle(
                        color: Color(0xFFFFB3C6),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                Text(
                  'GA: ${week}w+${day}d  •  FHR: $heartRateRange',
                  style: const TextStyle(
                    color: Color(0xFFFFD54F),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),

          // ANA RAHİM İÇİ FOTOGERÇEKÇİ GÖRSEL VE CANLI ANİMASYON
          GestureDetector(
            onTap: widget.onTap,
            child: SizedBox(
              height: 260,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 1. Üretilen Gerçekçi In-Utero Fotoğrafı (Canlı Solunum Hareketi ile)
                  AnimatedBuilder(
                    animation: _breatheController,
                    builder: (context, child) {
                      final scale = 1.0 + (sin(_breatheController.value * pi) * 0.035);
                      final offsetY = sin(_breatheController.value * pi) * 4.0;

                      return Transform.translate(
                        offset: Offset(0, offsetY),
                        child: Transform.scale(
                          scale: scale,
                          child: Image.asset(
                            'assets/images/womb_stage$stage.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, err, stack) {
                              // Fallback
                              return Container(
                                color: const Color(0xFF2C1019),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.favorite_rounded, color: Color(0xFFFF4081), size: 48),
                                      const SizedBox(height: 8),
                                      Text(
                                        stageTitle,
                                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  // 2. Rahim İçi Sıcak Işık ve Derinlik Maskesi
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 0.88,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF5A0E23).withValues(alpha: 0.2),
                          const Color(0xFF1E0A12).withValues(alpha: 0.7),
                        ],
                        stops: const [0.55, 0.8, 1.0],
                      ),
                    ),
                  ),

                  // 3. Canlı Fetal Kalp Atışı Rozeti
                  Positioned(
                    top: 10,
                    right: 12,
                    child: AnimatedBuilder(
                      animation: _heartbeatController,
                      builder: (context, child) {
                        final scale = 0.95 + (_heartbeatController.value * 0.12);
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFFF4081).withValues(alpha: 0.8)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF4081).withValues(alpha: 0.4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.favorite_rounded, color: Color(0xFFFF4081), size: 13),
                                const SizedBox(width: 5),
                                Text(
                                  heartRateRange,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // 4. Alt Evre Başlığı
                  Positioned(
                    bottom: 10,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        stageTitle,
                        style: const TextStyle(
                          color: Color(0xFFFFE0B2),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
