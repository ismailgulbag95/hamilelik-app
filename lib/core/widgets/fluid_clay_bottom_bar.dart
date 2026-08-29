import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Alt gezinti çubuğu sekme öğesi tanımı
class FluidNavItem {
  final IconData icon;
  final String label;
  final bool isEmergency;

  const FluidNavItem({
    required this.icon,
    required this.label,
    this.isEmergency = false,
  });
}

/// Akışkan Sıvı (Liquid Melting) ve Claymorphism Tabanlı Alt Navigasyon Çubuğu
/// Aktif sekme kayarken bar onun etrafında erir ve teğet Bézier eğrileriyle pürüzsüzce birleşir.
class FluidClayBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final List<FluidNavItem> items;

  const FluidClayBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.items,
  }) : assert(items.length >= 2, 'En az 2 sekme öğesi gereklidir.');

  @override
  State<FluidClayBottomNavBar> createState() => _FluidClayBottomNavBarState();
}

class _FluidClayBottomNavBarState extends State<FluidClayBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _positionAnimation;
  double _currentNormalizedIndex = 0.0;
  double _previousNormalizedIndex = 0.0;

  @override
  void initState() {
    super.initState();
    _currentNormalizedIndex = widget.selectedIndex.toDouble();
    _previousNormalizedIndex = _currentNormalizedIndex;

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );

    _positionAnimation = Tween<double>(
      begin: _currentNormalizedIndex,
      end: _currentNormalizedIndex,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant FluidClayBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _previousNormalizedIndex = _positionAnimation.value;
      _currentNormalizedIndex = widget.selectedIndex.toDouble();

      _positionAnimation = Tween<double>(
        begin: _previousNormalizedIndex,
        end: _currentNormalizedIndex,
      ).animate(
        CurvedAnimation(
          parent: _animController,
          curve: Curves.easeOutCubic,
        ),
      );

      _animController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEmergencyActive = widget.items[widget.selectedIndex].isEmergency;
    final activeBubbleColor = isEmergencyActive
        ? AppColors.medicalAlertRed
        : AppColors.primaryPink; // Belirgin, yüksek kontrastlı ve sıcak Clay Pembe

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      height: 72,
      child: AnimatedBuilder(
        animation: _animController,
        builder: (context, child) {
          final animValue = _positionAnimation.value;
          // Hareket hızına bağlı sıvı esneme (stretch/squash) katsayısı
          final delta = (animValue - _previousNormalizedIndex).abs();
          final stretchFactor = (math.sin(delta * math.pi) * 0.18).clamp(0.0, 0.25);

          return LayoutBuilder(
            builder: (context, constraints) {
              final totalWidth = constraints.maxWidth;
              final itemCount = widget.items.length;
              final itemWidth = totalWidth / itemCount;
              final activeCenterX = (animValue + 0.5) * itemWidth;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // 1. Sıvı Çizim Katmanı (Claymorphic Fluid Melt Canvas)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _FluidMeltBarPainter(
                        activeCenterX: activeCenterX,
                        barHeight: 64,
                        barWidth: totalWidth,
                        cornerRadius: 28,
                        barColor: AppColors.clayCardSurface,
                        bubbleColor: activeBubbleColor,
                        stretchFactor: stretchFactor,
                        shadowTint: const Color(0xFF9E7B83),
                      ),
                    ),
                  ),

                  // 2. Sekme Butonları ve İkon Katmanı
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 64,
                    child: Row(
                      children: List.generate(widget.items.length, (index) {
                        final item = widget.items[index];
                        final isSelected = widget.selectedIndex == index;

                        // Geçerli animasyon mesafesine göre yükselme oranı
                        final dist = (animValue - index).abs();
                        final activeFactor = (1.0 - dist).clamp(0.0, 1.0);

                        return Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => widget.onTabSelected(index),
                            child: _NavItemWidget(
                              item: item,
                              isSelected: isSelected,
                              activeFactor: activeFactor,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/// Sekme İkon ve Başlık Widget'ı
class _NavItemWidget extends StatelessWidget {
  final FluidNavItem item;
  final bool isSelected;
  final double activeFactor;

  const _NavItemWidget({
    required this.item,
    required this.isSelected,
    required this.activeFactor,
  });

  @override
  Widget build(BuildContext context) {
    // Seçili sekme hafif yukarı süzülür (floating lift)
    final translateY = -4.0 * activeFactor;
    final scale = 1.0 + (0.12 * activeFactor);

    // Aktif baloncuk üzerinde bembeyaz yüksek kontrastlı ikon, pasifken koyu kömür
    final iconColor = item.isEmergency
        ? (activeFactor > 0.5 ? Colors.white : AppColors.medicalAlertRed)
        : Color.lerp(const Color(0xFF5C4F53), Colors.white, activeFactor);

    // Başlık metni rengi
    final textColor = item.isEmergency
        ? AppColors.medicalAlertRed
        : Color.lerp(const Color(0xFF7A6E78), AppColors.primaryPink, activeFactor);

    return Transform.translate(
      offset: Offset(0, translateY),
      child: Transform.scale(
        scale: scale,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 22,
              color: iconColor,
            ),
            const SizedBox(height: 3),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                color: textColor,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Akışkan Sıvı (Melting Fluid) & Çift İç Gölgeli Claymorphic CustomPainter
class _FluidMeltBarPainter extends CustomPainter {
  final double activeCenterX;
  final double barHeight;
  final double barWidth;
  final double cornerRadius;
  final Color barColor;
  final Color bubbleColor;
  final double stretchFactor;
  final Color shadowTint;

  _FluidMeltBarPainter({
    required this.activeCenterX,
    required this.barHeight,
    required this.barWidth,
    required this.cornerRadius,
    required this.barColor,
    required this.bubbleColor,
    required this.stretchFactor,
    required this.shadowTint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, barWidth, barHeight),
      Radius.circular(cornerRadius),
    );

    // --- 1. YUMUŞAK DIŞ CLAY GÖLGESİ (Outer Drop Shadow) ---
    final shadowPaint1 = Paint()
      ..color = shadowTint.withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 28);
    canvas.drawRRect(rrect.shift(const Offset(0, 14)), shadowPaint1);

    final shadowPaint2 = Paint()
      ..color = shadowTint.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawRRect(rrect.shift(const Offset(0, 4)), shadowPaint2);

    // --- 2. ANA CLAY BAR GÖVDESİ ---
    final barPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.40),
          barColor,
          barColor,
          Colors.black.withOpacity(0.04),
        ],
        stops: const [0.0, 0.20, 0.85, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, barWidth, barHeight));

    canvas.drawRRect(rrect, barPaint);

    // --- 3. AKIŞKAN SIVI ERİME VE AKTİF BALONCUK (Melting Socket) ---
    canvas.save();
    canvas.clipRRect(rrect);

    // Baloncuk boyutları ve esneme teğeti
    final bubbleRadiusX = 28.0 * (1.0 + stretchFactor);
    final bubbleRadiusY = 24.0;
    final bubbleCenterY = barHeight / 2;

    final bubbleRect = Rect.fromCenter(
      center: Offset(activeCenterX, bubbleCenterY),
      width: bubbleRadiusX * 2,
      height: bubbleRadiusY * 2,
    );
    final bubbleRRect = RRect.fromRectAndRadius(
      bubbleRect,
      Radius.circular(bubbleRadiusY),
    );

    // Sıvı Yastık (Liquid Socket) Yumuşak Teğet Erime Katmanı
    final fluidPath = Path();
    final socketSpan = bubbleRadiusX * 1.4;
    final leftSocket = activeCenterX - socketSpan;
    final rightSocket = activeCenterX + socketSpan;

    // Teğetsel Bézier eğrisi ile sıvı akışı
    fluidPath.moveTo(leftSocket, barHeight);
    fluidPath.cubicTo(
      leftSocket + socketSpan * 0.4, barHeight,
      activeCenterX - bubbleRadiusX * 0.8, bubbleCenterY - 4,
      activeCenterX, bubbleCenterY - 4,
    );
    fluidPath.cubicTo(
      activeCenterX + bubbleRadiusX * 0.8, bubbleCenterY - 4,
      rightSocket - socketSpan * 0.4, barHeight,
      rightSocket, barHeight,
    );
    fluidPath.close();

    // Eriyik sıvı gölgesi
    final fluidGlowPaint = Paint()
      ..color = bubbleColor.withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawPath(fluidPath, fluidGlowPaint);

    // Aktif Claymorphic Puf Baloncuk Gövdesi (Vurgulu ve belirgin 3D gölgeli)
    final bubblePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.45),
          bubbleColor,
          bubbleColor,
          const Color(0xFF6B1B36).withOpacity(0.25),
        ],
        stops: const [0.0, 0.22, 0.78, 1.0],
      ).createShader(bubbleRect);

    // Baloncuğun belirgin 3D taban gölgesi
    final bubbleShadowPaint = Paint()
      ..color = const Color(0xFF5C2636).withOpacity(0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawRRect(bubbleRRect.shift(const Offset(0, 4)), bubbleShadowPaint);

    canvas.drawRRect(bubbleRRect, bubblePaint);

    // Baloncuk üst beyaz ışık vurgusu (Claymorphism Top Specular Highlight)
    final highlightPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -0.6),
        radius: 0.8,
        colors: [
          Colors.white.withOpacity(0.65),
          Colors.white.withOpacity(0.0),
        ],
      ).createShader(bubbleRect);

    canvas.drawRRect(bubbleRRect, highlightPaint);

    canvas.restore();

    // --- 4. CLAYMORPHISM İÇ KENAR IŞIĞI (Subtle Inner Border) ---
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.60),
          Colors.white.withOpacity(0.10),
        ],
      ).createShader(Rect.fromLTWH(0, 0, barWidth, barHeight));

    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _FluidMeltBarPainter oldDelegate) {
    return oldDelegate.activeCenterX != activeCenterX ||
        oldDelegate.stretchFactor != stretchFactor ||
        oldDelegate.bubbleColor != bubbleColor;
  }
}
