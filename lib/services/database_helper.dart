import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/profile_model.dart';
import '../models/diary_model.dart';
import '../models/daily_log_model.dart';
import '../models/notification_model.dart';
import '../models/medication_model.dart';

/// Aura Pregnancy - SQLite & Web Uyumlu Yerel Veritabanı Yöneticisi (DatabaseHelper)
class DatabaseHelper {
  static const String _databaseName = 'aura_pregnancy.db';
  static const int _databaseVersion = 4;

  // Singleton Örneği
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  /// Canlı Reaktif Veri Değişim Bildiricisi (Tüm ekranları anında günceller)
  static final ValueNotifier<int> appDataRevision = ValueNotifier<int>(0);
  static void notifyDataChanged() {
    appDataRevision.value++;
  }

  static Database? _database;
  bool _useFallback = false;

  // Web veya Fallback ortamı için In-Memory Depolama
  ProfileModel? _webProfile;
  final List<DiaryModel> _webDiaries = [];
  final Map<String, DailyLogModel> _webDailyLogs = {};
  final List<NotificationModel> _webNotifications = [];
  final List<MedicationModel> _webMedications = [];

  /// Veritabanı örneğini döndürür (Lazy initialization)
  Future<Database?> get database async {
    if (kIsWeb || _useFallback) {
      return null;
    }
    if (_database != null) return _database!;
    try {
      _database = await _initDatabase();
      return _database;
    } catch (e) {
      debugPrint('Database initialization warning: $e -> Fallback to in-memory store.');
      _useFallback = true;
      return null;
    }
  }

