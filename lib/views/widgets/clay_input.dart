import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/clay_theme.dart';

/// Claymorphic Metin & Sayı Giriş Alanı (İçbükey gölge ve belirgin odak halkası)
class ClayTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? icon;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final Color surfaceColor;

  const ClayTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.surfaceColor = AppColors.clayCardSurface,
  });

  @override
  State<ClayTextField> createState() => _ClayTextFieldState();
}

class _ClayTextFieldState extends State<ClayTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (focus) => setState(() => _isFocused = focus),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: widget.surfaceColor,
              borderRadius: BorderRadius.circular(ClayTheme.defaultRadius),
              border: _isFocused
                  ? Border.all(color: AppColors.primaryPink, width: 2.5)
                  : Border.all(color: Colors.white.withValues(alpha: 0.8), width: 1.5),
              boxShadow: [
                // İç gölge efekti (İçbükey inset simülasyonu)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
                // Üst beyaz parlaklık
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.9),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: _isFocused ? AppColors.primaryPink : AppColors.textSecondary,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    onChanged: widget.onChanged,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
