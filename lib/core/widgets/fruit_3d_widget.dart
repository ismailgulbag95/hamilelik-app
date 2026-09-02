import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../services/fruit_asset_sync.dart';

/// Aura Pregnancy - 3D Render Meyve & Sebze Fotoğraf Bileşeni
class Fruit3DWidget extends StatelessWidget {
  final String? fruitKey;
  final int? week;
  final int? stageIndex;
  final double size;
  final double borderRadius;
  final bool showShadow;

  const Fruit3DWidget({
    super.key,
    this.fruitKey,
    this.week,
    this.stageIndex,
    this.size = 56.0,
    this.borderRadius = 28.0,
    this.showShadow = true,
  });

  String _resolveFruitKey() {
    if (fruitKey != null && fruitKey!.isNotEmpty) return fruitKey!;
    if (stageIndex != null) return Fruit3DAssetManager.getFruitKeyForStageIndex(stageIndex!);
    if (week != null) return Fruit3DAssetManager.getFruitKeyForWeek(week!);
    return 'avocado';
  }

  @override
  Widget build(BuildContext context) {
    final key = _resolveFruitKey();
    final assetPath = Fruit3DAssetManager.getAssetImagePath(key);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getFruitBgColor(key),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: _getFruitShadowColor(key).withValues(alpha: 0.24),
                  offset: const Offset(0, 8),
                  blurRadius: 16,
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.85),
                  offset: const Offset(0, -2),
                  blurRadius: 6,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          assetPath,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, stack) {
            return Container(
              color: _getFruitBgColor(key),
              child: Center(
                child: Icon(
                  _getFruitIcon(key),
                  size: size * 0.45,
                  color: _getFruitShadowColor(key).withValues(alpha: 0.65),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static IconData _getFruitIcon(String key) {
    switch (key) {
      case 'carrot': return Icons.eco_rounded;
      case 'papaya': return Icons.circle_rounded;
      case 'cauliflower': return Icons.nature_people_rounded;
      case 'zucchini': return Icons.yard_rounded;
      case 'broccoli': return Icons.park_rounded;
      case 'squash': return Icons.eco_rounded;
      case 'butternut_squash': return Icons.circle_rounded;
      case 'cabbage': return Icons.filter_vintage_rounded;
      case 'bok_choy': return Icons.eco_rounded;
      case 'pumpkin': return Icons.circle_rounded;
      case 'lettuce': return Icons.yard_rounded;
      case 'swiss_chard': return Icons.grass_rounded;
      case 'celery': return Icons.spa_rounded;
      case 'mini_watermelon': return Icons.circle_rounded;
      default: return Icons.eco_rounded;
    }
  }

  static Color _getFruitBgColor(String key) {
    switch (key) {
      case 'avocado': return const Color(0xFFEAF5EA);
      case 'strawberry': return const Color(0xFFFFECEF);
      case 'lemon': return const Color(0xFFFFFBEA);
      case 'banana': return const Color(0xFFFFF9DB);
      case 'blueberry': return const Color(0xFFEBF0FA);
      case 'pineapple': return const Color(0xFFFFF5D9);
      case 'watermelon': return const Color(0xFFEBF8EC);
      case 'peach': return const Color(0xFFFFF0E6);
      case 'corn': return const Color(0xFFFFF9DB);
      case 'eggplant': return const Color(0xFFF6ECFA);
      case 'coconut': return const Color(0xFFF4ECE8);
      case 'melon': return const Color(0xFFFFF3E0);
      case 'seed': return const Color(0xFFEAF5EA);
      case 'carrot': return const Color(0xFFFFF0E6);
      case 'papaya': return const Color(0xFFFFF3E0);
      case 'cauliflower': return const Color(0xFFF4ECE8);
      case 'zucchini': return const Color(0xFFEAF5EA);
      case 'broccoli': return const Color(0xFFEAF5EA);
      case 'squash': return const Color(0xFFFFF3E0);
      case 'butternut_squash': return const Color(0xFFFFF5D9);
      case 'cabbage': return const Color(0xFFEBF8EC);
      case 'bok_choy': return const Color(0xFFEAF5EA);
      case 'pumpkin': return const Color(0xFFFFF0E6);
      case 'lettuce': return const Color(0xFFEAF5EA);
      case 'swiss_chard': return const Color(0xFFEBF8EC);
      case 'celery': return const Color(0xFFEAF5EA);
      case 'mini_watermelon': return const Color(0xFFEBF8EC);
      default: return const Color(0xFFFEE6E0);
    }
  }

  static Color _getFruitShadowColor(String key) {
    switch (key) {
      case 'avocado': return const Color(0xFF388E3C);
      case 'strawberry': return const Color(0xFFD32F2F);
      case 'lemon': return const Color(0xFFFBC02D);
      case 'banana': return const Color(0xFFF57F17);
      case 'blueberry': return const Color(0xFF3949AB);
      case 'pineapple': return const Color(0xFFFFA000);
      case 'watermelon': return const Color(0xFF2E7D32);
      case 'peach': return const Color(0xFFE64A19);
      case 'corn': return const Color(0xFFF57F17);
      case 'eggplant': return const Color(0xFF7B1FA2);
      case 'coconut': return const Color(0xFF5D4037);
      case 'melon': return const Color(0xFFEF6C00);
      case 'seed': return const Color(0xFF4E8D55);
      case 'carrot': return const Color(0xFFE64A19);
      case 'papaya': return const Color(0xFFEF6C00);
      case 'cauliflower': return const Color(0xFF5D4037);
      case 'zucchini': return const Color(0xFF388E3C);
      case 'broccoli': return const Color(0xFF2E7D32);
      case 'squash': return const Color(0xFFEF6C00);
      case 'butternut_squash': return const Color(0xFFFFA000);
      case 'cabbage': return const Color(0xFF2E7D32);
      case 'bok_choy': return const Color(0xFF388E3C);
      case 'pumpkin': return const Color(0xFFE64A19);
      case 'lettuce': return const Color(0xFF388E3C);
      case 'swiss_chard': return const Color(0xFF2E7D32);
      case 'celery': return const Color(0xFF388E3C);
      case 'mini_watermelon': return const Color(0xFF2E7D32);
      default: return AppColors.primaryPink;
    }
  }
}
