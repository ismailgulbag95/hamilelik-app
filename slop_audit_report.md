# Aura Pregnancy - Slop Tasarım ve İçerik Denetim Raporu

**Tarih:** 2 Eylül 2026  
**Kapsam:** `lib/` ve `assets/translations/` altındaki tüm ekranlar, bileşenler, tıbbi sabitler ve metinler  
**Tasarım Dili ve Kurallar:** Claymorphism (`flutter_inset_box_shadow` 3 katmanlı gölge formülü, `#FDF7F4` krem arka plan, pastel yüzeyler, `#2D232E` kömür metin, Kural E Basılma Durumu) ve `stop-slop` metin standartları.

---

## 1. Yönetici Özeti (Executive Summary)

Aura Pregnancy projesinde `ClayTheme`, `ClayCard` ve `ClayButton` gibi güçlü bir çekirdek altyapı bulunmasına rağmen; sonradan eklenen ekranlarda, alt bileşenlerde ve form alanlarında sistem dışına çıkılarak **flat Material 3 `BoxDecoration`**, **sahte dış gölgeyle içbükey simülasyonu**, **AI klişesi metinler (`stop-slop`)** ve **hardcoded Türkçe/İngilizce string'ler** tespit edilmiştir.

| Denetim Ekseni | İncelenen Dosya Sayısı | Tespit Edilen Slop Maddesi | Durum |
| :--- | :---: | :---: | :--- |
| **Görsel & UI Slop (Claymorphism)** | 18 | 12 | ⚠️ Düzeltme Gerekiyor |
| **Metin & İçerik Slop (stop-slop & i18n)** | 4 | 9 | ⚠️ Düzeltme Gerekiyor |
| **Mimari & Kod Slop (Sabitler & Layout)** | 12 | 6 | ⚠️ İyileştirme Önerisi |

---

## 2. Eksen 1: Görsel & UI Slop Taraması (Claymorphism & Tasarım)

Bu bölümde `AGENTS.md` ve `GEMINI.md` dosyalarında belirtilen Claymorphism tasarım formülüne (dış gölge + üst iç ışık + alt iç gölge) aykırı, basılma durumu (Kural E) eksik veya jenerik flat kart/buton kullanılan yerler listelenmiştir.

