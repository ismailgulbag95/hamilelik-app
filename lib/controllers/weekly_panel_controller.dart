import 'package:flutter/material.dart';
import '../../core/constants/weekly_medical_data.dart';
import '../../models/profile_model.dart';
import '../../services/database_helper.dart';
import '../../services/medical_calculator.dart';

/// Hafta Hafta Tıbbi Panel Controller'ı
class WeeklyPanelController extends ChangeNotifier {
  int _selectedWeek = 12;
  int _actualPregnancyWeek = 12;
  ProfileModel? _profile;
  bool _isLoading = false;

  int get selectedWeek => _selectedWeek;
  int get actualPregnancyWeek => _actualPregnancyWeek;
  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;

  int get selectedTrimester => MedicalCalculator.getTrimester(_selectedWeek);

  Map<String, dynamic> get currentWeekData {
    return WeeklyMedicalData.getInfoForWeek(_selectedWeek);
  }

  /// Profil ve güncel haftayı yükle
  Future<void> loadProfileWeek() async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await DatabaseHelper.instance.getProfile();
      if (_profile != null) {
        _actualPregnancyWeek = _profile!.currentWeek;
        _selectedWeek = _profile!.currentWeek;
      }
    } catch (e) {
      debugPrint('WeeklyPanelController load error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Seçili haftayı değiştir
  void selectWeek(int week) {
    if (week >= 1 && week <= 42) {
      _selectedWeek = week;
      notifyListeners();
    }
  }
}
