import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';
import '../../../models/diary_model.dart';
import '../../../services/ffmpeg_video_service.dart';

/// FFmpeg Yolculuk Videosu Render Diyalogu
class VideoRendererDialog extends StatefulWidget {
  final List<DiaryModel> highlightEntries;

  const VideoRendererDialog({super.key, required this.highlightEntries});

  @override
  State<VideoRendererDialog> createState() => _VideoRendererDialogState();
}

class _VideoRendererDialogState extends State<VideoRendererDialog> {
  bool _isRendering = false;
  double _progress = 0.0;
  bool _isFinished = false;

  void _startRender() {
    setState(() {
      _isRendering = true;
      _progress = 0.0;
      _isFinished = false;
    });

    FFmpegVideoService.renderTimeLapseProgress().listen((prog) {
      if (mounted) {
        setState(() {
          _progress = prog;
          if (prog >= 1.0) {
            _isRendering = false;
            _isFinished = true;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final matrix = FFmpegVideoService.generateVideoAssetMatrix(
      highlightEntries: widget.highlightEntries,
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: ClayCard(
        color: AppColors.clayRose,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: ClayTheme.clayDecoration(
                color: Colors.white,
                borderRadius: 20,
              ),
              child: const Center(
                child: Icon(Icons.movie_creation_rounded, color: AppColors.primaryPink, size: 32),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Aura Yolculuk Videosu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'FFmpeg & Romantik Melodi Time-Lapse',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            // Bilgi Kutusu
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildMatrixRow('Seçilen Özel Anlar', '${widget.highlightEntries.length} Adet'),
                  _buildMatrixRow('Arka Plan Melodisi', 'Aura_Lullaby.mp3'),
                  _buildMatrixRow('Video Çözünürlüğü', '1080x1920 (Full HD Dikey)'),
                  _buildMatrixRow('Tahmini Süre', '${matrix['total_duration_sec']} Saniye'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (_isRendering) ...[
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: AppColors.backgroundSubtle,
                color: AppColors.primaryPink,
                borderRadius: BorderRadius.circular(8),
                minHeight: 12,
              ),
              const SizedBox(height: 8),
              Text(
                'Video İşleniyor... %${(_progress * 100).toInt()}',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.primaryDark),
              ),
              const SizedBox(height: 16),
            ] else if (_isFinished) ...[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.clayMint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_rounded, color: AppColors.successGreen, size: 20),
                    SizedBox(width: 6),
                    Text(
                      'Yolculuk Videosu Başarıyla Üretildi!',
                      style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.successGreen, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            Row(
              children: [
                Expanded(
                  child: ClayButton(
                    color: AppColors.clayCardSurface,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kapat', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ClayButton(
                    color: _isFinished ? AppColors.clayMint : AppColors.clayPeach,
                    onPressed: _isRendering ? null : (_isFinished ? null : _startRender),
                    child: Text(
                      _isFinished ? 'Hazır' : 'Render Başlat',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatrixRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          Text(val, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
