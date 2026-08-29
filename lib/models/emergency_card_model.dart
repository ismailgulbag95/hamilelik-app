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
}
