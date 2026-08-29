import 'package:flutter_test/flutter_test.dart';
import 'package:aura_pregnancy/core/constants/medical_specs.dart';
import 'package:aura_pregnancy/services/medical_calculator.dart';
import 'package:aura_pregnancy/models/profile_model.dart';
import 'package:aura_pregnancy/models/daily_log_model.dart';

void main() {
  group('Aura Pregnancy Tıbbi Standartlar & Hesaplamalar Testi', () {
    test('Sabit tıbbi kısıtlamalar doğrulanmalıdır', () {
      expect(PregnancyMedicalSpecs.maxCaffeineMgPerDay, equals(200.0));
      expect(PregnancyMedicalSpecs.emergencyFeverCelsius, equals(38.0));
      expect(PregnancyMedicalSpecs.medicalMilestones.containsKey(10), isTrue);
      expect(PregnancyMedicalSpecs.medicalMilestones.containsKey(24), isTrue);
    });

    test('VKİ ve kilo aralığı hesaplaması doğru çalışmalıdır', () {
      // 165 cm boy, 60 kg hamilelik öncesi kilo => VKİ = 60 / (1.65^2) = 22.03 => Normal
      final vki = MedicalCalculator.calculateVki(weightKg: 60.0, heightCm: 165.0);
      expect(vki, equals(22.0));

      final category = MedicalCalculator.getVkiCategoryKey(vki);
      expect(category, equals('Normal'));

      final guideline = MedicalCalculator.getWeightGainGuideline(vki);
      expect(guideline['range'], equals('11.5 - 16.0 kg'));
      expect(guideline['weekly'], equals(0.42));
    });

    test('Obez ve zayıf VKİ sınıflandırma doğrulaması', () {
      final underweightVki = MedicalCalculator.calculateVki(weightKg: 45.0, heightCm: 165.0); // ~16.5
      expect(MedicalCalculator.getVkiCategoryKey(underweightVki), equals('Underweight'));

      final obeseVki = MedicalCalculator.calculateVki(weightKg: 95.0, heightCm: 165.0); // ~34.8
      expect(MedicalCalculator.getVkiCategoryKey(obeseVki), equals('Obese'));
    });

    test('Son Adet Tarihinden (SAT) Doğum Tarihi Hesaplama', () {
      final lmp = DateTime(2026, 1, 1);
      final dueDate = MedicalCalculator.calculateDueDateFromLmp(lmp);
      // 1 Ocak + 280 Gün = 8 Ekim 2026
      expect(dueDate.year, equals(2026));
      expect(dueDate.month, equals(10));
      expect(dueDate.day, equals(8));
    });

    test('Kafein sınırı kontrolü (DailyLogModel)', () {
      final logSafe = DailyLogModel(date: '2026-08-27', caffeineMg: 120);
      expect(logSafe.isCaffeineOverLimit, isFalse);
      expect(logSafe.remainingSafeCaffeineMg, equals(80));

      final logOver = DailyLogModel(date: '2026-08-27', caffeineMg: 240);
      expect(logOver.isCaffeineOverLimit, isTrue);
      expect(logOver.remainingSafeCaffeineMg, equals(0));
    });

    test('Trimester belirleme doğrulaması', () {
      expect(MedicalCalculator.getTrimester(5), equals(1));
      expect(MedicalCalculator.getTrimester(13), equals(1));
      expect(MedicalCalculator.getTrimester(14), equals(2));
      expect(MedicalCalculator.getTrimester(27), equals(2));
      expect(MedicalCalculator.getTrimester(28), equals(3));
      expect(MedicalCalculator.getTrimester(40), equals(3));
    });
  });
}
