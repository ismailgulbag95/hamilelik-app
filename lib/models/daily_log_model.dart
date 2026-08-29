/// Aura Pregnancy - Günlük Takip Modeli (Su, Kafein, Kilo, Yürüyüş, Semptomlar)
class DailyLogModel {
  final int? id;
  final String date;               // Tarih (YYYY-MM-DD)
  final int waterIntakeMl;         // Günlük içilen su miktarı (ml) - Hedef: 2500ml
  final int caffeineMg;            // Günlük tüketilen kafein (mg) - Maks limit: 200mg
  final int stepCount;             // Günlük atılan adım sayısı - Hedef: 6000 adım
  final int walkingMinutes;        // Günlük yürüyüş süresi (dakika) - Hedef: 30 dk
  final double? weightEntry;       // Günlük tartı kilo girişi (kg)
  final String? symptomNotes;      // Günlük semptomlar ve notlar

  DailyLogModel({
    this.id,
    required this.date,
    this.waterIntakeMl = 0,
    this.caffeineMg = 0,
    this.stepCount = 0,
    this.walkingMinutes = 0,
    this.weightEntry,
    this.symptomNotes,
  });

  /// Map'ten Model Üretici
  factory DailyLogModel.fromMap(Map<String, dynamic> map) {
    return DailyLogModel(
      id: map['id'] as int?,
      date: map['date'] as String,
      waterIntakeMl: (map['water_intake_ml'] as int?) ?? 0,
      caffeineMg: (map['caffeine_mg'] as int?) ?? 0,
      stepCount: (map['step_count'] as int?) ?? 0,
      walkingMinutes: (map['walking_minutes'] as int?) ?? 0,
      weightEntry: (map['weight_entry'] as num?)?.toDouble(),
      symptomNotes: map['symptom_notes'] as String?,
    );
  }

  /// Veritabanı için Map Dönüşümü
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'date': date,
      'water_intake_ml': waterIntakeMl,
      'caffeine_mg': caffeineMg,
      'step_count': stepCount,
      'walking_minutes': walkingMinutes,
      'weight_entry': weightEntry,
      'symptom_notes': symptomNotes,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  /// Kafein sınırı (200 mg) aşıldı mı?
  bool get isCaffeineOverLimit => caffeineMg > 200;

  /// Kafein kalan güvenli miktar (mg)
  int get remainingSafeCaffeineMg => (200 - caffeineMg) > 0 ? (200 - caffeineMg) : 0;

  /// Günlük su hedefi oranı (2500 ml üzerinden)
  double get waterProgressRatio {
    const target = 2500.0;
    return (waterIntakeMl / target).clamp(0.0, 1.0);
  }

  /// Günlük adım hedefi oranı (6000 adım üzerinden)
  double get stepProgressRatio {
    const target = 6000.0;
    return (stepCount / target).clamp(0.0, 1.0);
  }

  /// Tahmini yürüyüş mesafesi (km)
  double get estimatedKm => (stepCount * 0.0007);

  /// Tahmini yakılan kalori (kcal)
  int get estimatedBurnedKcal => (stepCount * 0.04).round();

  DailyLogModel copyWith({
    int? id,
    String? date,
    int? waterIntakeMl,
    int? caffeineMg,
    int? stepCount,
    int? walkingMinutes,
    double? weightEntry,
    String? symptomNotes,
  }) {
    return DailyLogModel(
      id: id ?? this.id,
      date: date ?? this.date,
      waterIntakeMl: waterIntakeMl ?? this.waterIntakeMl,
      caffeineMg: caffeineMg ?? this.caffeineMg,
      stepCount: stepCount ?? this.stepCount,
      walkingMinutes: walkingMinutes ?? this.walkingMinutes,
      weightEntry: weightEntry ?? this.weightEntry,
      symptomNotes: symptomNotes ?? this.symptomNotes,
    );
  }
}
