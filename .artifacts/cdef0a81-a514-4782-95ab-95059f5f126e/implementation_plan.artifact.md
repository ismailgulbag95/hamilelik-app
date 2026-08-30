# GitHub Actions Build Hatası Giderimi ve Web Uyumluluk İyileştirmesi

GitHub Actions üzerinde "kırmızı" (hata) veren build sürecini düzeltmek için kapsamlı bir temizlik ve iyileştirme planı.

## User Review Required

> [!IMPORTANT]
> Projenizdeki `test/` klasöründe bulunan bazı dosyalar derleme hatasına (exit code 1) yol açıyor. Bu durum GitHub Actions sürecini (build sırasında analiz yapılıyorsa) durduruyor olabilir. Bu hataları ve gereksiz importları temizleyeceğiz.

## Proposed Changes

### 1. Test Hatalarının Giderilmesi
`test/generate_ultrasound_assets_test.dart` ve `test/journey_tracker_test.dart` dosyalarındaki konst (constant) ifade hataları ve eksik parametreler giderilecek.

### 2. Web Uyumluluğu (MediaService)
`Image.file` kullanımı web derleyicisi için daha izole hale getirilecek. `dynamic` cast'i yerine, `Image.file` çağrısını web ortamında tamamen pasif kılacak bir yapı kullanılacak.

### 3. Temizlik (Unused Imports)
`lib/main.dart` ve diğer dosyalardaki derleme uyarılarına yol açan kullanılmayan importlar temizlenecek.

---

## [MODIFY] [media_service.dart](file:///D:/github/hamilelik-app/lib/services/media_service.dart)
- `Image.file` çağrısını web ortamında derleme hatası vermemesi için daha güvenli bir bloğa alacağız.

## [MODIFY] [generate_ultrasound_assets_test.dart](file:///D:/github/hamilelik-app/test/generate_ultrasound_assets_test.dart)
- `Methods can't be invoked in constant expressions` hatasını düzeltmek için `const` ifadeleri kaldırılacak.

## [MODIFY] [main.dart](file:///D:/github/hamilelik-app/lib/main.dart)
- Kullanılmayan `onboarding_screen.dart` ve `fruit_asset_sync.dart` importları temizlenecek.

## Verification Plan

### Automated Tests
- Yerel ortamda `flutter analyze` komutu ile hatasız (sıfır error) durum doğrulanacak.
- Yerel ortamda `flutter build web --release` komutu ile başarılı build doğrulanacak.

### Manual Verification
- GitHub'a push yapıldıktan sonra GitHub Actions (Actions sekmesi) üzerinden sürecin "yeşil" (başarılı) olduğu kontrol edilecek.
