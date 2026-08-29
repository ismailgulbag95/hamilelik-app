import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';
import '../../../services/media_service.dart';
import '../../../services/video_story_generator_service.dart';

/// Aura Pregnancy - Time-lapse Yolculuk Hikayesi Video Oynatıcı Diyaloğu
class TimelapseVideoDialog extends StatefulWidget {
  const TimelapseVideoDialog({super.key});

  @override
  State<TimelapseVideoDialog> createState() => _TimelapseVideoDialogState();
}

class _TimelapseVideoDialogState extends State<TimelapseVideoDialog> with SingleTickerProviderStateMixin {
  List<VideoStoryFrame> _frames = [];
  bool _isLoading = true;
  int _currentFrameIndex = 0;
  bool _isPlaying = true;
  Timer? _playbackTimer;
  late AnimationController _zoomController;

  @override
  void initState() {
    super.initState();
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _loadFrames();
  }

  Future<void> _loadFrames() async {
    final frames = await VideoStoryGeneratorService.instance.generateStoryFrames();
    if (mounted) {
      setState(() {
        _frames = frames;
        _isLoading = false;
      });
      _startPlayback();
    }
  }

  void _startPlayback() {
    _playbackTimer?.cancel();
    if (!_isPlaying || _frames.isEmpty) return;

    _playbackTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      setState(() {
        if (_currentFrameIndex < _frames.length - 1) {
          _currentFrameIndex++;
        } else {
          _currentFrameIndex = 0; // Başa sar
        }
      });
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startPlayback();
      } else {
        _playbackTimer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(child: CircularProgressIndicator(color: AppColors.primaryPink)),
      );
    }

    if (_frames.isEmpty) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎬', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 12),
              const Text('Henüz anı ve fotoğraf kaydı bulunamadı.', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kapat'),
              ),
            ],
          ),
        ),
      );
    }

    final currentFrame = _frames[_currentFrameIndex];
    final progress = (_currentFrameIndex + 1) / _frames.length;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 680),
        decoration: BoxDecoration(
          color: const Color(0xFF1E141D), // Sinematik Koyu Arka Plan
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.40),
              offset: const Offset(0, 20),
              blurRadius: 40,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Ken Burns Zoom Efektli Arka Plan Fotoğrafı
              AnimatedBuilder(
                animation: _zoomController,
                builder: (context, child) {
                  final scale = 1.0 + (_zoomController.value * 0.08);
                  return Transform.scale(
                    scale: scale,
                    child: MediaService.buildPhotoWidget(
                      currentFrame.photoPath,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),

              // 2. Sinematik Karartma Gradyanı
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.55),
                      Colors.transparent,
                      Colors.black.withOpacity(0.40),
                      Colors.black.withOpacity(0.92),
                    ],
                    stops: const [0.0, 0.25, 0.55, 1.0],
                  ),
                ),
              ),

              // 3. Üst Bar (Kare İlerleme Çubukları & Kapatma Butonu)
              Positioned(
                top: 18,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    // Instagram Story / Reel Tarzı Parçalı İlerleme Çubuğu
                    Row(
                      children: List.generate(_frames.length, (index) {
                        final isPassed = index < _currentFrameIndex;
                        final isCurrent = index == _currentFrameIndex;

                        return Expanded(
                          child: Container(
                            height: 3.5,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: isPassed
                                  ? AppColors.primaryPink
                                  : isCurrent
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),

                    // Başlık ve Kapatma Butonu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('🎬', style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Text(
                              'Hamilelik Hikayesi',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 4. Alt Bilgi Alanı (Hafta Başlığı, Anı Notu ve Romantik Alıntı)
              Positioned(
                bottom: 24,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Hafta Rozeti
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPink.withOpacity(0.90),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${currentFrame.week}. Hafta • ${currentFrame.date}',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Başlık
                    Text(
                      currentFrame.title,
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Açıklama / Anı Notu
                    Text(
                      currentFrame.subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        color: Colors.white.withOpacity(0.90),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Kontrol Butonları (Önceki, Oynat/Duraklat, Sonraki)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Önceki Kare
                        IconButton(
                          onPressed: _currentFrameIndex > 0
                              ? () => setState(() => _currentFrameIndex--)
                              : null,
                          icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 28),
                        ),

                        // Oynat / Durdur Butonu
                        GestureDetector(
                          onTap: _togglePlayPause,
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: AppColors.primaryPink,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryPink.withOpacity(0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),

                        // Sonraki Kare
                        IconButton(
                          onPressed: _currentFrameIndex < _frames.length - 1
                              ? () => setState(() => _currentFrameIndex++)
                              : null,
                          icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 28),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
