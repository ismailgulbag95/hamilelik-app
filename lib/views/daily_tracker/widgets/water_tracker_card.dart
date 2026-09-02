import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';

/// Claymorphic Su Takip Kartı (2500 ml hedefli, hızlı ekleme butonları)
class WaterTrackerCard extends StatelessWidget {
  final int currentWaterMl;
  final Function(int) onAddWater;
  final VoidCallback onReset;

  const WaterTrackerCard({
    super.key,
    required this.currentWaterMl,
    required this.onAddWater,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    const targetMl = 2500;
    final progress = (currentWaterMl / targetMl).clamp(0.0, 1.0);
    final percent = (progress * 100).toInt();

    return ClayCard(
      color: AppColors.claySky,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: ClayTheme.clayDecoration(
                      color: Colors.white,
                      borderRadius: 12,
                    ),
                    child: const Center(
                      child: Icon(Icons.water_drop_rounded, color: AppColors.waterBlue, size: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'water_tracker_title'.tr(),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.waterBlue,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded, size: 20, color: AppColors.textSecondary),
                onPressed: onReset,
                tooltip: 'tracker_reset'.tr(),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$currentWaterMl / $targetMl ml',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'water_percent'.tr(args: [percent.toString()]),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.waterBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Claymorphic İlerleme Çubuğu
          Container(
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E88E5).withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Hızlı Ekleme Butonları
          Row(
            children: [
              Expanded(
                child: ClayButton(
                  color: AppColors.clayCardSurface,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  onPressed: () => onAddWater(250),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_drink_rounded, color: AppColors.waterBlue, size: 18),
                      SizedBox(width: 6),
                      Text('+250 ml', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.waterBlue)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ClayButton(
                  color: AppColors.clayCardSurface,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  onPressed: () => onAddWater(500),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.water_drop_outlined, color: AppColors.waterBlue, size: 18),
                      SizedBox(width: 6),
                      Text('+500 ml', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.waterBlue)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
