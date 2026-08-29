/// Aura Pregnancy - Romantik Anı Günlüğü Modeli
class DiaryModel {
  final int? id;
  final int pregnancyWeek;         // Hangi gebelik haftasında kaydedildi (1-40)
  final String date;               // Tarih (YYYY-MM-DD)
  final String? noteText;          // Anı / Günlük / Mektup metni
  final String? photoPath;         // Fotoğraf yolu veya URL/Base64
  final String? audioPath;         // Sesli mektup / ses kaydı yolu
  final int moodRating;            // Ruh hali (1: Üzgün/Yorgun, 2: Durgun, 3: İyi, 4: Mutlu, 5: Harika/Romantik)
  final bool isRomanticHighlight;  // Time-lapse Yolculuk Videosu için seçilen özel an mı?

  DiaryModel({
    this.id,
    required this.pregnancyWeek,
    required this.date,
    this.noteText,
    this.photoPath,
    this.audioPath,
    this.moodRating = 5,
    this.isRomanticHighlight = false,
  });

  /// Map'ten Model Üretici (SQLite uyumlu)
  factory DiaryModel.fromMap(Map<String, dynamic> map) {
    return DiaryModel(
      id: map['id'] as int?,
      pregnancyWeek: map['pregnancy_week'] as int,
      date: map['date'] as String,
      noteText: map['note_text'] as String?,
      photoPath: map['photo_path'] as String?,
      audioPath: map['audio_path'] as String?,
      moodRating: (map['mood_rating'] as int?) ?? 5,
      isRomanticHighlight: (map['is_romantic_highlight'] == 1 || map['is_romantic_highlight'] == true),
    );
  }

  /// Veritabanı için Map Dönüşümü
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'pregnancy_week': pregnancyWeek,
      'date': date,
      'note_text': noteText,
      'photo_path': photoPath,
      'audio_path': audioPath,
      'mood_rating': moodRating,
      'is_romantic_highlight': isRomanticHighlight ? 1 : 0,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  DiaryModel copyWith({
    int? id,
    int? pregnancyWeek,
    String? date,
    String? noteText,
    String? photoPath,
    String? audioPath,
    int? moodRating,
    bool? isRomanticHighlight,
  }) {
    return DiaryModel(
      id: id ?? this.id,
      pregnancyWeek: pregnancyWeek ?? this.pregnancyWeek,
      date: date ?? this.date,
      noteText: noteText ?? this.noteText,
      photoPath: photoPath ?? this.photoPath,
      audioPath: audioPath ?? this.audioPath,
      moodRating: moodRating ?? this.moodRating,
      isRomanticHighlight: isRomanticHighlight ?? this.isRomanticHighlight,
    );
  }
}
