import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'inset_box_shadow.dart';
import '../constants/app_colors.dart';

/// Claymorphism UI Tarzı Yapılandırması ve Widget Bileşenleri
/// Formül: 2 İç Gölge (Üst Beyaz Işık + Alt Koyu Vurgu) + 1 Yumuşak Dış Gölge
/// Oversized Radius (26px - 32px), Bağımsız Pastel Renkler, Tıknaz Dost Canlısı Tipografi
class ClayTheme {
  static const double defaultRadius = 26.0;
  static const double cardRadius = 32.0;
  static const double buttonRadius = 24.0;

  /// Standart Claymorphism Kart Kutu Dekorasyonu (Çift İç Işık + Yumuşak Sıcak Dış Gölge)
  static BoxDecoration clayDecoration({
    required Color color,
    double borderRadius = defaultRadius,
    bool isPressed = false,
  }) {
    if (isPressed) {
      // Kural E (Pressed State): Dış gölge küçülür, iç gölgeler derinleşir
      return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // 1. Dış Gölge
          BoxShadow(
            color: const Color(0x22C49A9E),
            offset: const Offset(0, 4),
            blurRadius: 10,
            inset: false,
          ),
          // 2. Üst İç Işık
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.90),
            offset: const Offset(0, 8),
            blurRadius: 14,
            inset: true,
          ),
          // 3. Alt İç Gölge
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            offset: const Offset(0, -8),
            blurRadius: 14,
            inset: true,
          ),
        ],
      );
    }

    // Normal Havada Duran (Floating) Durum
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        // 1. Yumuşak Sıcak Dış Gölge (Nesneyi havaya kaldırır)
        BoxShadow(
          color: const Color(0x24C49A9E),
          offset: const Offset(0, 14),
          blurRadius: 28,
          inset: false,
        ),
        // 2. Üst İç Işık (Kil parlaklığı - açık beyaz ışık)
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.75),
          offset: const Offset(0, 6),
          blurRadius: 14,
          inset: true,
        ),
        // 3. Alt İç Gölge (Kil alt kıvrımı)
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.10),
          offset: const Offset(0, -6),
          blurRadius: 14,
          inset: true,
        ),
      ],
    );
  }

  /// Butonlar ve Küçük Etkileşim Öğeleri İçin Optimize Edilmiş Keskin Claymorphism Dekorasyonu
  static BoxDecoration clayButtonDecoration({
    required Color color,
    double borderRadius = buttonRadius,
    bool isPressed = false,
  }) {
    if (isPressed) {
      return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0x22C49A9E),
            offset: const Offset(0, 2),
            blurRadius: 6,
            inset: false,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.92),
            offset: const Offset(0, 5),
            blurRadius: 8,
            inset: true,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            offset: const Offset(0, -5),
            blurRadius: 8,
            inset: true,
          ),
        ],
      );
    }

    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: const Color(0x28C49A9E),
          offset: const Offset(0, 8),
          blurRadius: 16,
          inset: false,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.85),
          offset: const Offset(0, 4),
          blurRadius: 8,
          inset: true,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          offset: const Offset(0, -4),
          blurRadius: 8,
          inset: true,
        ),
      ],
    );
  }

  /// İçbükey / Oyuk (Concave / Inset) Claymorphism Dekorasyonu
  /// Metin girişleri, çukur rozetler ve iç kutular için kullanılır
  static BoxDecoration concaveDecoration({
    required Color color,
    double borderRadius = defaultRadius,
    Border? border,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      border: border,
      boxShadow: [
        // 1. Üst & Sol İç Çukur Gölgesi (Derinlik hissi)
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          offset: const Offset(0, 4),
          blurRadius: 8,
          inset: true,
        ),
        // 2. Alt & Sağ İç Işık (Çukur kenar yansıması)
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.85),
          offset: const Offset(0, -3),
          blurRadius: 6,
          inset: true,
        ),
      ],
    );
  }

  /// ThemeData Yapılandırması
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primaryPink,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryPink,
        background: AppColors.background,
        surface: AppColors.clayCardSurface,
      ),
      fontFamily: 'Quicksand',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

/// Claymorphic Kart Widget'ı (Çift iç ışık/gölge ve dış yumuşak derinlik)
class ClayCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const ClayCard({
    super.key,
    required this.child,
    this.color = AppColors.clayCardSurface,
    this.borderRadius = ClayTheme.cardRadius,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: ClayTheme.clayDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Claymorphic Buton Widget'ı (Basılma efekti ve dolgun pastel dokunuş)
class ClayButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;

  const ClayButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color = AppColors.clayRose,
    this.borderRadius = ClayTheme.buttonRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.height,
    this.width,
  });

  @override
  State<ClayButton> createState() => _ClayButtonState();
}

class _ClayButtonState extends State<ClayButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: ClayTheme.clayButtonDecoration(
          color: widget.color,
          borderRadius: widget.borderRadius,
          isPressed: _isPressed,
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}
