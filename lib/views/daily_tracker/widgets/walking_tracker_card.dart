import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';

/// Claymorphic Günlük Yürüyüş & Adım Takip Kartı
class WalkingTrackerCard extends StatelessWidget {
  final int stepCount;
  final int walkingMinutes;
  final int currentWeek;
  final Function(int steps, {int minutes}) onAddSteps;
  final VoidCallback onReset;

  const WalkingTrackerCard({
    super.key,
    required this.stepCount,
    required this.walkingMinutes,
    this.currentWeek = 12,
    required this.onAddSteps,
    required this.onReset,
  });

  String _getTrimesterTip() {
    if (currentWeek <= 13) {
      return '1. Trimester: Günde 20-30 dakikalık hafif tempolu yürüyüşler sabah bulantılarını ve yorgunluğu azaltır. Yeterli su içmeyi unutmayın.';
    } else if (currentWeek <= 26) {
      return '2. Trimester: Enerjinizin en yüksek olduğu dönem! 30-40 dakikalık düzenli yürüyüşler doğum kaslarını ve kan dolaşımını güçlendirir.';
    } else {
      return '3. Trimester: Kısa ve rahat adımlarla 15-25 dakikalık yürüyüşler yapın. Pelvik baskı hissettiğinizde dinlenin ve rahat ayakkabı giyin.';
    }
  }

  @override
  Widget build(BuildContext context) {
    const targetSteps = 6000;
    final progress = (stepCount / targetSteps).clamp(0.0, 1.0);
    final isTargetReached = stepCount >= targetSteps;
    final distanceKm = (stepCount * 0.0007).toStringAsFixed(2);
    final burnedKcal = (stepCount * 0.04).round();

    return ClayCard(
      color: isTargetReached ? AppColors.clayMint : AppColors.clayCardSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık ve Sıfırlama Butonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: ClayTheme.clayDecoration(
                      color: isTargetReached ? AppColors.successGreen : AppColors.clayPeach,
                      borderRadius: 12,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.directions_walk_rounded,
                        color: isTargetReached ? Colors.white : AppColors.secondaryPeach,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Günlük Yürüyüş & Adım',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      Text(
                        'Hedef: $targetSteps Adım / 30 Dk',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (stepCount > 0)
                IconButton(
                  icon: const Icon(Icons.refresh_rounded, size: 20, color: AppColors.textMuted),
                  onPressed: onReset,
                  tooltip: 'Adımları Sıfırla',
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Adım Sayacı ve İlerleme Kartı
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$stepCount',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: isTargetReached ? AppColors.successGreen : AppColors.primaryDark,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          isTargetReached ? 'Harika! Günlük hedef tamamlandı' : '/ $targetSteps adım (%${(progress * 100).toInt()})',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isTargetReached ? AppColors.successGreen : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isTargetReached ? AppColors.clayMint : AppColors.clayRose,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isTargetReached ? Icons.emoji_events_rounded : Icons.directions_walk_rounded,
                            size: 16,
                            color: isTargetReached ? AppColors.successGreen : AppColors.primaryDark,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isTargetReached ? 'Başarıldı' : 'Yolda',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: isTargetReached ? AppColors.successGreen : AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // İlerleme Çubuğu
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isTargetReached ? AppColors.successGreen : AppColors.primaryPink,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // İstatistik Rozetleri (Mesafe, Kalori, Süre)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Mesafe', '$distanceKm km', Icons.straighten_rounded),
                    Container(width: 1, height: 24, color: Colors.black12),
                    _buildStatItem('Kalori', '$burnedKcal kcal', Icons.local_fire_department_rounded),
                    Container(width: 1, height: 24, color: Colors.black12),
                    _buildStatItem('Süre', '$walkingMinutes dk', Icons.timer_rounded),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Hızlı Adım & Yürüyüş Ekleme Butonları
          Row(
            children: [
              Expanded(
                child: ClayButton(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  onPressed: () => onAddSteps(500, minutes: 4),
                  child: const Column(
                    children: [
                      Text('+500', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                      Text('4 Dk', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ClayButton(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  onPressed: () => onAddSteps(1000, minutes: 8),
                  child: const Column(
                    children: [
                      Text('+1.000', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                      Text('8 Dk', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ClayButton(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  onPressed: () => onAddSteps(2000, minutes: 15),
                  child: const Column(
                    children: [
                      Text('+2.000', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                      Text('15 Dk', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Trimester Yürüyüş Tavsiye Bandı
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.claySky,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.tips_and_updates_rounded, color: AppColors.waterBlue, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getTrimesterTip(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.waterBlue,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: AppColors.textSecondary),
            const SizedBox(width: 3),
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
        ),
      ],
    );
  }
}
