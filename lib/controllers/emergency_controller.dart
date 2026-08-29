import 'package:flutter/material.dart';
import '../../models/emergency_card_model.dart';
import '../../models/profile_model.dart';
import '../../services/database_helper.dart';
import '../../utils/date_utils.dart';

/// Acil Durum & Kırmızı Alarm Controller'ı
class EmergencyController extends ChangeNotifier {
  ProfileModel? _profile;
  EmergencyCardModel? _card;
  bool _isLoading = false;

  ProfileModel? get profile => _profile;
  EmergencyCardModel? get card => _card;
  bool get isLoading => _isLoading;

  /// Profil ve acil durum kartını veritabanından yükle
  Future<void> loadEmergencyData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await DatabaseHelper.instance.getProfile();
      final lmp = _profile?.lmpDate ?? AppDateUtils.todayIso();
      final due = _profile?.dueDate ?? AppDateUtils.todayIso();
      final week = _profile?.currentWeek ?? 12;

      _card = EmergencyCardModel(
        patientName: 'Aura Anne Adayı',
        bloodType: 'A Rh (+)',
        lmpDate: lmp,
        dueDate: due,
        currentWeek: week,
        allergies: 'İlaç alerjisi bildirilmedi',
        chronicDiseases: 'Yok',
        medications: 'Folik Asit, Magnezyum, Demir Takviyesi',
        emergencyContactName: 'Acil Yakını (Eş)',
        emergencyContactPhone: '+90 555 000 11 22',
        doctorName: 'Uzm. Dr. Zeynep Kaya (Kadın Hastalıkları ve Doğum)',
        doctorPhone: '+90 532 111 22 33',
        hospitalName: 'Merkez Doğum & Perinatoloji Kliniği',
        recentSymptoms: 'Son kontrolde tansiyon 115/75 mmHg, ödem yok.',
      );
    } catch (e) {
      debugPrint('EmergencyController error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
