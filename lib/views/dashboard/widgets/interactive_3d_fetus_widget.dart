import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'real_womb_fetus_widget.dart';

/// Aura Pregnancy - 360° İnteraktif 3D Anne Karnı Fetus Modeli
class Interactive3DFetusWidget extends StatefulWidget {
  final int currentWeek;
  final int currentDay; // 1-7
  final String babyName;
  final String eddDate;
  final VoidCallback? onTap;

  const Interactive3DFetusWidget({
    super.key,
    required this.currentWeek,
    this.currentDay = 3,
    this.babyName = 'Bebeğimiz',
    this.eddDate = '2026-10-15',
    this.onTap,
  });

  @override
  State<Interactive3DFetusWidget> createState() => _Interactive3DFetusWidgetState();
}

class _Interactive3DFetusWidgetState extends State<Interactive3DFetusWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _heartbeatController;

  @override
  void initState() {
    super.initState();
    _heartbeatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    super.dispose();
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
    if (week <= 8) return 'Erken Embriyonik Kese (3D)';
    if (week <= 13) return '1. Trimester 3D Fetus';
    if (week <= 27) return '2. Trimester 3D Fetus & Kordon';
    return '3. Trimester 3D Fetus (Tam Bebek)';
  }

  @override
  Widget build(BuildContext context) {
    final week = widget.currentWeek;
    final day = widget.currentDay;

    // Gerçekçi Lennart Nilsson rahim içi canlı fetüs ve kordon motoru
    return RealWombFetusWidget(
      currentWeek: week,
      currentDay: day,
      babyName: widget.babyName,
      eddDate: widget.eddDate,
      onTap: widget.onTap,
    );
  }
}
