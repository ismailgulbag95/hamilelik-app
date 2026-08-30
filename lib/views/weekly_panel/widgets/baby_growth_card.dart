import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';

/// Claymorphic Bebek Büyüklük ve Gelişim Kartı
class BabyGrowthCard extends StatelessWidget {
  final int week;
  final Map<String, dynamic> weekData;
  final String? babyDisplayName;

  const BabyGrowthCard({
    super.key,
    required this.week,
    required this.weekData,
    this.babyDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    final fruitIcon = (weekData['icon'] as IconData?) ?? Icons.eco_rounded;
    final fruitName = weekData['fruit_name'] as String? ?? 'Gelişim';
    final length = weekData['length'] as String? ?? '-';
    final weight = weekData['weight'] as String? ?? '-';
    final babyDev = weekData['baby_dev'] as String? ?? '';
    final motherChanges = weekData['mother_changes'] as String? ?? '';
    final babyName = babyDisplayName ?? 'Bebeğiniz';

    return Column(
      children: [
        // 1. Bebek Büyüklüğü ve Meyve Kartı
        ClayCard(
          color: AppColors.clayPeach,
          child: Column(
            children: [
              Row(
                children: [
                  // Meyve İkon Alanı
                  Container(
                    width: 64,
                    height: 64,
                    decoration: ClayTheme.clayDecoration(
                      color: AppColors.clayRose,
                      borderRadius: 20,
                    ),
                    child: Center(
                      child: Icon(fruitIcon, size: 30, color: AppColors.secondaryPeach),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$week. Hafta $babyName:',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondaryPeach,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          fruitName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Boy ve Kilo Sayaçları
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Text('Tahmini Boy', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                          const SizedBox(height: 2),
                          Text(length, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Text('Tahmini Ağırlık', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                          const SizedBox(height: 2),
                          Text(weight, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // 2. Bebeğin Gelişimi Açıklama Kartı
        ClayCard(
          color: AppColors.clayCardSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: ClayTheme.clayDecoration(
                      color: AppColors.clayRose,
                      borderRadius: 10,
                    ),
                    child: const Center(
                      child: Icon(Icons.child_care_rounded, color: AppColors.primaryPink, size: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$babyName Gelişim Durumu',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                babyDev,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary, height: 1.45),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // 3. Annedeki Değişimler Kartı
        ClayCard(
          color: AppColors.clayLavender,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: ClayTheme.clayDecoration(
                      color: AppColors.clayRose,
                      borderRadius: 10,
                    ),
                    child: const Center(
                      child: Icon(Icons.spa_rounded, color: AppColors.lavenderPurple, size: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Annede Görülen Değişimler',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                motherChanges,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.45),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