| # | Dosya Yolu | Satır Aralığı | Slop Türü | Mevcut Durum | Önerilen Claymorphic Çözüm |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **G-01** | `lib/views/emergency/widgets/emergency_sign_card.dart` | 23 - 47 | Standart Flat Gölgelendirme | `BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.red.withValues(alpha: 0.12), blurRadius: 16, offset: Offset(0, 6))])` kullanılmış. Çift içbükey ışık ve alt iç gölge yok. | Kart `ClayTheme.clayDecoration` veya `ClayCard` yapısına geçirilmeli, acil duruma özel `AppColors.medicalAlertBg` zemin rengi ve kırmızı tonlu dış/iç gölgeler tanımlanmalıdır. |
| **G-02** | `lib/views/journal/widgets/clay_audio_player.dart` | 53 - 68 | Eksik İç Gölge / Flat Kart | Sadece tek bir dış gölge (`BoxShadow(blurRadius: 10, offset: Offset(0, 4))`) kullanılmış. `flutter_inset_box_shadow` paketi içe aktarılmamış. | `flutter_inset_box_shadow` eklenerek üst iç ışık (`Colors.white.withValues(alpha: 0.65), offset: Offset(0, 6), inset: true`) ve alt iç gölge uygulanmalı. |
| **G-03** | `lib/views/widgets/clay_input.dart` | 50 - 74 | Sahte İçbükey Simülasyonu | Metin giriş alanı içe oyuk (concave) hissi vermek için dış negatif/pozitif gölgeler (`offset: Offset(0, 4)` ve `Offset(0, -2)`) ile simüle edilmiş, gerçek `inset: true` kullanılmamış. | Gerçek gömülü claymorphic hissiyat için `inset: true` parametreli iç gölge formülü (`BoxShadow(color: Colors.black.withValues(alpha: 0.08), offset: Offset(0, 4), blurRadius: 6, inset: true)`) uygulanmalı. |
| **G-04** | `lib/views/weekly_panel/widgets/pregnancy_journey_tracker.dart` | 142 - 155 | Arka Planla Aynı Renkte Flat Kart | Kart zemini `color: const Color(0xFFFDF7F4)` verilmiş ve sadece hafif dış gölge kullanılmış. Zeminle aynı renkte flat kart yasağını ihlal ediyor. | Kart rengi `AppColors.clayRose` veya `AppColors.clayCardSurface` yapılmalı, 3 katmanlı Claymorphism gölgesi eklenmeli. |
| **G-05** | `lib/views/weekly_panel/widgets/ad_reward_dialog.dart` | 97 - 110 | Jenerik Material Dialog | Standart köşeli `BoxDecoration(color: Colors.white, borderRadius: 28, boxShadow: [BoxShadow(...)])` kullanılmış. Rule E basılma durumu ve iç ışık yok. | Dialog gövdesi `ClayTheme.clayDecoration(color: AppColors.clayCardSurface, borderRadius: 28)` ile sarılmalı, butonlar `ClayButton` ile değiştirilmeli. |
| **G-06** | `lib/views/timeline/timeline_screen.dart` | 214 - 238 | Jenerik Material FAB | `FloatingActionButton.extended(backgroundColor: AppColors.primaryPink, elevation: 4)` kullanılmış. Material elevation Claymorphism diliyle çakışıyor. | FAB yerine ekranın alt ortasında konumlandırılmış `ClayButton` veya claymorphic genişletilmiş buton kullanılmalı. |
| **G-07** | `lib/views/timeline/timeline_screen.dart` | 291 - 313 | Flat Özet Kutuları | `_buildSummaryBox` içindeki kutular `BoxDecoration(color: Colors.white.withValues(alpha: 0.85), borderRadius: 16)` şeklinde flat beyaz kutu olarak çizilmiş. | Kutular yumuşak pastel clay zeminler (`AppColors.clayMint`, `AppColors.claySky` vb.) ve mikro-inset gölgeyle kabartılmalı. |
| **G-08** | `lib/views/timeline/timeline_screen.dart` | 337 - 368 | Jenerik Filtre Çipi | `_buildFilterChip` seçildiğinde flat pembe arka plan ve tek dış gölge kullanıyor. Rule E basılma efekti yok. | Seçilme durumu `ClayTheme.clayDecoration(color: isSelected ? AppColors.clayRose : Colors.white, isPressed: isSelected)` olarak yapılandırılmalı. |
| **G-09** | `lib/views/dashboard/widgets/profile_edit_sheet.dart` | 249 - 265 | Flat Cinsiyet Hapı (Pill) | `_buildGenderPill` seçildiğinde neon/opak renk (`activeColor`) ve tek dış parlama gölgesi (`BoxShadow(...)`) kullanıyor. Metin kontrastı ve pastel kuralı bozuluyor. | Cinsiyet butonları `ClayTheme.clayDecoration(color: isSelected ? activeColorPastel : bgColor, isPressed: isSelected)` formülüne taşınmalı. |
| **G-10** | `lib/views/daily_tracker/widgets/medication_tracker_card.dart` | 338 - 351 | Flat İlaç Satırları | Liste elemanları `BoxDecoration(color: isTaken ? AppColors.clayMint : Colors.white, boxShadow: [BoxShadow(...)])` ile flat çizilmiş. | Satırlar bağımsız mikro `ClayCard` bileşenlerine dönüştürülmeli. |
| **G-11** | `lib/views/weekly_panel/widgets/medical_tests_checklist_card.dart` | 57 - 67 | Flat Durum Butonu | Test tamamlandı rozeti flat `BoxDecoration` ve jenerik yeşil dolgu kullanıyor. Basılma animasyonu ve iç derinlik yok. | Buton `ClayButton` veya `isPressed: _isCompleted` parametreli `ClayTheme.clayDecoration` ile yeniden yazılmalı. |
| **G-12** | `lib/core/widgets/fruit_3d_widget.dart` | 42 - 55 | Negatif Offset Simülasyonu | `BoxShadow(color: Colors.white, offset: Offset(0, -2))` ile ışık taklit edilmiş, gerçek inset kullanılmamış. | `flutter_inset_box_shadow` ile üst iç ışık (`Offset(0, 4), inset: true`) ve alt iç gölge formülüne geçilmeli. |

---

## 3. Eksen 2: Metin & İçerik Slop Taraması (`stop-slop` & Tıbbi Güvenlik)

Bu eksende yapay zeka tarafından üretilmiş, şişirilmiş, robotik ("Unutmayın ki...", "Harika bir yolculuk!", "Büyülü anlar...") klişe metinler ile eksik çeviri anahtarları ve tıbbi doğruluk parametreleri incelenmiştir.

