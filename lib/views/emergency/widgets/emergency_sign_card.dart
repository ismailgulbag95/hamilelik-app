import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';

/// Claymorphic Acil Tehlike İşareti Kartı
class EmergencySignCard extends StatelessWidget {
  final String title;
  final String detail;
  final String urgency;

  const EmergencySignCard({
    super.key,
    required this.title,
    required this.detail,
    required this.urgency,
  });

  @override
  Widget build(BuildContext context) {
    final isCritical = urgency == 'Kritik';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isCritical ? AppColors.medicalAlertBg : AppColors.clayCardSurface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isCritical ? AppColors.medicalAlertRed.withOpacity(0.6) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isCritical
                ? AppColors.medicalAlertRed.withOpacity(0.12)
                : Colors.black.withOpacity(0.04),
            offset: const Offset(0, 8),
            blurRadius: 16,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: const Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      isCritical ? '🚨' : '⚠️',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: isCritical ? AppColors.medicalAlertRed : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isCritical ? AppColors.medicalAlertRed : AppColors.secondaryPeach,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  urgency,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            detail,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
