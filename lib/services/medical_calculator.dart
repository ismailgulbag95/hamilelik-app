import '../core/constants/medical_specs.dart';

/// Aura Pregnancy - Tıbbi Hesaplama Servisi
class MedicalCalculator {
  /// Son Adet Tarihi'ne (SAT) göre Tahmini Doğum Tarihini Hesaplar (Naegele Kuralı: SAT + 280 Gün / 40 Hafta)
  static DateTime calculateDueDateFromLmp(DateTime lmp) {
    return lmp.add(const Duration(days: 280));
  }

  /// Doğum Tarihine göre Son Adet Tarihini (SAT) Tahmin Eder (Doğum - 280 Gün)
  static DateTime calculateLmpFromDueDate(DateTime dueDate) {
    return dueDate.subtract(const Duration(days: 280));
  }

  /// SAT'a göre gebeliğin kaçıncı haftasında (1-40) olunduğunu hesaplar
  static int calculateCurrentWeekFromLmp(DateTime lmp, [DateTime? currentDate]) {
    final now = currentDate ?? DateTime.now();
    final differenceDays = now.difference(lmp).inDays;
    if (differenceDays < 0) return 1;
    final week = (differenceDays ~/ 7) + 1;
    return week.clamp(1, 42);
  }

  /// Tahmini Doğum Tarihine göre gebeliğin kaçıncı haftasında olunduğunu hesaplar
  static int calculateCurrentWeekFromDueDate(DateTime dueDate, [DateTime? currentDate]) {
    final lmp = calculateLmpFromDueDate(dueDate);
    return calculateCurrentWeekFromLmp(lmp, currentDate);
  }

  /// Gebelik Gününü ve Haftasını Detaylı Döndürür (Örn: "24 Hafta + 3 Gün")
  static Map<String, int> getDetailedPregnancyAge(DateTime lmp, [DateTime? currentDate]) {
    final now = currentDate ?? DateTime.now();
    final totalDays = now.difference(lmp).inDays;
    if (totalDays < 0) return {'weeks': 1, 'days': 0, 'totalDays': 0};
    final weeks = totalDays ~/ 7;
    final remainingDays = totalDays % 7;
    return {
      'weeks': weeks.clamp(0, 42),
      'days': remainingDays,
      'totalDays': totalDays,
    };
  }

  /// Vücut Kitle İndeksi (VKİ) Hesaplar (VKİ = Kilo (kg) / (Boy(m))^2)
  static double calculateVki({required double weightKg, required double heightCm}) {
    if (heightCm <= 0 || weightKg <= 0) return 0.0;
    final heightMeter = heightCm / 100.0;
    final vki = weightKg / (heightMeter * heightMeter);
    return double.parse(vki.toStringAsFixed(1));
  }

  /// VKİ Sınıfını Döndürür ('Underweight', 'Normal', 'Overweight', 'Obese')
  static String getVkiCategoryKey(double vki) {
    if (vki < 18.5) return 'Underweight';
    if (vki < 25.0) return 'Normal';
    if (vki < 30.0) return 'Overweight';
    return 'Obese';
  }

  /// VKİ Sınıfına göre Tıbbi Kilo Alım Rehberini Döndürür
  static Map<String, dynamic> getWeightGainGuideline(double vki) {
    final category = getVkiCategoryKey(vki);
    return PregnancyMedicalSpecs.vkiWeightGainGuidelines[category] ??
        PregnancyMedicalSpecs.vkiWeightGainGuidelines['Normal']!;
  }

  /// Mevcut haftaya göre hedeflenen ideal kilo alım aralığını hesaplar
  static Map<String, double> calculateTargetWeightForWeek({
    required double prePregnancyWeight,
    required double vki,
    required int week,
  }) {
    final guideline = getWeightGainGuideline(vki);
    final weeklyRate = (guideline['weekly'] as num).toDouble();
    
    // 1. Trimesterde (1-13. haftalar) toplam ortalama 0.5 - 2.0 kg alınır
    // 2. ve 3. Trimesterlerde haftalık artış eklenir
    double targetGain = 0.0;
    if (week > 13) {
      final weeksIn2nd3rd = week - 13;
      targetGain = 1.0 + (weeksIn2nd3rd * weeklyRate);
    } else {
      targetGain = (week / 13.0) * 1.0;
    }

    return {
      'target_gain': double.parse(targetGain.toStringAsFixed(2)),
      'target_weight': double.parse((prePregnancyWeight + targetGain).toStringAsFixed(2)),
    };
  }

  /// Trimester Numarasını Döndürür (1, 2, 3)
  static int getTrimester(int week) {
    if (week <= 13) return 1;
    if (week <= 27) return 2;
    return 3;
  }
}
