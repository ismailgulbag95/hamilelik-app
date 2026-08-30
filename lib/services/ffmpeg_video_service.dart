
import '../models/diary_model.dart';

/// Aura Pregnancy - FFmpeg Video Ön-İşlemcisi ve Render Motoru
class FFmpegVideoService {
  /// Yolculuk Videosu için Varlık Matrisi (Asset Matrix) Oluşturur
  static Map<String, dynamic> generateVideoAssetMatrix({
    required List<DiaryModel> highlightEntries,
    String backgroundMusic = 'Aura_Lullaby.mp3',
    int durationPerSlideSeconds = 4,
  }) {
    final slides = <Map<String, dynamic>>[];

    for (int i = 0; i < highlightEntries.length; i++) {
      final entry = highlightEntries[i];
      slides.add({
        'index': i + 1,
        'week': entry.pregnancyWeek,
        'date': entry.date,
        'title': '${entry.pregnancyWeek}. Hafta Özel Anı',
        'subtitle': entry.noteText ?? 'Bebeğimize Sevgiyle...',
        'image_path': entry.photoPath ?? 'assets/images/sample_ultrasound.png',
        'transition': 'crossfade',
        'duration_sec': durationPerSlideSeconds,
      });
    }

    return {
      'project_name': 'Aura_Pregnancy_TimeLapse',
      'created_at': DateTime.now().toIso8601String(),
      'music_track': backgroundMusic,
      'total_duration_sec': highlightEntries.length * durationPerSlideSeconds,
      'resolution': '1080x1920', // Dikey Mobil Video (9:16)
      'fps': 30,
      'slides': slides,
      'ffmpeg_filter_complex': _buildFFmpegCommand(slides, backgroundMusic),
    };
  }

  /// FFmpeg CLI Filter Complex Komut Dizesi Üretici
  static String _buildFFmpegCommand(List<Map<String, dynamic>> slides, String music) {
    if (slides.isEmpty) return '';
    final count = slides.length;
    final buffer = StringBuffer();

    // Giriş dosyaları
    for (int i = 0; i < count; i++) {
      buffer.write('-loop 1 -t ${slides[i]['duration_sec']} -i input_$i.jpg ');
    }
    buffer.write('-i $music ');

    // Filter complex geçiş efekti
    buffer.write('-filter_complex "');
    for (int i = 0; i < count; i++) {
      buffer.write('[$i:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1[v$i]; ');
    }
    for (int i = 0; i < count; i++) {
      buffer.write('[v$i]');
    }
    buffer.write('concat=n=$count:v=1:a=0[outv]" -map "[outv]" -map $count:a -c:v libx264 -pix_fmt yuv420p -shortest output_timelapse.mp4');

    return buffer.toString();
  }

  /// Simüle Edilmiş Video Render Motoru (Progress Stream)
  static Stream<double> renderTimeLapseProgress() async* {
    for (int p = 0; p <= 100; p += 10) {
      await Future.delayed(const Duration(milliseconds: 250));
      yield p / 100.0;
    }
  }
}
