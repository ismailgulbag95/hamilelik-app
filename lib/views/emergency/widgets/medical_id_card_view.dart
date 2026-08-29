import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';
import '../../../models/emergency_card_model.dart';
import '../../../utils/date_utils.dart';

/// Claymorphic Acil Servis Tıbbi Not Kartı (Emergency ID Card)
class MedicalIdCardView extends StatelessWidget {
  final EmergencyCardModel card;

  const MedicalIdCardView({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return ClayCard(
      color: AppColors.clayCardSurface,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Başlık Şeridi
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.clayRose,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Text('🏥', style: TextStyle(fontSize: 24)),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Acil Tıbbi Bilgi Kartı',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      Text(
                        'Hekim & Acil Sağlık Ekibi İncelemesi İçin',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tıbbi Temel Bilgiler Grid
          _buildInfoRow('Hasta Adı / Soyadı', card.patientName),
          _buildInfoRow('Kan Grubu', card.bloodType, isHighlight: true),
          _buildInfoRow('Mevcut Gebelik Haftası', '${card.currentWeek}. Hafta'),
          _buildInfoRow('Son Adet Tarihi (SAT)', AppDateUtils.formatDisplay(card.lmpDate)),
          _buildInfoRow('Tahmini Doğum Tarihi', AppDateUtils.formatDisplay(card.dueDate)),
          const Divider(height: 20),

          _buildInfoRow('Alerjiler', card.allergies, isAlert: true),
          _buildInfoRow('Kronik Hastalıklar', card.chronicDiseases),
          _buildInfoRow('Düzenli Kullanılan İlaçlar', card.medications),
          const Divider(height: 20),

          _buildInfoRow('Takip Eden Doktor', card.doctorName),
          _buildInfoRow('Doktor Telefonu', card.doctorPhone),
          _buildInfoRow('Kayıtlı Hastane', card.hospitalName),
          _buildInfoRow('Acil İletişim Kişisi (Eş/Yakın)', '${card.emergencyContactName} (${card.emergencyContactPhone})'),
          const Divider(height: 20),

          // Semptom Özeti
          const Text(
            'Son Kayıtlı Semptom ve Vital Bulgular:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.backgroundSubtle,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              card.recentSymptoms,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isHighlight = false, bool isAlert = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: isAlert
                    ? AppColors.medicalAlertRed
                    : (isHighlight ? AppColors.primaryPink : AppColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
