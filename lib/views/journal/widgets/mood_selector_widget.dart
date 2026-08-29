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
    {'rating': 1, 'emoji': '🥺', 'label': 'Yorgun'},
    {'rating': 2, 'emoji': '😌', 'label': 'Durgun'},
    {'rating': 3, 'emoji': '😊', 'label': 'İyi'},
    {'rating': 4, 'emoji': '🥰', 'label': 'Mutlu'},
    {'rating': 5, 'emoji': '✨', 'label': 'Aura/Romantik'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: moods.map((m) {
        final rating = m['rating'] as int;
        final emoji = m['emoji'] as String;
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
                Text(emoji, style: TextStyle(fontSize: isSelected ? 26 : 22)),
                const SizedBox(height: 2),
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
