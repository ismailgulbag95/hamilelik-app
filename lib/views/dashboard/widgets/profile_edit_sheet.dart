import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';
import '../../../models/profile_model.dart';
import '../../../services/database_helper.dart';
import '../../widgets/medical_disclaimer_sheet.dart';
import 'package:easy_localization/easy_localization.dart';

/// Aura Pregnancy - Bebek & Anne Bilgilerini Düzenleme Modalı (Liquid Glass & Glazed Ceramic)
class ProfileEditSheet extends StatefulWidget {
  final ProfileModel profile;
  final VoidCallback onSaved;

  const ProfileEditSheet({
    super.key,
    required this.profile,
    required this.onSaved,
  });

  @override
  State<ProfileEditSheet> createState() => _ProfileEditSheetState();
}

class _ProfileEditSheetState extends State<ProfileEditSheet> {
  late TextEditingController _momNameController;
  late TextEditingController _babyNameController;
  late String _selectedGender;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _momNameController = TextEditingController(text: widget.profile.momName ?? '');
    _babyNameController = TextEditingController(text: widget.profile.babyName ?? '');
    _selectedGender = widget.profile.babyGender ?? 'surprise';
  }

  @override
  void dispose() {
    _momNameController.dispose();
    _babyNameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    final updated = widget.profile.copyWith(
      momName: _momNameController.text.trim().isEmpty ? null : _momNameController.text.trim(),
      babyName: _babyNameController.text.trim().isEmpty ? null : _babyNameController.text.trim(),
      babyGender: _selectedGender,
    );

    await DatabaseHelper.instance.saveProfile(updated);
    widget.onSaved();
    if (mounted) {
      setState(() => _isSaving = false);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('profile_edit_saved'.tr()),
          backgroundColor: AppColors.successGreen,
        ),
      );
    }
  }

  Future<void> _confirmResetData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.background,
        title: Text(
          'profile_edit_reset_confirm_title'.tr(),
          style: GoogleFonts.outfit(fontWeight: FontWeight.w900, color: AppColors.primaryDark),
        ),
        content: Text(
          'profile_edit_reset_confirm_desc'.tr(),
          style: GoogleFonts.plusJakartaSans(fontSize: 13, height: 1.45, color: AppColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'profile_edit_reset_cancel_btn'.tr(),
              style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w700),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.medicalAlertRed,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'profile_edit_reset_confirm_btn'.tr(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await DatabaseHelper.instance.clearAllData();
      widget.onSaved();
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('profile_edit_reset_success'.tr()),
            backgroundColor: AppColors.medicalAlertRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: ClayTheme.glazedGlassDecoration(
            surfaceColor: AppColors.background,
            borderRadius: 32,
            opacity: 0.92,
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 18,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Üst Tutamaç Çukuru
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: ClayTheme.concaveDecoration(
                      color: Colors.black.withValues(alpha: 0.12),
                      borderRadius: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Başlık
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: ClayTheme.clayDecoration(
                        color: AppColors.clayRose,
                        borderRadius: 10,
                      ),
                      child: const Center(
                        child: Icon(Icons.child_care_rounded, color: AppColors.primaryPink, size: 18),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'profile_edit_title'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
            const SizedBox(height: 4),
            Text(
              'profile_edit_desc'.tr(),
              style: const TextStyle(fontSize: 12, color: Color(0xFF7A6E78), fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // 1. Anne İsmi
            ClayCard(
              color: AppColors.clayCardSurface,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.face_rounded, size: 15, color: AppColors.primaryPink),
                      const SizedBox(width: 6),
                      Text('profile_edit_mom_label'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _momNameController,
                    decoration: InputDecoration(
                      hintText: 'onboarding_step3_mom_hint'.tr(),
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 2. Bebeğin İsmi
            ClayCard(
              color: AppColors.clayCardSurface,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.child_friendly_rounded, size: 15, color: AppColors.primaryPink),
                      const SizedBox(width: 6),
                      Text('profile_edit_baby_label'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('profile_edit_baby_desc'.tr(), style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _babyNameController,
                    decoration: InputDecoration(
                      hintText: 'onboarding_step3_baby_hint'.tr(),
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 3. Cinsiyet Seçimi
            ClayCard(
              color: AppColors.clayCardSurface,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.stars_rounded, size: 15, color: AppColors.secondaryPeach),
                      const SizedBox(width: 6),
                      Text('profile_edit_gender_label'.tr(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildGenderPill('onboarding_step3_gender_girl'.tr(), 'girl', Icons.female_rounded, AppColors.clayRose, AppColors.primaryPink),
                      const SizedBox(width: 8),
                      _buildGenderPill('onboarding_step3_gender_boy'.tr(), 'boy', Icons.male_rounded, AppColors.claySky, AppColors.waterBlue),
                      const SizedBox(width: 8),
                      _buildGenderPill('onboarding_step3_gender_surprise'.tr(), 'surprise', Icons.help_outline_rounded, AppColors.clayCream, AppColors.accentGold),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 4. Hukuki & Online Gizlilik Sözleşmesi Kartı
            ClayCard(
              color: AppColors.clayLavender,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.security_rounded, size: 15, color: AppColors.lavenderPurple),
                      const SizedBox(width: 6),
                      Text(
                        'profile_edit_legal_title'.tr(),
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClayButton(
                    color: AppColors.claySky,
                    height: 46,
                    borderRadius: 14,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    onPressed: () async {
                      final uri = Uri.parse(
                        'https://docs.google.com/document/d/e/2PACX-1vS6uFWNKKhE-D5MateR98z1d6ytQNssL6iSWYryOd-Uy2UcAewmrHo6YvSHG0YRmz3CNmWtCxdkn-l_/pub',
                      );
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.open_in_new_rounded, size: 16, color: AppColors.waterBlue),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'profile_edit_online_privacy_btn'.tr(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClayButton(
                    color: AppColors.clayRose,
                    height: 46,
                    borderRadius: 14,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    onPressed: () => MedicalDisclaimerSheet.show(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.health_and_safety_outlined, size: 17, color: AppColors.primaryPink),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'profile_edit_medical_disclaimer_btn'.tr(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClayButton(
                    color: const Color(0xFFFFEBEE),
                    height: 46,
                    borderRadius: 14,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    onPressed: _confirmResetData,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.delete_forever_rounded, size: 17, color: AppColors.medicalAlertRed),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'profile_edit_reset_title'.tr(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.medicalAlertRed,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Kaydet Butonu
            ClayButton(
              color: AppColors.clayMint,
              onPressed: _isSaving ? null : _saveProfile,
              child: _isSaving
                  ? const CircularProgressIndicator(color: AppColors.successGreen)
                  : Text(
                      'profile_edit_save'.tr(),
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.successGreen),
                    ),
            ),
          ],
        ),
      ),
    ),
  ),
);
}

  Widget _buildGenderPill(String label, String value, IconData icon, Color bgColor, Color activeColor) {
    final isSelected = _selectedGender == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: ClayTheme.clayDecoration(
            color: isSelected ? activeColor : bgColor,
            borderRadius: 14,
            isPressed: isSelected,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