| # | Dosya Yolu | Satır Aralığı | Slop Türü | Mevcut Durum | Önerilen Doğal/Tıbbi Çözüm (`stop-slop`) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **T-01** | `assets/translations/tr.json` | 11 | AI Klişe Metin | `"welcome_subtitle": "Hayatınızın en mucizevi ve sevgi dolu yolculuğu başladı."` | `"welcome_subtitle": "Hamileliğiniz boyunca bebeğinizin gelişimini ve sağlığınızı adım adım izleyin."` |
| **T-02** | `assets/translations/tr.json` | 12 | AI Pazarlama Ağzı | `"welcome_desc": "Aura Pregnancy, hamileliğinizin her anında bebeğinizin gelişimini uzman tıbbi referanslarla izlemeniz ve bu eşsiz 40 haftayı romantik anılarla ölümsüzleştirmeniz için tasarlandı."` | `"welcome_desc": "Klinik kılavuzlara uygun hafta hafta bebek gelişimi, günlük sağlık takipleri ve güvenli anı günlüğü."` |
| **T-03** | `assets/translations/tr.json` | 124 | Yapay Zeka Dolgu Metni | `"week_2_baby_dev": "Yumurtlama ve döllenme gerçekleşir. Genetik mirasın temelleri bu mucizevi anda atılır."` | `"week_2_baby_dev": "Yumurtlama ve döllenme gerçekleşir; bebeğin genetik yapısı bu aşamada belirlenir."` |
| **T-04** | `assets/translations/tr.json` | 233 | Ünlem / Coşku Şişirmesi | `"week_31_mother_changes": "Doğum çantası hazırlık listelerini oluşturmaya başlamak için harika bir hafta."` | `"week_31_mother_changes": "Doğum çantası hazırlık listesini bu haftalarda tamamlamanız önerilir."` |
| **T-05** | `assets/translations/tr.json` | 305 | Klişe "Unutmayın" Kalıbı | `"walking_tip_t1": "...Yeterli su içmeyi unutmayın."` | `"walking_tip_t1": "1. Trimester: Günde 20-30 dakikalık hafif yürüyüşler sabah bulantılarını azaltabilir. Yürüyüş öncesi ve sonrası su tüketimine dikkat ediniz."` |
| **T-06** | `assets/translations/tr.json` | 311 | Şişirilmiş Coşku | `"walking_target_reached": "Harika! Günlük hedef tamamlandı"` | `"walking_target_reached": "Günlük yürüyüş hedefi tamamlandı"` |
| **T-07** | `lib/core/constants/medical_specs.dart` | 46 - 50 | Hardcoded TR String | `trimesterEnergyRequirements` doğrudan Türkçe string içeriyor (`1: '1. Trimester... +0 kkal...'`), dil dosyasına bağlı değil. | Anahtarlar `nutrition_t1_energy.tr()`, `nutrition_t2_energy.tr()` şeklinde JSON dil dosyalarına taşınmalı. |
| **T-08** | `lib/views/emergency/widgets/edit_emergency_card_sheet.dart` | 190, 234, 241, 257 | Hardcoded Hint Metinleri | Form ipuçları (`hint: 'Örn: Zeynep Çelik'`, `'Örn: Penisilin, Fıstık'`, `'Örn: Ahmet Yılmaz (Eş)'`) doğrudan kod içinde gömülü. | Tüm form ipuçları `tr.json` ve `en.json` içine taşınarak `emergency_hint_name.tr()` ile çağrılmalı. |
| **T-09** | `lib/views/daily_tracker/widgets/medication_tracker_card.dart` | 78 - 80, 168 - 195 | Hardcoded DB Değerleri | Veritabanına `'Sabah Tok'`, `'Vitamin'` gibi lokalize edilmemiş Türkçe metinler kaydediliyor. Dil değiştiğinde filtreler bozulabilir. | DB değerleri enum/anahtar (`'morning_full'`, `'vitamin'`) olarak tutulmalı, UI'da `.tr()` ile gösterilmelidir. |

---

## 4. Eksen 3: Mimari & Kod Slop Taraması (Container, Stil ve Sabitler)

