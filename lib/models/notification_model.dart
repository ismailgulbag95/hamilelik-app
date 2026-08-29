/// Aura Pregnancy - Bildirim Modeli (Tıbbi & Romantik Hatırlatıcılar)
class NotificationModel {
  final int? id;
  final int week;                  // İlgili gebelik haftası
  final String triggerTime;        // Tetiklenme zamanı / Tarih (ISO String)
  final String title;              // Bildirim başlığı
  final String body;               // Bildirim metni
  final bool isRead;               // Okundu mu?
  final String type;               // 'medical', 'romantic', 'milestone', 'alarm'

  NotificationModel({
    this.id,
    required this.week,
    required this.triggerTime,
    required this.title,
    required this.body,
    this.isRead = false,
    required this.type,
  });

  /// Map'ten Model Üretici
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int?,
      week: map['week'] as int,
      triggerTime: map['trigger_time'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      isRead: (map['is_read'] == 1 || map['is_read'] == true),
      type: map['type'] as String,
    );
  }

  /// Veritabanı için Map Dönüşümü
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'week': week,
      'trigger_time': triggerTime,
      'title': title,
      'body': body,
      'is_read': isRead ? 1 : 0,
      'type': type,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  NotificationModel copyWith({
    int? id,
    int? week,
    String? triggerTime,
    String? title,
    String? body,
    bool? isRead,
    String? type,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      week: week ?? this.week,
      triggerTime: triggerTime ?? this.triggerTime,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }
}
