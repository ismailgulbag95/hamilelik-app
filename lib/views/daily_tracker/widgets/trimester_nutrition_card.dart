import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/medical_specs.dart';
import '../../../core/theme/clay_theme.dart';

/// Claymorphic Trimester Beslenme ve Kalori Tavsiye Kartı
class TrimesterNutritionCard extends StatelessWidget {
  final int currentWeek;
  final int trimester;

  const TrimesterNutritionCard({
    super.key,
    required this.currentWeek,
    required this.trimester,
  });

  @override
  Widget build(BuildContext context) {
    String title = '';
    String extraCal = '';
    List<String> foodItems = [];
    Color cardColor = AppColors.clayMint;
    Color accentColor = AppColors.successGreen;

    if (trimester == 1) {
      title = '1. Trimester Beslenme Rehberi (1-13. Hafta)';
      extraCal = '+0 kkal/gün (Normal İhtiyaç)';
      foodItems = [
        'Folik Asit (400 - 800 mcg/gün) takviyesini ihmal etmeyin.',
        'Sabah bulantılarına karşı zencefil çayı ve kuru kraker tercih edin.',
        'Bol yeşil yapraklı sebzeler ve hafif sindirilen öğünler tüketin.',
      ];
      cardColor = AppColors.clayMint;
      accentColor = AppColors.successGreen;
    } else if (trimester == 2) {
      title = '2. Trimester Beslenme Rehberi (14-27. Hafta)';
      extraCal = '+340 kkal/gün Ek Kalori İhtiyacı';
      foodItems = [
        'Kaliteli Protein: Et, tavuk, yumurta ve baklagiller.',
        'Kalsiyum: Süt, yoğurt ve peynir ile kemik gelişimi desteği.',
        'Omega-3 & Demir: Haftada 1-2 porsiyon düşük cıvalı balık ve demir zengini gıdalar.',
      ];
      cardColor = AppColors.clayLavender;
      accentColor = AppColors.primaryDark;
    } else {
      title = '3. Trimester Beslenme Rehberi (28-40. Hafta)';
      extraCal = '+452 kkal/gün Ek Kalori İhtiyacı';
      foodItems = [
        'Hızlı Bebek Büyümesi: Yüksek protein ve lif desteği.',
        'Ödem & Şişlik Uyarısı: Tuz tüketimini kısıtlayın, bol su için.',
        'Mide yanmasına karşı az ve sık öğünler tercih edin.',
      ];
      cardColor = AppColors.clayRose;
      accentColor = AppColors.primaryDark;
    }

    return ClayCard(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Center(
                  child: Icon(Icons.restaurant_rounded, color: accentColor, size: 20),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Kalori Bandı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt_rounded, color: AppColors.accentGold, size: 20),
                const SizedBox(width: 6),
                Text(
                  extraCal,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Maddeler
          ...foodItems.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.5,
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
    );
  }
}
