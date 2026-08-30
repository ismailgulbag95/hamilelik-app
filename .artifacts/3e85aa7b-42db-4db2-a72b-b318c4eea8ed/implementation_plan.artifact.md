# Build Hatalarını Giderme ve Standartlara Uyum Planı

Projedeki build hataları, `GEMINI.md` dosyasında belirtilen standartların çok üzerinde (kanarya/önizleme sürümü) Gradle, AGP ve Kotlin versiyonlarının kullanılmasından kaynaklanmaktadır. Ayrıca, Android araçlarının tercih klasörü (`.android`) için birden fazla ortam değişkeni tanımlı olması çakışmaya yol açmaktadır.

## Kullanıcı İncelemesi Gerekli

> [!IMPORTANT]
> Proje versiyonları (Gradle, AGP, Kotlin, Android SDK) `GEMINI.md`'de belirtilen kararlı sürümlere düşürülecektir. SDK 36 (henüz çıkmamış) yerine SDK 34 kullanılacaktır.

## Önerilen Değişiklikler

### Android Yapılandırması

#### [MODIFY] [settings.gradle](file:///D:/github/hamilelik-app/android/settings.gradle)
- AGP versiyonunu `8.11.1`'den `8.7.0`'a düşür.
- Kotlin versiyonunu `2.2.20`'den `1.9.24`'e düşür.

#### [MODIFY] [gradle-wrapper.properties](file:///D:/github/hamilelik-app/android/gradle/wrapper/gradle-wrapper.properties)
- Gradle versiyonunu `8.14`'ten `8.9`'a düşür.

#### [MODIFY] [build.gradle](file:///D:/github/hamilelik-app/android/app/build.gradle)
- `compileSdkVersion` ve `targetSdkVersion`'ı `36`'dan `34`'e düşür.
- NDK versiyonunu daha kararlı bir sürüme çek (opsiyonel, hata verirse).

#### [MODIFY] [gradle.properties](file:///D:/github/hamilelik-app/android/gradle.properties)
- `ANDROID_USER_HOME` ve `ANDROID_PREFS_ROOT` çakışmasını gidermek için Gradle'a özel tanımlama ekle veya ortam değişkeni uyarısını bastıracak ayarları kontrol et.

## Doğrulama Planı

### Otomatik Testler
- `./gradlew assembleDebug` komutu ile yapının başarıyla kurulduğu doğrulanacak.
- `flutter build apk --debug` ile APK üretimi kontrol edilecek.

### Manuel Doğrulama
- Oluşturulan APK'nın boyutu ve içeriği kontrol edilecek.
