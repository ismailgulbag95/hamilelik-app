import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';

/// Aura Pregnancy - Ödüllü Reklam İzleme ve İçerik Kilit Açma Modalı
class AdRewardDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String unlockTargetName;
  final VoidCallback onRewardEarned;

  const AdRewardDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.unlockTargetName,
    required this.onRewardEarned,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String unlockTargetName,
    required VoidCallback onRewardEarned,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AdRewardDialog(
        title: title,
        subtitle: subtitle,
        unlockTargetName: unlockTargetName,
        onRewardEarned: onRewardEarned,
      ),
    );
  }

  @override
  State<AdRewardDialog> createState() => _AdRewardDialogState();
}

class _AdRewardDialogState extends State<AdRewardDialog> with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  int _countdown = 5;
  Timer? _timer;
  bool _isCompleted = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  void _startAdPlayback() {
    setState(() {
      _isPlaying = true;
      _countdown = 5;
      _isCompleted = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_countdown > 1) {
        setState(() => _countdown--);
      } else {
        _timer?.cancel();
        setState(() {
          _countdown = 0;
          _isCompleted = true;
          _isPlaying = false;
        });
        widget.onRewardEarned();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF7F4),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9E7B83).withOpacity(0.25),
              offset: const Offset(0, 16),
              blurRadius: 36,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!_isPlaying && !_isCompleted) ...[
              // 1. REKLAM İZLEME TEKLİFİ EKRANI
              Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: ClayTheme.clayDecoration(
                    color: const Color(0xFFFEE6E0),
                    borderRadius: 22,
                  ),
                  child: const Center(
                    child: Icon(Icons.lock_clock_rounded, color: AppColors.secondaryPeach, size: 32),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2D232E),
                ),
              ),
              const SizedBox(height: 8),

              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7A6E78),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4EBD6),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.smart_display_rounded, color: Color(0xFF2E6135), size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Kısa bir video izleyerek "${widget.unlockTargetName}" içeriğini anında açabilirsiniz.',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2E6135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              ClayButton(
                color: const Color(0xFFD4EBD6),
                height: 52,
                onPressed: _startAdPlayback,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_circle_filled_rounded, color: Color(0xFF2E6135), size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Reklamı İzle ve Kilidi Aç',
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2E6135),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'Vazgeç',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF7A6E78),
                  ),
                ),
              ),
            ] else if (_isPlaying) ...[
              // 2. REKLAM OYNATILIYOR (CANLI GERİ SAYIM & SİMÜLASYON)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.stars_rounded, color: AppColors.accentGold, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Sponsorlu Tanıtım',
                          style: GoogleFonts.nunito(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2D232E),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D232E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$_countdown sn',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Reklam Görsel Kartı
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6E4F0),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.waterBlue.withOpacity(0.3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(Icons.local_hospital_rounded, color: AppColors.waterBlue, size: 30),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Aura Mom & Baby Care',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF2D232E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Anne ve Bebeğe Özel Premium Bakım',
                          style: GoogleFonts.quicksand(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF5C4F53),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 12,
                      left: 20,
                      right: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: (5 - _countdown) / 5.0,
                          minHeight: 6,
                          backgroundColor: Colors.white.withOpacity(0.5),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.waterBlue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Ödülünüz yükleniyor, lütfen bekleyiniz...',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF7A6E78),
                ),
              ),
            ] else ...[
              // 3. REKLAM BİTTİ & KİLİT AÇILDI
              Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: ClayTheme.clayDecoration(
                    color: const Color(0xFFD4EBD6),
                    borderRadius: 22,
                  ),
                  child: const Center(
                    child: Icon(Icons.lock_open_rounded, color: Color(0xFF2E6135), size: 34),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Text(
                'Kilit Başarıyla Açıldı!',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2D232E),
                ),
              ),
              const SizedBox(height: 6),

              Text(
                '"${widget.unlockTargetName}" detayları artık görüntülenebilir.',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5C4F53),
                ),
              ),
              const SizedBox(height: 20),

              ClayButton(
                color: const Color(0xFFD4EBD6),
                height: 52,
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'İncele ve Devam Et',
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF2E6135),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
