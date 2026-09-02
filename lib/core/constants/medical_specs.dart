import 'package:easy_localization/easy_localization.dart';

/// Aura Pregnancy - Değişmez Tıbbi Referans Veri Tabanı
/// Bu sınıftaki değerler tıbbi doğruluğu korumak için immutable / sabit veri olarak kodlanmıştır.
class PregnancyMedicalSpecs {
  static const double maxCaffeineMgPerDay = 200.0;
  static const double emergencyFeverCelsius = 38.0;

  /// VKİ Kilo Alım Rehberi (Institute of Medicine - IOM Standartları)
  static const Map<String, Map<String, dynamic>> vkiWeightGainGuidelines = {
    'Underweight': {
      'category_tr': 'Zayıf (VKİ < 18.5)',
      'range': '12.5 - 18.0 kg',
      'min_kg': 12.5,
      'max_kg': 18.0,
      'weekly': 0.51,
      'weekly_desc': 'Haftalık İdeal Artış: ~0.51 kg'
    },
    'Normal': {
      'category_tr': 'Normal (VKİ 18.5 - 24.9)',
      'range': '11.5 - 16.0 kg',
      'min_kg': 11.5,
      'max_kg': 16.0,
      'weekly': 0.42,
      'weekly_desc': 'Haftalık İdeal Artış: ~0.42 kg'
    },
    'Overweight': {
      'category_tr': 'Kilolu (VKİ 25.0 - 29.9)',
      'range': '7.0 - 11.5 kg',
      'min_kg': 7.0,
      'max_kg': 11.5,
      'weekly': 0.28,
      'weekly_desc': 'Haftalık İdeal Artış: ~0.28 kg'
    },
    'Obese': {
      'category_tr': 'Obez (VKİ ≥ 30.0)',
      'range': '5.0 - 9.0 kg',
      'min_kg': 5.0,
      'max_kg': 9.0,
      'weekly': 0.22,
      'weekly_desc': 'Haftalık İdeal Artış: ~0.22 kg'
    }
  };

  /// Trimester Kalori & Enerji Gereksinimleri
  static const Map<int, String> trimesterEnergyRequirements = {
    1: '1. Trimester (1-13. Haftalar): +0 kkal/gün ek enerji. Odak: Folik asit (400-800 mcg/gün) ve bulantı yönetimi.',
    2: '2. Trimester (14-27. Haftalar): +340 kkal/gün ek enerji. Odak: Protein, kalsiyum, demir ve omega-3 alımı.',
    3: '3. Trimester (28-40. Haftalar): +452 kkal/gün ek enerji. Odak: Hızlı bebek büyümesi, protein ve ödem riski için tuz kısıtlaması.'
  };

  /// Hafta Hafta Kritik Tıbbi Tarama ve Test Takvimi
  static Map<int, Map<String, String>> get medicalMilestones => {
    10: {
      'test': 'milestone_10_title'.tr(),
      'desc': 'milestone_10_desc'.tr()
    },
    11: {
      'test': 'milestone_11_title'.tr(),
      'desc': 'milestone_11_desc'.tr()
    },
    12: {
      'test': 'milestone_12_title'.tr(),
      'desc': 'milestone_12_desc'.tr()
    },
    15: {
      'test': 'milestone_16_title'.tr(),
      'desc': 'milestone_16_desc'.tr()
    },
    20: {
      'test': 'milestone_20_title'.tr(),
      'desc': 'milestone_20_desc'.tr()
    },
    24: {
      'test': 'milestone_24_title'.tr(),
      'desc': 'milestone_24_desc'.tr()
    },
    28: {
      'test': 'milestone_28_title'.tr(),
      'desc': 'milestone_28_desc'.tr()
    }
  };

  /// Acil Uyarı İşaretleri (Kırmızı Alarm Listesi)
  static List<Map<String, String>> get redFlagEmergencySigns => [
    {
      'title': 'emergency_sign_1_title'.tr(),
      'detail': 'emergency_sign_1_desc'.tr(),
      'urgency': 'emergency_urgency_high'.tr(),
    },
    {
      'title': 'emergency_sign_2_title'.tr(),
      'detail': 'emergency_sign_2_desc'.tr(),
      'urgency': 'emergency_urgency_critical'.tr(),
    },
    {
      'title': 'emergency_sign_3_title'.tr(),
      'detail': 'emergency_sign_3_desc'.tr(),
      'urgency': 'emergency_urgency_critical'.tr(),
    },
    {
      'title': 'emergency_sign_4_title'.tr(),
      'detail': 'emergency_sign_4_desc'.tr(),
      'urgency': 'emergency_urgency_high'.tr(),
    },
    {
      'title': 'emergency_sign_5_title'.tr(),
      'detail': 'emergency_sign_5_desc'.tr(),
      'urgency': 'emergency_urgency_critical'.tr(),
    },
    {
      'title': 'emergency_sign_6_title'.tr(),
      'detail': 'emergency_sign_6_desc'.tr(),
      'urgency': 'emergency_urgency_high'.tr(),
    },
    {
      'title': 'emergency_sign_7_title'.tr(),
      'detail': 'emergency_sign_7_desc'.tr(),
      'urgency': 'emergency_urgency_critical'.tr(),
    },
    {
      'title': 'emergency_sign_8_title'.tr(),
      'detail': 'emergency_sign_8_desc'.tr(),
      'urgency': 'emergency_urgency_medium_high'.tr(),
    }
  ];
}
