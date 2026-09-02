import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import 'welcome_congratulation_screen.dart';
import 'app_guide_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  Future<void> _selectLanguage(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
    if (!context.mounted) return;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const WelcomeCongratulationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.language_rounded,
                size: 80,
                color: AppColors.primaryPink,
              ),
              const SizedBox(height: 32),
              Text(
                'Choose Your Language\nDil Seçiminizi Yapın',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2D232E),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 48),
              ClayLanguageButton(
                title: 'English',
                subtitle: 'US / UK',
                icon: Icons.g_translate_rounded,
                onTap: () => _selectLanguage(context, const Locale('en')),
                color: const Color(0xFFFEE6E0),
              ),
              const SizedBox(height: 24),
              ClayLanguageButton(
                title: 'Türkçe',
                subtitle: 'Türkiye',
                icon: Icons.translate_rounded,
                onTap: () => _selectLanguage(context, const Locale('tr')),
                color: const Color(0xFFD4EBD6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClayLanguageButton extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const ClayLanguageButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  State<ClayLanguageButton> createState() => _ClayLanguageButtonState();
}

class _ClayLanguageButtonState extends State<ClayLanguageButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              offset: _isPressed ? const Offset(0, 8) : const Offset(0, 24),
              blurRadius: _isPressed ? 16 : 40,
              inset: false,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.65),
              offset: _isPressed ? const Offset(0, 12) : const Offset(0, 8),
              blurRadius: _isPressed ? 20 : 16,
              inset: true,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              offset: _isPressed ? const Offset(0, -12) : const Offset(0, -8),
              blurRadius: _isPressed ? 20 : 16,
              inset: true,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, color: AppColors.primaryDark, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF2D232E),
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D232E).withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.primaryDark,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
