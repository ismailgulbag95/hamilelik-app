import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';

/// Claymorphic 1-40 Hafta Kaydırılabilir Timeline Şeridi
class WeeklyTimelineStrip extends StatelessWidget {
  final int selectedWeek;
  final int currentWeek;
  final Function(int) onWeekSelected;

  const WeeklyTimelineStrip({
    super.key,
    required this.selectedWeek,
    required this.currentWeek,
    required this.onWeekSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final week = index + 1;
          final isSelected = week == selectedWeek;
          final isCurrent = week == currentWeek;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            child: GestureDetector(
              onTap: () => onWeekSelected(week),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 58,
                decoration: ClayTheme.clayDecoration(
                  color: isSelected
                      ? AppColors.clayRose
                      : (isCurrent ? AppColors.clayMint : AppColors.clayCardSurface),
                  borderRadius: 22,
                  isPressed: isSelected,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hafta',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? AppColors.primaryDark : AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$week',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: isSelected
                            ? AppColors.primaryDark
                            : (isCurrent ? AppColors.successGreen : AppColors.textPrimary),
                      ),
                    ),
                    if (isCurrent)
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: const BoxDecoration(
                          color: AppColors.successGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
