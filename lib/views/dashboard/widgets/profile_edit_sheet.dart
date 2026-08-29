import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';
import '../../../models/profile_model.dart';
import '../../../services/database_helper.dart';

/// Aura Pregnancy - Bebek & Anne Bilgilerini Düzenleme Modalı
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
          content: Text('✨ Bilgiler güncellendi! Hoş geldin ${updated.babyDisplayName} 🌸'),
          backgroundColor: AppColors.successGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFDF7F4),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
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
            // Üst Tutamaç
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Başlık
            Row(
              children: [
                const Text('👶', style: TextStyle(fontSize: 22)),
                const SizedBox(width: 8),
                Text(
                  'Bebek & Profil Ayarları',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF2D232E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Bebeğinizin ismini ve cinsiyetini dilediğiniz an güncelleyebilirsiniz.',
              style: TextStyle(fontSize: 12, color: Color(0xFF7A6E78), fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // 1. Anne İsmi
            ClayCard(
              color: AppColors.clayCardSurface,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🌸 Anne Adayının İsmi:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _momNameController,
                    decoration: InputDecoration(
                      hintText: 'Örn: Elif, Zeynep',
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
                  const Text('👶 Bebeğin İsmi:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                  const SizedBox(height: 4),
                  const Text('İsim girdiğinizde uygulama "Ayşe Bebek bugün 150 gr" şeklinde hitap edecektir.', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _babyNameController,
                    decoration: InputDecoration(
                      hintText: 'Örn: Ayşe, Mehmet, Mavi',
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
                  const Text('🎀 Bebeğin Cinsiyeti:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildGenderPill('Kız 👧', 'girl', AppColors.clayRose, AppColors.primaryPink),
                      const SizedBox(width: 8),
                      _buildGenderPill('Erkek 👦', 'boy', AppColors.claySky, AppColors.waterBlue),
                      const SizedBox(width: 8),
                      _buildGenderPill('Sürpriz 💛', 'surprise', AppColors.clayCream, AppColors.accentGold),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Kaydet Butonu
            ClayButton(
              color: AppColors.clayMint,
              onPressed: _isSaving ? null : _saveProfile,
              child: _isSaving
                  ? const CircularProgressIndicator(color: AppColors.successGreen)
                  : const Text(
                      '✨ Değişiklikleri Kaydet',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.successGreen),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderPill(String label, String value, Color bgColor, Color activeColor) {
    final isSelected = _selectedGender == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : bgColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: isSelected ? activeColor.withOpacity(0.3) : Colors.black.withOpacity(0.04),
                blurRadius: isSelected ? 6 : 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
