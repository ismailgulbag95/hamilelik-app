import 'package:intl/intl.dart';

/// Aura Pregnancy - Tarih ve Saat Yardımcı Fonksiyonları
class AppDateUtils {
  static final DateFormat isoDateFormat = DateFormat('yyyy-MM-dd');

  /// Bugünün biçimlendirilmiş Türkçe tarihini döndürür
  static String formatToday() {
    try {
      return DateFormat('d MMMM yyyy', 'tr_TR').format(DateTime.now());
    } catch (_) {
      try {
        return DateFormat('d MMMM yyyy').format(DateTime.now());
      } catch (e) {
        final now = DateTime.now();
        return '${now.day}.${now.month}.${now.year}';
      }
    }
  }

  /// ISO formatındaki tarihi ('2026-08-27') '27 Ağustos 2026' şeklinde formatlar
  static String formatDisplay(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('d MMMM yyyy', 'tr_TR').format(date);
    } catch (_) {
      try {
        final date = DateTime.parse(isoDate);
        return DateFormat('d MMMM yyyy').format(date);
      } catch (e) {
        return isoDate;
      }
    }
  }

  /// Kısa gün ve ay formatı ('27 Ağu')
  static String formatShort(DateTime date) {
    try {
      return DateFormat('d MMM', 'tr_TR').format(date);
    } catch (_) {
      return '${date.day}.${date.month}';
    }
  }

  /// Bugünün ISO Tarih Dizgisini Döndürür ('2026-08-27')
  static String todayIso() {
    return isoDateFormat.format(DateTime.now());
  }

  /// DateTime nesnesini ISO formatına dönüştürür
  static String toIso(DateTime date) {
    return isoDateFormat.format(date);
  }

  /// Doğuma kalan gün sayısını hesaplar
  static int daysUntil(String dueDateIso) {
    try {
      final dueDate = DateTime.parse(dueDateIso);
      final now = DateTime.now();
      final difference = dueDate.difference(now).inDays;
      return difference > 0 ? difference : 0;
    } catch (_) {
      return 0;
    }
  }
}
