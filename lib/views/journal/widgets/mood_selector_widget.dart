import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';

/// Claymorphic 5 Seviyeli Ruh Hali (Mood Tracker) Seçicisi
class MoodSelectorWidget extends StatelessWidget {
  final int selectedMood;
  final Function(int) onMoodSelected;

  const MoodSelectorWidget({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  static const List<Map<String, dynamic>> moods = [
    {'rating': 1, 'icon': Icons.sentiment_very_dissatisfied_rounded, 'color': Color(0xFFE57373), 'label': 'Yorgun'},
    {'rating': 2, 'icon': Icons.sentiment_neutral_rounded, 'color': Color(0xFFFFB74D), 'label': 'Durgun'},
    {'rating': 3, 'icon': Icons.sentiment_satisfied_rounded, 'color': Color(0xFF81C784), 'label': 'İyi'},
    {'rating': 4, 'icon': Icons.sentiment_very_satisfied_rounded, 'color': Color(0xFF4FC3F7), 'label': 'Mutlu'},
    {'rating': 5, 'icon': Icons.favorite_rounded, 'color': Color(0xFFF06292), 'label': 'Huzurlu'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: moods.map((m) {
        final rating = m['rating'] as int;
        final icon = m['icon'] as IconData;
        final color = m['color'] as Color;
        final label = m['label'] as String;
        final isSelected = rating == selectedMood;

        return GestureDetector(
          onTap: () => onMoodSelected(rating),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: ClayTheme.clayDecoration(
              color: isSelected ? AppColors.clayRose : AppColors.clayCardSurface,
              borderRadius: 18,
              isPressed: isSelected,
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: isSelected ? 26 : 22,
                  color: isSelected ? color : AppColors.textSecondary,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColors.primaryDark : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
