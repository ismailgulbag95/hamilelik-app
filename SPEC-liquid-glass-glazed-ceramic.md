# Spec: Liquid Glass & Glazed Ceramic (Sıvı Cam & Sırlı Seramik Hibriti)

## 1. Objective
Aura Pregnancy için mat ve opak kil dokusu ile modern şeffaf sıvı cam (Liquid Glass) dokusunu birleştiren **"Liquid Glass & Glazed Ceramic"** (Sıvı Cam & Sırlı Seramik) hibrit tasarım mimarisini kurmak. Bu mimari, arka plandaki panelleri ve modalleri ferah ve uzamsal derinliğe (spatial depth) sahip buzlu cam dokusuna kavuştururken, butonları ve veri sayaçlarını dokunulası dolgun kilde tutarak görsel zenginliği maksimize eder.

## 2. Tech Stack & Dependencies
- **Framework:** Flutter (Material 3 enabled)
- **Render Engine:** `dart:ui` (`ImageFilter.blur`), `flutter_inset_box_shadow` (Dual Inset Shadows), `google_fonts` (Outfit + Plus Jakarta Sans)

## 3. Mimari Katmanlar ve Sorumluluklar

| Katman | Görsel Dokusu | Uygulama Bileşeni |
| :--- | :--- | :--- |
| **Arka Plan Atmosferi** | Sıcak Porselen Degrade + Difüze Işık Küreleri | `AmbientBackground` |
| **Büyük Bilgi Kartları & Modallar** | Liquid Glass (Buzlu Cam, %82-88 Opaklık, Blur 16px, Beyaz Sır Sınırı) | `LiquidGlassCard`, `ClayCard(isGlazed: true)` |
| **Aksiyon Butonları & Sayaçlar** | Glazed Ceramic Clay (Hacimli parlak seramik kil, yaylanma animasyonu) | `ClayButton` |
| **Gezinti Çubuğu** | Sıvı Kil (Fluid Melting Clay) | `FluidClayBottomNavBar` |

## 4. Teknik Formüller (Design Tokens & Recipes)

### A. Glazed Glass Decoration Formülü
```dart
BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withValues(alpha: 0.88),
      color.withValues(alpha: 0.76),
    ],
  ),
  borderRadius: BorderRadius.circular(borderRadius),
  border: Border.all(
    color: Colors.white.withValues(alpha: 0.80),
    width: 1.2,
  ),
  boxShadow: [
    BoxShadow(
      color: const Color(0x18C49A9E),
      offset: const Offset(0, 10),
      blurRadius: 24,
      inset: false,
    ),
    BoxShadow(
      color: Colors.white.withValues(alpha: 0.90),
      offset: const Offset(0, 2),
      blurRadius: 4,
      inset: true,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      offset: const Offset(0, -2),
      blurRadius: 4,
      inset: true,
    ),
  ],
)
```

### B. Backdrop Filter & Blur
Cam efektinin altındaki ortam ışıklarının görünmesi için `BackdropFilter(filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16))` kullanılır.

## 5. Başarı Kriterleri (Success Criteria)
- [x] `ClayTheme` içerisine `glazedGlassDecoration` fonksiyonu ve `ClayCard` için `isGlazed` desteği eklenmesi.
- [x] Modal pencerelerin (`ProfileEditSheet`, `MedicalDisclaimerSheet`, dialoglar) buzlu cam + sırlı seramik stilini benimsemesi.
- [x] Tüm testlerin (`flutter test`) 52/52 hatasız geçmesi.
