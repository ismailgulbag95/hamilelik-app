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
  static const Map<int, Map<String, String>> medicalMilestones = {
    10: {
      'test': 'NIPT (Kromozomal Tarama)',
      'desc': 'Non-invaziv Prenatal Test bu haftadan itibaren kromozomal anomalileri taramak için uygulanabilir.'
    },
    11: {
      'test': 'İkili Tarama Testi Başlangıcı',
      'desc': 'Ense kalınlığı (NT) ölçümü ve kan testleri için hazırlık yapın.'
    },
    12: {
      'test': 'İkili Tarama Dönemi',
      'desc': 'Ense kalınlığı ölçümü ile PAPP-A ve serbest β-hCG ölçümlerini içeren ikili tarama bu hafta uygulanmalıdır.'
    },
    15: {
      'test': 'Üçlü/Dörtlü Tarama Planı',
      'desc': 'AFP, hCG, estriol ve inhibin-A değerlerinin inceleneceği tarama testlerini doktorunuzla planlayın.'
    },
    20: {
      'test': 'Ayrıntılı Ultrason (Morfoloji)',
      'desc': 'Bebeğin organlarının, kalbinin ve beyninin detaylı olarak inceleneceği ikinci trimester morfoloji taraması bu hafta yapılır.'
    },
    24: {
      'test': 'Gestasyonel Diyabet Taraması',
      'desc': '50 gr glukoz yükleme testi ile gebelik şekeri taraması bu haftalarda (24-28) planlanır.'
    },
    28: {
      'test': 'Anti-D Değerlendirmesi & NST',
      'desc': 'Kan uyuşmazlığı (Rh negatif) olan gebelerde Anti-D iğnesi değerlendirmesi ve rutin NST kontrolleri başlar.'
    }
  };

  /// Acil Uyarı İşaretleri (Kırmızı Alarm Listesi)
  static const List<Map<String, String>> redFlagEmergencySigns = [
    {
      'title': 'Şiddetli ve Ani Karın/Kasık Ağrısı',
      'detail': 'Geçmeyen, kramp şeklinde veya batıcı ani şiddetli sancılar.',
      'urgency': 'Yüksek'
    },
    {
      'title': 'Vajinal Kanama veya Lekelenme',
      'detail': 'Miktarı ne olursa olsun her türlü açık kırmızı veya koyu kanama acil hekim kontrolü gerektirir.',
      'urgency': 'Kritik'
    },
    {
      'title': 'Şiddetli Baş Ağrısı ve Görme Bozukluğu',
      'detail': 'Bulanık görme, ışık çakmaları veya ani baş dönmesi (Preeklampsi işareti).',
      'urgency': 'Kritik'
    },
    {
      'title': 'Yüzde ve Ellerde Ani Şişme (Ödem)',
      'detail': 'Özellikle göz çevresinde ve parmaklarda hızla gelişen aşırı şişkinlik.',
      'urgency': 'Yüksek'
    },
    {
      'title': 'Bebek Hareketlerinde Belirgin Azalma',
      'detail': '20. haftadan sonra bebeğin hareket hissinin aniden kesilmesi veya 2 saatte 10 hareketin altına inmesi.',
      'urgency': 'Kritik'
    },
    {
      'title': '38°C ve Üzeri Yüksek Ateş',
      'detail': 'Titreme, halsizlik veya kötü kokulu akıntının eşlik ettiği ateş.',
      'urgency': 'Yüksek'
    },
    {
      'title': 'Erken Su Gelmesi (Amniyotik Sıvı)',
      'detail': 'Vajinadan berrak sıvı sızıntısı veya aniden su boşalması.',
      'urgency': 'Kritik'
    },
    {
      'title': 'Sıvı Tutamayacak Kadar Şiddetli Kusma',
      'detail': 'Aşırı dehidrasyon, idrar miktarında azalma ve genel düşkünlük.',
      'urgency': 'Orta-Yüksek'
    }
  ];
}