| # | Dosya Yolu | Satır Aralığı | Slop Türü | Mevcut Durum | Önerilen Mimari Çözüm |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **K-01** | `lib/views/timeline/timeline_screen.dart` | 405 - 409 | Statik Piksel Çizgi Yüksekliği | `height: 160 + (day.diaries.length * 120.0)` sabit piksel hesaplaması kullanılmış. Dinamik metin boyutu veya farklı ekran DPI'larında dikey çizgi kartla hizasını kaybedebilir. | `IntrinsicHeight` veya `CustomPainter` / `timeline_tile` deseni kullanılarak çizgi boyutu kart yüksekliğine otomatik bağlanmalı. |
| **K-02** | `lib/views/dashboard/widgets/profile_edit_sheet.dart` | 145 - 155, 178 - 188 | Tekrarlayan TextField Yapısı | Aynı `InputDecoration` stili 4 farklı yerde kopyala-yapıştır ile yazılmış. | Projedeki merkezi `ClayTextField` bileşeni kullanılmalı veya ortak dekorasyon metodu tanımlanmalı. |
| **K-03** | `lib/core/widgets/interactive_3d_fetus_widget.dart` | 1 - 180 | Çoklu Widget Sarmalama Karmaşası | 3D fetus görselleştirmesi için 3 farklı dosya (`real_womb_fetus_widget`, `animated_womb_baby_widget`, `medical_ultrasound_womb_widget`) gereksiz katmanlarla birbirine bağlanmış. | Fetus gösterim mantığı tek bir sade `WombFetusViewer` bileşeni altında birleştirilerek gereksiz dosya kalabalığı elenmeli. |
| **K-04** | `lib/core/theme/clay_theme.dart` & ekranlar | Genel | Inline Renk Tanımları | Bazı ekranlarda `const Color(0xFF2D232E)` doğrudan hardcoded yazılmış, bazı yerlerde `AppColors.primaryDark` kullanılmış. | Tüm metin ve zemin renkleri istisnasız `AppColors` sabitleri üzerinden referans alınmalı. |
| **K-05** | `lib/views/welcome/app_guide_screen.dart` | 145 - 163 | Standart TextButton | Rehber ekranındaki "Geç" butonu için `TextButton` kullanılmış; dokunma geribildirimi ve tema uyumu eksik. | Küçük claymorphic bir hap buton (`ClayButton` mini) ile değiştirilmeli. |
| **K-06** | `lib/views/weekly_panel/weekly_screen.dart` | 300 - 380 | Derin Container Sarmalama | İç içe 5 katmanlı `Container` -> `Padding` -> `Column` -> `Container` yapısı mevcut. | Gereksiz sarmalayıcı Container'lar kaldırılarak widget ağacı düzleştirilmeli. |

---

## 5. En Acil Top 5 Öncelikli Düzeltme Maddesi

1. **`ClayTextField`'ın Gerçek Çift İçbükey (Concave Inset) Claymorphism'e Taşınması (`lib/views/widgets/clay_input.dart`):**  
   Metin ve sayı giriş alanları projenin en sık kullanılan interaktif bileşenleridir. Sahte dış gölgeler kaldırılarak `flutter_inset_box_shadow` ile gerçek gömülü iç gölge uygulanmalıdır.

2. **Acil Tıbbi Kartlardaki Flat Gölgelerin Düzeltilmesi (`lib/views/emergency/widgets/emergency_sign_card.dart`):**  
   Kritik acil uyarı kartları şu anda flat Material 3 kutuları halindedir; projenin genel Claymorphism kimliğine uygun olarak `ClayCard` yapısına dönüştürülmelidir.

3. **`assets/translations/tr.json` İçindeki AI Klişelerinin (`stop-slop`) Temizlenmesi:**  
   "Mucizevi yolculuk", "büyülü anlar", "özen gösterin", "unutmayın" gibi robotik ve yapay zeka kokan ifadeler klinik ciddiyete, samimi ve duru Türkçeye çevrilmelidir.

4. **`TimelineScreen` ve `MedicationTrackerCard` İçindeki Flat Liste Öğelerinin `ClayCard` Sistemine Geçirilmesi:**  
   Zaman tüneli ve ilaç takip satırları şu anda sıradan beyaz kutulardır; mikro pastel renkler ve yumuşak clay kenarlıkları ile canlandırılmalıdır.

5. **Hardcoded Form İpuçları ve Veritabanı Değerlerinin Çeviri Sistemine Bağlanması (`edit_emergency_card_sheet.dart`, `medication_tracker_card.dart`):**  
   Doğrudan Türkçe yazılmış hint'ler ve DB anahtarları `easy_localization` standartlarına uyumlu hale getirilmelidir.
