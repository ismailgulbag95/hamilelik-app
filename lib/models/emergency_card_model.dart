/// Aura Pregnancy - Acil Durum Tıbbi Bilgi Modeli
class EmergencyCardModel {
  final String patientName;
  final String bloodType;
  final String lmpDate;
  final String dueDate;
  final int currentWeek;
  final String allergies;
  final String chronicDiseases;
  final String medications;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String doctorName;
  final String doctorPhone;
  final String hospitalName;
  final String recentSymptoms;

  EmergencyCardModel({
    this.patientName = 'Anne Adayı',
    this.bloodType = 'A Rh (+)',
    required this.lmpDate,
    required this.dueDate,
    required this.currentWeek,
    this.allergies = 'Penisilin, Fıstık',
    this.chronicDiseases = 'Yok',
    this.medications = 'Folik Asit (400 mcg), Demir (Ferrum)',
    this.emergencyContactName = 'Eş / Yakın',
    this.emergencyContactPhone = '+90 555 123 45 67',
    this.doctorName = 'Op. Dr. Kadın Doğum Uzmanı',
    this.doctorPhone = '+90 532 987 65 43',
    this.hospitalName = 'Şehir Kadın Doğum & Çocuk Hastanesi',
    this.recentSymptoms = 'Hafif bulantı, tansiyon 110/70',
  });

  Map<String, dynamic> toMap() {
    return {
      'patient_name': patientName,
      'blood_type': bloodType,
      'lmp_date': lmpDate,
      'due_date': dueDate,
      'current_week': currentWeek,
      'allergies': allergies,
      'chronic_diseases': chronicDiseases,
      'medications': medications,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_phone': emergencyContactPhone,
      'doctor_name': doctorName,
      'doctor_phone': doctorPhone,
      'hospital_name': hospitalName,
      'recent_symptoms': recentSymptoms,
    };
  }

  factory EmergencyCardModel.fromMap(Map<String, dynamic> map) {
    return EmergencyCardModel(
      patientName: map['patient_name'] as String? ?? 'Anne Adayı',
      bloodType: map['blood_type'] as String? ?? 'A Rh (+)',
      lmpDate: map['lmp_date'] as String? ?? '',
      dueDate: map['due_date'] as String? ?? '',
      currentWeek: (map['current_week'] as num?)?.toInt() ?? 12,
      allergies: map['allergies'] as String? ?? '',
      chronicDiseases: map['chronic_diseases'] as String? ?? '',
      medications: map['medications'] as String? ?? '',
      emergencyContactName: map['emergency_contact_name'] as String? ?? '',
      emergencyContactPhone: map['emergency_contact_phone'] as String? ?? '',
      doctorName: map['doctor_name'] as String? ?? '',
      doctorPhone: map['doctor_phone'] as String? ?? '',
      hospitalName: map['hospital_name'] as String? ?? '',
      recentSymptoms: map['recent_symptoms'] as String? ?? '',
    );
  }

  EmergencyCardModel copyWith({
    String? patientName,
    String? bloodType,
    String? lmpDate,
    String? dueDate,
    int? currentWeek,
    String? allergies,
    String? chronicDiseases,
    String? medications,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? doctorName,
    String? doctorPhone,
    String? hospitalName,
    String? recentSymptoms,
  }) {
    return EmergencyCardModel(
      patientName: patientName ?? this.patientName,
      bloodType: bloodType ?? this.bloodType,
      lmpDate: lmpDate ?? this.lmpDate,
      dueDate: dueDate ?? this.dueDate,
      currentWeek: currentWeek ?? this.currentWeek,
      allergies: allergies ?? this.allergies,
      chronicDiseases: chronicDiseases ?? this.chronicDiseases,
      medications: medications ?? this.medications,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone ?? this.emergencyContactPhone,
      doctorName: doctorName ?? this.doctorName,
      doctorPhone: doctorPhone ?? this.doctorPhone,
      hospitalName: hospitalName ?? this.hospitalName,
      recentSymptoms: recentSymptoms ?? this.recentSymptoms,
    );
  }
}
