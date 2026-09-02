# SPEC-micro-animations-delight: Aura Pregnancy Mikro-Animasyon ve Dokunsal Etkileşim Mimarisi

## 1. Objective (Hedef ve Vizyon)
Aura Pregnancy uygulamasının **Claymorphism 3.0 & Glazed Ceramic** tasarım dilini; donuk/statik bir arayüzden çıkarıp, yaşayan, nefes alan, anne ve bebeğin biyolojik ritmini yansıtan ve her dokunuşta yüksek dokunsal haz (tactile delight) veren **Apple Design Award** kalitesinde bir mikro-etkileşim seviyesine taşımak.

## 2. Tech Stack & Prensipler
- **Framework:** Flutter 3.x / Dart 3.x
- **Kütüphaneler:** Flutter yerleşik `AnimationController`, `TweenAnimationBuilder`, `HapticFeedback`, `CustomPainter`. (Harici ağır paketler yerine sıfır bağımlılık / zero-dependency yerleşik Flutter motoru kullanılır).
- **Performans Bütçesi:** 60/120 FPS; GPU üzerinde sadece `Transform` (scale, translate) ve `Opacity` katmanları animasyona tabi tutulur. Gereksiz `relayout` veya layout thrashing yasaktır.
- **Erişilebilirlik (A11y):** `MediaQuery.of(context).disableAnimations` aktif olduğunda animasyonlar sıfırlanır veya statik duruma geçer.

## 3. Capability Map & Modüller

| Modül ID | Sorumluluk Alanı | Bileşen / Dosya |
|---|---|---|
| `pulse_heartbeat` | Fetus kartı arkasında yumuşak ritmik nabız aurası ve çift tık kalp haptiği | `PulseAura`, `HeartbeatFeedback` |
| `odometer_numbers` | Sayıların (gün, ml, adım, hafta) dönerek ve akıcı sayılarak yükselmesi | `OdometerText`, `CountingIntText` |
| `liquid_water_fill` | Su sayacında dalgalı dolum (`Curves.elasticOut`) ve damlacık sıçraması | `WaterTrackerCard`, `FluidWaterBar` |
| `kick_shockwave` | Tekme butonuna basıldığında dışa doğru genişleyen pembe aura halkası | `RippleShockwave`, `KickCounterCard` |
| `staggered_cascade` | Sekme açılışlarında kartların yukarıdan aşağıya kademeli süzülüşü (40ms aralıklı) | `StaggeredSlideFade` |
| `clay_spring_physics` | Buton ve kartların basılıp bırakılmasında hamur gibi yaylanma (`Curves.easeOutBack`) | `ClayButton`, `ClayCard` |
| `micro_celebration` | Günlük hedefler tamamlandığında kart köşesinden fırlayan pastel pırıltılar | `SparkleBurst` |

## 4. Commands
- **Test:** `flutter test`
- **Derleme / Kod Analizi:** `flutter analyze`
- **Canlı Çalıştırma:** `flutter run -d chrome --web-port=8086`

## 5. Code Style & Standartlar
```dart
// Örnek: Odometer / Akışkan Sayı Animasyonu
class CountingNumberText extends StatelessWidget {
  final num value;
  final String suffix;
  final TextStyle style;
  final Duration duration;

  const CountingNumberText({
    super.key,
    required this.value,
    this.suffix = '',
    required this.style,
    this.duration = const Duration(milliseconds: 650),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, val, child) {
        return Text(
          '${val.toInt()}$suffix',
          style: style,
        );
      },
    );
  }
}
```

## 6. Boundaries (Sınırlar)
- **Always:** `HapticFeedback` çağrıları kullanıcıyı rahatsız etmeyecek mikro seviyelerde tutulmalıdır (`lightImpact` veya `selectionClick`).
- **Never:** Layout boyutunu (width/height) sürekli tetikleyen ağır `setState` döngüleri kullanılmamalıdır; `Transform` ve `AnimatedBuilder` tercih edilmelidir.
- **Never:** Sonsuz dikkat dağıtıcı döngü animasyonları eklenmemelidir (yalnızca fetus arkasındaki çok hafif nabız aurası istisnadır, o da %3'lük mikro bir genliktedir).

## 7. Success Criteria (Kabul Kriterleri)
1. Fetus kartı açıldığında arkasındaki yumuşak aura anne nabzı hızında nefes almalı, dokunulduğunda tok ve tatlı bir çift tıklama haptiği vermelidir.
2. Dashboard açıldığında gebelik günü, kalan gün ve günlük özet sayaçları 0'dan mevcut rakama doğru akıcı şekilde saymalıdır.
3. Su ekleme butonlarına (`+250ml`, `+500ml`) basıldığında bar dolumu yaylanarak yükselmeli ve haptik geri bildirim vermelidir.
4. Tekme sayacında her basışta merkezden dışa pembe şeffaf şok dalgası halkası genişlemelidir.
5. `flutter test` ile tüm yeni mikro etkileşimlerin testleri (en az 5 yeni test) yeşil geçmeli, toplam test sayısı 55+ olmalıdır.
