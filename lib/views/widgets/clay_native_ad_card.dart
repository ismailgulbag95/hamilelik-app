import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/clay_theme.dart';

/// Aura Pregnancy - Claymorphic Yerel Gelişmiş Reklam Kartı (Native Ad Card)
/// Sıfır Dark-Pattern: Şeffaf sponsor rozeti, göz yormayan pastel kil yüzey ve zarif eylem butonu
class ClayNativeAdCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? buttonText;
  final IconData icon;
  final Color? cardColor;
  final VoidCallback? onTap;

  const ClayNativeAdCard({
    super.key,
    this.title,
    this.description,
    this.buttonText,
    this.icon = Icons.spa_rounded,
    this.cardColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTitle = title ?? 'ad_native_title_1'.tr();
    final effectiveDesc = description ?? 'ad_native_desc_1'.tr();
    final effectiveBtn = buttonText ?? 'ad_native_btn_1'.tr();
    final surfaceColor = cardColor ?? AppColors.clayCardSurface;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: ClayTheme.clayDecoration(
        color: surfaceColor,
        borderRadius: 26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst Satır: Şeffaf Sponsor Rozeti & Bilgi İkonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: ClayTheme.clayButtonDecoration(
                  color: AppColors.clayMint,
                  borderRadius: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.stars_rounded, color: Color(0xFF2E6135), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'ad_native_sponsor_badge'.tr(),
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2E6135),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              Tooltip(
                message: 'ad_sponsored_info'.tr(),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.04),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // İçerik Satırı: İkon Havuzu + Başlık ve Açıklama
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: ClayTheme.concaveDecoration(
                  color: Colors.white,
                  borderRadius: 16,
                ),
                child: Center(
                  child: Icon(icon, color: AppColors.secondaryPeach, size: 24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      effectiveTitle,
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryDark,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      effectiveDesc,
                      style: GoogleFonts.quicksand(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Alt Satır: ClayButton Eylemi
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 38,
              child: ClayButton(
                color: AppColors.clayPeach,
                borderRadius: 14,
                onPressed: onTap ??
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('ad_thank_support'.tr()),
                          backgroundColor: AppColors.clayCardSurface,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      );
                    },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        effectiveBtn,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.primaryDark),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
