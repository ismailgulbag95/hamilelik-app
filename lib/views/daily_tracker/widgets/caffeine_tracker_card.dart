import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/medical_specs.dart';
import '../../../core/theme/clay_theme.dart';

/// Claymorphic Kafein Takip Kartı (200 mg sınırı kontrolü ve görsel alarm)
class CaffeineTrackerCard extends StatelessWidget {
  final int currentCaffeineMg;
  final Function(int) onAddCaffeine;
  final VoidCallback onReset;

  const CaffeineTrackerCard({
    super.key,
    required this.currentCaffeineMg,
    required this.onAddCaffeine,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    const maxLimit = PregnancyMedicalSpecs.maxCaffeineMgPerDay;
    final isOverLimit = currentCaffeineMg > maxLimit;
    final remaining = (maxLimit - currentCaffeineMg).clamp(0, maxLimit.toInt());

    return ClayCard(
      color: isOverLimit ? AppColors.medicalAlertBg : AppColors.clayPeach,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('☕', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 8),
                  Text(
                    'Kafein Takibi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isOverLimit ? AppColors.medicalAlertRed : AppColors.secondaryPeach,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded, size: 20, color: AppColors.textSecondary),
                onPressed: onReset,
                tooltip: 'Sıfırla',
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$currentCaffeineMg / ${maxLimit.toInt()} mg',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isOverLimit ? AppColors.medicalAlertRed : AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isOverLimit ? AppColors.medicalAlertRed : Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isOverLimit ? '⚠️ SINIR AŞILDI!' : 'Kalan: $remaining mg',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: isOverLimit ? Colors.white : AppColors.secondaryPeach,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Aşım Görsel Alarm Kutusu
          if (isOverLimit) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.medicalAlertRed, width: 2),
              ),
              child: const Row(
                children: [
                  Text('🚨', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tıbbi Güvenlik Uyarısı: Günlük 200 mg kafein sınırı aşıldı. Lütfen daha fazla kahve/çay tüketmeyiniz ve bol su içiniz.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.medicalAlertRed,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Hızlı İçecek Ekleme Butonları
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildDrinkButton('Türk Kahvesi', '+60 mg', 60),
              _buildDrinkButton('Filtre Kahve', '+95 mg', 95),
              _buildDrinkButton('Siyah Çay', '+40 mg', 40),
              _buildDrinkButton('Yeşil Çay', '+25 mg', 25),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrinkButton(String name, String amountStr, int mg) {
    return ClayButton(
      color: AppColors.clayCardSurface,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      onPressed: () => onAddCaffeine(mg),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.textPrimary)),
          const SizedBox(width: 4),
          Text(amountStr, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: AppColors.secondaryPeach)),
        ],
      ),
    );
  }
}
