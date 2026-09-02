# Spec: Claymorphism 3.0 & High-End UI Overhaul (Aura Pregnancy)

## 1. Objective
Transform Aura Pregnancy's visual aesthetics from basic/flat clay into a state-of-the-art **Claymorphism 3.0** design system. This eliminates the "slop / amateur" feel by resolving the typography fallback bug, adding organic ambient gradient backgrounds with subtle depth, introducing volume-gradient tactile buttons with glossy specular highlights and spring physics, and harmonizing color contrast across all screens.

## 2. Tech Stack & Dependencies
- **Framework:** Flutter (Material 3 enabled)
- **Typography:** `google_fonts: ^6.1.0` (Outfit for bold headlines & numbers, Plus Jakarta Sans for body and medical guidance)
- **Claymorphism Shadow Engine:** `flutter_inset_box_shadow` (or built-in dual inset shadows)
- **Haptics:** `services.dart` (`HapticFeedback.lightImpact()`)

## 3. Core Design Specifications

### A. Typography Hierarchy
- **Display & Headlines (Weeks, Numbers, Main Titles):** `GoogleFonts.outfit` (FontWeight 800/900, tight letter spacing -0.5px).
- **Section Headers & Subtitles:** `GoogleFonts.outfit` (FontWeight 700/800, 16-20px).
- **Body & Medical Advice:** `GoogleFonts.plusJakartaSans` (FontWeight 500/600, 13-15px, 1.4 line height).
- **Buttons & Chips:** `GoogleFonts.outfit` (FontWeight 700/800, 13-15px, letter spacing 0.2px).
- **Text Primary Color:** Deep Charcoal Plum `Color(0xFF231B24)`.
- **Text Secondary Color:** Soft Plum Slate `Color(0xFF635666)`.

### B. Ambient Background Architecture
- **Flat background replacement:** Soft porcelain warm gradient (`begin: Alignment.topCenter, end: Alignment.bottomCenter`, colors: `[Color(0xFFFFFDFC), Color(0xFFFDF2ED)]`).
- **Ambient Aura Glows:** Subtle, non-intrusive soft blurred clay glow orbs placed at corners to create depth without distraction.

### C. Claymorphism 3.0 Button & Card Formula
- **Volume Gradient:** Surface colors are not flat hexes; they use a subtle linear gradient (+5% lightness at top, -4% lightness at bottom).
- **Specular Rim Highlight:** `Border.all(color: Colors.white.withOpacity(0.65), width: 1.2)` on rest, deeper in pressed state.
- **Dual Inset Shadows:**
  - Top-left inner light: `BoxShadow(color: Colors.white.withOpacity(0.85), offset: Offset(0, 3), blurRadius: 6, inset: true)`
  - Bottom-right inner occlusion: `BoxShadow(color: Colors.black.withOpacity(0.10), offset: Offset(0, -4), blurRadius: 6, inset: true)`
- **Warm Ambient Drop Shadow:** Tinted outer drop shadow (`color: color.withOpacity(0.28), offset: Offset(0, 10), blurRadius: 20`).
- **Interactive Feedback:** `AnimatedScale(scale: 0.96, duration: Duration(milliseconds: 100))` + `HapticFeedback.lightImpact()` on tap down.

## 4. Boundaries
- **Always:** Use `GoogleFonts` through `ClayTheme.themeData`, maintain min 48px touch targets, ensure 4.5:1 text contrast.
- **Never:** Use dark backgrounds, introduce heavy jarring animations, or break existing tests.

## 5. Success Criteria
- [x] Full `GoogleFonts` textTheme integration without missing font fallback.
- [x] Ambient multi-tone background gradient applied consistently.
- [x] All buttons have tactile volume gradients, specular rims, and spring physics.
- [x] All 52+ unit/widget tests continue to pass without error.
