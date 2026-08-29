/// Aura Pregnancy - İlaç ve Vitamin Takip Modeli
class MedicationModel {
  final int? id;
  final String name;          // İlaç / Vitamin Adı (örn: Folik Asit, Demir, Magnezyum)
  final String dosage;        // Dozaj (örn: 1 Tablet, 400 mcg)
  final String time;          // Alım Saati / Öğünü (örn: 09:00, Sabah Tok)
  final String? lastTakenDate;// En son alındığı günün tarihi (YYYY-MM-DD)
  final String category;      // Kategori (Vitamin, Mineral, İlaç, Takviye)

  MedicationModel({
    this.id,
    required this.name,
    this.dosage = '1 Tablet',
    this.time = 'Sabah',
    this.lastTakenDate,
    this.category = 'Vitamin',
  });

  /// Bugün alınıp alınmadığını kontrol eder
  bool isTakenOnDate(String dateIso) {
    return lastTakenDate == dateIso;
  }

  /// SQLite Map Dönüşümleri
  factory MedicationModel.fromMap(Map<String, dynamic> map) {
    return MedicationModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      dosage: (map['dosage'] as String?) ?? '1 Tablet',
      time: (map['time'] as String?) ?? 'Sabah',
      lastTakenDate: map['last_taken_date'] as String?,
      category: (map['category'] as String?) ?? 'Vitamin',
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'dosage': dosage,
      'time': time,
      'last_taken_date': lastTakenDate,
      'category': category,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  MedicationModel copyWith({
    int? id,
    String? name,
    String? dosage,
    String? time,
    String? lastTakenDate,
    String? category,
  }) {
    return MedicationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      time: time ?? this.time,
      lastTakenDate: lastTakenDate ?? this.lastTakenDate,
      category: category ?? this.category,
    );
  }
}
