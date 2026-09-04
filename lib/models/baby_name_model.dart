/// Aura Pregnancy - Bebek İsim Modeli
class BabyNameModel {
  final int? id;
  final String name;
  final String gender; // 'girl', 'boy', 'unisex'
  final String origin; // 'Türkçe', 'Arapça', 'Farsça', 'Evrensel', 'Latince' vb.
  final String meaning;
  final String characteristics; // Karakter ve mizaç analizi
  final String? culturalNote; // Ekstra kültürel veya şiirsel detay
  final bool isFavorite;

  const BabyNameModel({
    this.id,
    required this.name,
    required this.gender,
    required this.origin,
    required this.meaning,
    required this.characteristics,
    this.culturalNote,
    this.isFavorite = false,
  });

  BabyNameModel copyWith({
    int? id,
    String? name,
    String? gender,
    String? origin,
    String? meaning,
    String? characteristics,
    String? culturalNote,
    bool? isFavorite,
  }) {
    return BabyNameModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      origin: origin ?? this.origin,
      meaning: meaning ?? this.meaning,
      characteristics: characteristics ?? this.characteristics,
      culturalNote: culturalNote ?? this.culturalNote,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'gender': gender,
      'origin': origin,
      'meaning': meaning,
      'characteristics': characteristics,
      'cultural_note': culturalNote,
      'is_favorite': isFavorite ? 1 : 0,
    };
  }

  factory BabyNameModel.fromMap(Map<String, dynamic> map) {
    return BabyNameModel(
      id: map['id'] as int?,
      name: map['name'] as String? ?? '',
      gender: map['gender'] as String? ?? 'unisex',
      origin: map['origin'] as String? ?? 'Evrensel',
      meaning: map['meaning'] as String? ?? '',
      characteristics: map['characteristics'] as String? ?? '',
      culturalNote: map['cultural_note'] as String?,
      isFavorite: (map['is_favorite'] as int? ?? 0) == 1,
    );
  }
}