  /// Veritabanı başlatma
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Tabloları Oluşturma
  Future<void> _onCreate(Database db, int version) async {
    // 1. profile tablosu (Anne, Bebek İsmi ve Cinsiyet Alanları Dahil)
    await db.execute('''
      CREATE TABLE profile (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        due_date TEXT NOT NULL,
        lmp_date TEXT,
        pre_pregnancy_weight REAL NOT NULL,
        height REAL NOT NULL,
        vki REAL NOT NULL,
        current_week INTEGER NOT NULL,
        mom_name TEXT,
        partner_name TEXT,
        baby_name TEXT,
        baby_gender TEXT DEFAULT 'surprise'
      )
    ''');

    // 2. diary (Anı Günlüğü) tablosu
    await db.execute('''
      CREATE TABLE diary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pregnancy_week INTEGER NOT NULL,
        date TEXT NOT NULL,
        note_text TEXT,
        photo_path TEXT,
        audio_path TEXT,
        mood_rating INTEGER DEFAULT 5,
        is_romantic_highlight INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // 3. daily_log (Günlük Su, Kafein, Adım, Yürüyüş, Kilo, Semptom) tablosu
    await db.execute('''
      CREATE TABLE daily_log (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL UNIQUE,
        water_intake_ml INTEGER NOT NULL DEFAULT 0,
        caffeine_mg INTEGER NOT NULL DEFAULT 0,
        step_count INTEGER NOT NULL DEFAULT 0,
        walking_minutes INTEGER NOT NULL DEFAULT 0,
        weight_entry REAL,
        symptom_notes TEXT
      )
    ''');

    // 4. notifications tablosu
    await db.execute('''
      CREATE TABLE notifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        week INTEGER NOT NULL,
        trigger_time TEXT NOT NULL,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        is_read INTEGER NOT NULL DEFAULT 0,
        type TEXT NOT NULL
      )
    ''');

    // 5. medications (İlaç ve Vitamin Takip) tablosu
    await db.execute('''
      CREATE TABLE medications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        dosage TEXT,
        time TEXT,
        last_taken_date TEXT,
        category TEXT
      )
    ''');

    // İndeksler (Hızlı sorgulama için)
    await db.execute('CREATE INDEX idx_diary_week ON diary(pregnancy_week)');
    await db.execute('CREATE INDEX idx_diary_date ON diary(date)');
    await db.execute('CREATE INDEX idx_daily_log_date ON daily_log(date)');
    await db.execute('CREATE INDEX idx_notif_week ON notifications(week)');
  }

  /// Veritabanı Yükseltme / Migrasyon
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      try {
        await db.execute('ALTER TABLE daily_log ADD COLUMN step_count INTEGER NOT NULL DEFAULT 0');
      } catch (_) {}
      try {
        await db.execute('ALTER TABLE daily_log ADD COLUMN walking_minutes INTEGER NOT NULL DEFAULT 0');
      } catch (_) {}
    }
    if (oldVersion < 3) {
      try {
        await db.execute('ALTER TABLE profile ADD COLUMN mom_name TEXT');
      } catch (_) {}
      try {
        await db.execute('ALTER TABLE profile ADD COLUMN partner_name TEXT');
      } catch (_) {}
      try {
        await db.execute('ALTER TABLE profile ADD COLUMN baby_name TEXT');
      } catch (_) {}
      try {
        await db.execute("ALTER TABLE profile ADD COLUMN baby_gender TEXT DEFAULT 'surprise'");
      } catch (_) {}
    }
    if (oldVersion < 4) {
      try {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS medications (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            dosage TEXT,
            time TEXT,
            last_taken_date TEXT,
            category TEXT
          )
        ''');
      } catch (_) {}
    }
  }

  // ==========================================
  // 1. PROFİL CRUD İŞLEMLERİ
  // ==========================================

  Future<int> saveProfile(ProfileModel profile) async {
    _webProfile = profile.copyWith(id: profile.id ?? 1);
    final db = await database;
    notifyDataChanged();
    if (db == null) {
      return 1;
    }
    try {
      final existing = await getProfile();
      if (existing != null && existing.id != null) {
        final res = await db.update(
          'profile',
          profile.toMap(),
          where: 'id = ?',
          whereArgs: [existing.id],
        );
        notifyDataChanged();
        return res;
      } else {
        final id = await db.insert('profile', profile.toMap());
        _webProfile = profile.copyWith(id: id);
        notifyDataChanged();
        return id;
      }
    } catch (e) {
      debugPrint('saveProfile db error, using fallback: $e');
      notifyDataChanged();
      return 1;
    }
  }

  Future<ProfileModel?> getProfile() async {
    final db = await database;
    if (db == null) {
      return _webProfile;
    }
    try {
      final maps = await db.query('profile', limit: 1);
      if (maps.isNotEmpty) {
        final prof = ProfileModel.fromMap(maps.first);
        _webProfile = prof;
        return prof;
      }
      return _webProfile;
    } catch (e) {
      debugPrint('getProfile db error, using fallback: $e');
      return _webProfile;
    }
  }

  Future<ProfileModel> ensureDefaultProfile() async {
    final existing = await getProfile();
    if (existing != null) return existing;
    final now = DateTime.now();
    final defaultLmp = now.subtract(const Duration(days: 84));
    final defaultDue = defaultLmp.add(const Duration(days: 280));
    final defaultProfile = ProfileModel(
      dueDate: defaultDue.toIso8601String(),
      lmpDate: defaultLmp.toIso8601String(),
      prePregnancyWeight: 60.0,
      height: 165.0,
      vki: 22.0,
      currentWeek: 12,
    );
    final id = await saveProfile(defaultProfile);
    return defaultProfile.copyWith(id: id);
  }

  Future<int> updateCurrentWeek(int week) async {
    if (_webProfile != null) {
      _webProfile = _webProfile!.copyWith(currentWeek: week);
    }
    final db = await database;
    notifyDataChanged();
    if (db == null) {
      return 1;
    }
    try {
      final res = await db.rawUpdate('UPDATE profile SET current_week = ?', [week]);
      notifyDataChanged();
      return res;
    } catch (e) {
      debugPrint('updateCurrentWeek error: $e');
      notifyDataChanged();
      return 1;
    }
  }

  // ==========================================
  // 2. DIARY (GÜNLÜK & ANI) CRUD İŞLEMLERİ
  // ==========================================

  Future<int> insertDiary(DiaryModel diary) async {
    final newId = _webDiaries.length + 1;
    final modelWithId = diary.copyWith(id: diary.id ?? newId);
    _webDiaries.add(modelWithId);
    notifyDataChanged();

    final db = await database;
    if (db == null) {
      return newId;
    }
    try {
      final res = await db.insert('diary', diary.toMap());
      notifyDataChanged();
      return res;
    } catch (e) {
      debugPrint('insertDiary error: $e');
      notifyDataChanged();
      return newId;
    }
  }

  Future<List<DiaryModel>> getAllDiaries() async {
    final db = await database;
    if (db == null) {
      return List.from(_webDiaries.reversed);
    }
    try {
      final result = await db.query('diary', orderBy: 'date DESC, id DESC');
      if (result.isEmpty && _webDiaries.isNotEmpty) {
        return List.from(_webDiaries.reversed);
      }
      return result.map((m) => DiaryModel.fromMap(m)).toList();
    } catch (e) {
      debugPrint('getAllDiaries error: $e');
      return List.from(_webDiaries.reversed);
    }
  }

  Future<List<DiaryModel>> getDiariesByWeek(int week) async {
    final db = await database;
    if (db == null) {
      return _webDiaries.where((d) => d.pregnancyWeek == week).toList();
    }
    try {
      final result = await db.query(
        'diary',
        where: 'pregnancy_week = ?',
        whereArgs: [week],
        orderBy: 'date DESC',
      );
      if (result.isEmpty) {
        return _webDiaries.where((d) => d.pregnancyWeek == week).toList();
      }
      return result.map((m) => DiaryModel.fromMap(m)).toList();
    } catch (e) {
      debugPrint('getDiariesByWeek error: $e');
      return _webDiaries.where((d) => d.pregnancyWeek == week).toList();
    }
  }

  Future<List<DiaryModel>> getRomanticHighlights() async {
    final db = await database;
    if (db == null) {
      return _webDiaries.where((d) => d.isRomanticHighlight).toList();
    }
    try {
      final result = await db.query(
        'diary',
        where: 'is_romantic_highlight = 1',
        orderBy: 'pregnancy_week ASC, date ASC',
      );
      if (result.isEmpty) {
        return _webDiaries.where((d) => d.isRomanticHighlight).toList();
      }
      return result.map((m) => DiaryModel.fromMap(m)).toList();
    } catch (e) {
      debugPrint('getRomanticHighlights error: $e');
      return _webDiaries.where((d) => d.isRomanticHighlight).toList();
    }
  }

  Future<int> updateDiary(DiaryModel diary) async {
    final idx = _webDiaries.indexWhere((d) => d.id == diary.id);
    if (idx != -1) {
      _webDiaries[idx] = diary;
    }
    notifyDataChanged();
    final db = await database;
    if (db == null) {
      return idx != -1 ? 1 : 0;
    }
    try {
      final res = await db.update(
        'diary',
        diary.toMap(),
        where: 'id = ?',
        whereArgs: [diary.id],
      );
      notifyDataChanged();
      return res;
    } catch (e) {
      debugPrint('updateDiary error: $e');
      notifyDataChanged();
      return 1;
    }
  }

  Future<int> deleteDiary(int id) async {
    _webDiaries.removeWhere((d) => d.id == id);
    notifyDataChanged();
    final db = await database;
    if (db == null) {
      return 1;
    }
    try {
      final res = await db.delete('diary', where: 'id = ?', whereArgs: [id]);
      notifyDataChanged();
      return res;
    } catch (e) {
      debugPrint('deleteDiary error: $e');
      notifyDataChanged();
      return 1;
    }
  }

  // ==========================================
  // 3. DAILY LOG (GÜNLÜK TAKİP) CRUD İŞLEMLERİ
  // ==========================================

  Future<DailyLogModel> getOrCreateDailyLog(String date) async {
    if (!_webDailyLogs.containsKey(date)) {
      _webDailyLogs[date] = DailyLogModel(date: date, id: _webDailyLogs.length + 1);
    }
    final db = await database;
    if (db == null) {
      return _webDailyLogs[date]!;
    }
    try {
      final result = await db.query(
        'daily_log',
        where: 'date = ?',
        whereArgs: [date],
        limit: 1,
      );

      if (result.isNotEmpty) {
        final log = DailyLogModel.fromMap(result.first);
        _webDailyLogs[date] = log;
        return log;
      } else {
        final newLog = DailyLogModel(date: date);
        final id = await db.insert('daily_log', newLog.toMap());
        final savedLog = newLog.copyWith(id: id);
        _webDailyLogs[date] = savedLog;
        return savedLog;
      }
    } catch (e) {
      debugPrint('getOrCreateDailyLog error: $e');
      return _webDailyLogs[date]!;
    }
  }

  Future<int> updateDailyLog(DailyLogModel log) async {
    _webDailyLogs[log.date] = log;
    notifyDataChanged();
    final db = await database;
    if (db == null) {
      return 1;
    }
    try {
      final res = await db.insert(
        'daily_log',
        log.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      notifyDataChanged();
      return res;
    } catch (e) {
      debugPrint('updateDailyLog error: $e');
      notifyDataChanged();
      return 1;
    }
  }

  Future<List<DailyLogModel>> getAllDailyLogs() async {
    final db = await database;
    if (db == null) {
      final list = _webDailyLogs.values.toList();
      list.sort((a, b) => b.date.compareTo(a.date));
      return list;
    }
    try {
      final result = await db.query('daily_log', orderBy: 'date DESC');
      if (result.isEmpty && _webDailyLogs.isNotEmpty) {
        final list = _webDailyLogs.values.toList();
        list.sort((a, b) => b.date.compareTo(a.date));
        return list;
      }
      return result.map((m) => DailyLogModel.fromMap(m)).toList();
    } catch (e) {
      debugPrint('getAllDailyLogs error: $e');
      final list = _webDailyLogs.values.toList();
      list.sort((a, b) => b.date.compareTo(a.date));
      return list;
    }
  }

  Future<List<DailyLogModel>> getRecentLogs(int limit) async {
    final db = await database;
    if (db == null) {
      return _webDailyLogs.values.take(limit).toList();
    }
    try {
      final result = await db.query('daily_log', orderBy: 'date DESC', limit: limit);
      if (result.isEmpty) {
        return _webDailyLogs.values.take(limit).toList();
      }
      return result.map((m) => DailyLogModel.fromMap(m)).toList();
    } catch (e) {
      debugPrint('getRecentLogs error: $e');
      return _webDailyLogs.values.take(limit).toList();
    }
  }

  // ==========================================
  // 4. NOTIFICATIONS CRUD İŞLEMLERİ
  // ==========================================

  Future<int> insertNotification(NotificationModel notification) async {
    _webNotifications.add(notification.copyWith(id: _webNotifications.length + 1));
    final db = await database;
    if (db == null) {
      return 1;
    }
    try {
      return await db.insert('notifications', notification.toMap());
    } catch (e) {
      debugPrint('insertNotification error: $e');
      return 1;
    }
  }

  Future<List<NotificationModel>> getNotificationsForWeek(int week) async {
    final db = await database;
    if (db == null) {
      return _webNotifications.where((n) => n.week == week).toList();
    }
    try {
      final result = await db.query(
        'notifications',
        where: 'week = ?',
        whereArgs: [week],
        orderBy: 'trigger_time ASC',
      );
      if (result.isEmpty) {
        return _webNotifications.where((n) => n.week == week).toList();
      }
      return result.map((m) => NotificationModel.fromMap(m)).toList();
    } catch (e) {
      debugPrint('getNotificationsForWeek error: $e');
      return _webNotifications.where((n) => n.week == week).toList();
    }
  }

  Future<int> markNotificationAsRead(int id) async {
    final idx = _webNotifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      _webNotifications[idx] = _webNotifications[idx].copyWith(isRead: true);
    }
    final db = await database;
    if (db == null) {
      return 1;
    }
    try {
      return await db.update(
        'notifications',
        {'is_read': 1},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint('markNotificationAsRead error: $e');
      return 1;
    }
  }

  // ==========================================
  // 5. MEDICATIONS (İLAÇ & VİTAMİN TAKİBİ) CRUD İŞLEMLERİ
  // ==========================================

  Future<List<MedicationModel>> getMedications() async {
    final db = await database;
    if (db == null) {
      if (_webMedications.isEmpty) {
        await ensureDefaultMedications();
      }
      return List.from(_webMedications);
    }
    try {
      final result = await db.query('medications', orderBy: 'id ASC');
      if (result.isEmpty) {
        await ensureDefaultMedications();
        final refreshed = await db.query('medications', orderBy: 'id ASC');
        return refreshed.map((m) => MedicationModel.fromMap(m)).toList();
      }
      return result.map((m) => MedicationModel.fromMap(m)).toList();
    } catch (e) {
      debugPrint('getMedications error: $e');
      if (_webMedications.isEmpty) {
        await ensureDefaultMedications();
      }
      return List.from(_webMedications);
    }
  }

  Future<int> insertMedication(MedicationModel medication) async {
    final newId = _webMedications.length + 1;
    final modelWithId = medication.copyWith(id: medication.id ?? newId);
    _webMedications.add(modelWithId);
    notifyDataChanged();

    final db = await database;
    if (db == null) return newId;

    try {
      final id = await db.insert('medications', medication.toMap());
      notifyDataChanged();
      return id;
    } catch (e) {
      debugPrint('insertMedication error: $e');
      return newId;
    }
  }

  Future<int> toggleMedicationTaken(int id, String todayIso, bool isTaken) async {
    final lastTaken = isTaken ? todayIso : null;

    final idx = _webMedications.indexWhere((m) => m.id == id);
    if (idx != -1) {
      _webMedications[idx] = _webMedications[idx].copyWith(lastTakenDate: lastTaken);
    }
    notifyDataChanged();

    final db = await database;
    if (db == null) return 1;

    try {
      final res = await db.update(
        'medications',
        {'last_taken_date': lastTaken},
        where: 'id = ?',
        whereArgs: [id],
      );
      notifyDataChanged();
      return res;
    } catch (e) {
      debugPrint('toggleMedicationTaken error: $e');
      return 1;
    }
  }

  Future<int> deleteMedication(int id) async {
    _webMedications.removeWhere((m) => m.id == id);
    notifyDataChanged();

    final db = await database;
    if (db == null) return 1;

    try {
      final res = await db.delete('medications', where: 'id = ?', whereArgs: [id]);
      notifyDataChanged();
      return res;
    } catch (e) {
      debugPrint('deleteMedication error: $e');
      return 1;
    }
  }

  Future<void> ensureDefaultMedications() async {
    final defaults = [
      MedicationModel(
        name: 'Folik Asit',
        dosage: '400 mcg (1 Tablet)',
        time: 'Sabah Tok',
        category: 'Vitamin',
      ),
      MedicationModel(
        name: 'Demir Takviyesi (Ferrum)',
        dosage: '1 Kapsül',
        time: 'Öğle Aç',
        category: 'Mineral',
      ),
      MedicationModel(
        name: 'D3 Vitamini & Omega-3',
        dosage: '1000 IU',
        time: 'Akşam',
        category: 'Vitamin',
      ),
    ];

    final db = await database;
    if (db == null) {
      if (_webMedications.isEmpty) {
        for (int i = 0; i < defaults.length; i++) {
          _webMedications.add(defaults[i].copyWith(id: i + 1));
        }
      }
      return;
    }

    try {
      final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM medications')) ?? 0;
      if (count == 0) {
        for (final m in defaults) {
          await db.insert('medications', m.toMap());
        }
      }
    } catch (e) {
      debugPrint('ensureDefaultMedications error: $e');
    }
  }

  Future<void> clearAllData() async {
    _webProfile = null;
    _webDiaries.clear();
    _webDailyLogs.clear();
    _webNotifications.clear();
    _webMedications.clear();
    final db = await database;
    if (db != null) {
      try {
        await db.delete('daily_logs');
        await db.delete('diaries');
        await db.delete('profile');
        await db.delete('notifications');
        await db.delete('medications');
      } catch (e) {
        debugPrint('clearAllData error: $e');
      }
    }
  }

  Future<void> close() async {
    final db = _database;
    if (db != null && db.isOpen) {
      await db.close();
      _database = null;
    }
  }
}
