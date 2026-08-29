import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';
import '../../../models/diary_model.dart';
import '../../../utils/date_utils.dart';
import '../../../services/media_service.dart';
import 'clay_audio_player.dart';
import 'photo_view_dialog.dart';

/// Claymorphic Günlük Anı Kartı (Timeline formatı, fotoğraf, ses ve highlight rozeti)
class JournalEntryCard extends StatelessWidget {
  final DiaryModel entry;
  final VoidCallback? onDelete;

  const JournalEntryCard({
    super.key,
    required this.entry,
    this.onDelete,
  });

  String _getMoodEmoji(int mood) {
    switch (mood) {
      case 1: return '🥺';
      case 2: return '😌';
      case 3: return '😊';
      case 4: return '🥰';
      case 5: return '✨';
      default: return '❤️';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClayCard(
        color: entry.isRomanticHighlight ? AppColors.clayRose : AppColors.clayCardSurface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst Bilgi Başlığı
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(_getMoodEmoji(entry.moodRating), style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.pregnancyWeek}. Hafta Anısı',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        Text(
                          AppDateUtils.formatDisplay(entry.date),
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
                Row(
                  children: [
                    if (entry.isRomanticHighlight)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rounded, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Özel An',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (onDelete != null)
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.textMuted),
                        onPressed: onDelete,
                        tooltip: 'Anıyı Sil',
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Anı Notu
            if (entry.noteText != null && entry.noteText!.isNotEmpty)
              Text(
                entry.noteText!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  height: 1.45,
                ),
              ),

            // 📷 Gerçek Fotoğraf Alanı (Varsa)
            if (entry.photoPath != null) ...[
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => PhotoViewDialog.show(
                  context,
                  entry.photoPath!,
                  title: '${entry.pregnancyWeek}. Hafta Fotoğrafı',
                ),
                child: Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      MediaService.buildPhotoWidget(
                        entry.photoPath!,
                        width: double.infinity,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.zoom_in_rounded, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text('Büyüt', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // 🎙️ Gerçek Ses Kaydı / Çalma Alanı (Varsa)
            if (entry.audioPath != null) ...[
              const SizedBox(height: 12),
              ClayAudioPlayer(
                audioPath: entry.audioPath!,
                title: '${entry.pregnancyWeek}. Hafta Sesli Mektubu 🎙️',
                durationSeconds: 30,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
