# Aura Pregnancy - GEMINI IDE Kuralları

## UI Tarzı: Claymorphism (flutter_inset_box_shadow)
Tüm arayüz geliştirmelerinde `flutter_inset_box_shadow` paketi kullanılarak Claymorphism tasarım dili uygulanacaktır:
```dart
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
```

### Kesin Gölge ve Tasarım Formülü:
- **Arka Plan:** `Color(0xFFFDF7F4)`
- **Dış Gölge:** `BoxShadow(color: Colors.black.withOpacity(0.18), offset: const Offset(0, 24), blurRadius: 40, inset: false)`
- **Üst İç Işık:** `BoxShadow(color: Colors.white.withOpacity(0.65), offset: const Offset(0, 8), blurRadius: 16, inset: true)`
- **Alt İç Gölge:** `BoxShadow(color: Colors.black.withOpacity(0.15), offset: const Offset(0, -8), blurRadius: 16, inset: true)`
- **Basılma (Pressed - Kural E):** Dış gölge küçülür (`offset: Offset(0, 8), blurRadius: 16`), iç gölgeler derinleşir (`offset: Offset(0, ±12), blurRadius: 20, inset: true`).
- **Köşe Yuvarlaklığı:** 56px kontrollerde ~26px, kartlarda 30-34px.
- **Tipografi & Kontrast:** `GoogleFonts.nunito` / `quicksand`, metin rengi `Color(0xFF2D232E)`.

## 3. Android Build & Gradle Standartları
- **Java / JDK:** Eclipse Adoptium Temurin JDK 17 (`C:\Program Files\Eclipse Adoptium\jdk-17.0.20.101-hotspot`).
- **Gradle Wrapper:** `gradle-8.9-all.zip`
- **Android Gradle Plugin (AGP):** `8.7.0` (Kotlin `1.9.24`).
- **Gradle Properties:** `org.gradle.java.home=C\:\\Program Files\\Eclipse Adoptium\\jdk-17.0.20.101-hotspot` sabit tanımlanmalı.
- **VS Code Ayarları:** `.vscode/settings.json` içinde `java.import.gradle.enabled: false` ve `gradle.autoDetect: "off"` tutulmalı (Eclipse Buildship phantom hatalarını ve Gradle lock çakışmalarını önlemek için).
- **Gradle Script Formatı:** Sadece Groovy (`.gradle`) kullanılmalı; çakışmaya yol açan `.gradle.kts` dosyaları temizlenmeli.
- **SDK/NDK Yönetimi:** İleriye dönük tüm SDK / NDK / CMake ihtiyaçlarında paket düşürmek yerine Android Studio SDK Manager kurulumu esas alınacaktır.
