import 'package:flutter/foundation.dart';
import 'dart:io' if (dart.library.html) 'io_stubs.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

/// Aura Pregnancy - App Tracking Transparency (ATT) & Gizlilik Servisi
/// Apple App Store Guideline 5.1.2 gereğince IDFA ve kişiselleştirilmiş reklam/içerik iznini yönetir.
class AttTrackingService {
  AttTrackingService._();

  static final AttTrackingService instance = AttTrackingService._();

  /// iOS ortamında izin durumunu kontrol eder ve henüz sorulmadıysa izin dialoğunu tetikler.
  Future<TrackingStatus> requestConsentIfNeeded() async {
    if (kIsWeb || !Platform.isIOS) {
      return TrackingStatus.notSupported;
    }

    try {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        // Apple tavsiyesi: Ekran çizildikten ve kullanıcı arayüzü oturduktan hemen sonra modal açılır
        await Future.delayed(const Duration(milliseconds: 350));
        return await AppTrackingTransparency.requestTrackingAuthorization();
      }
      return status;
    } catch (e) {
      debugPrint('[ATT Service] Tracking request error: $e');
      return TrackingStatus.notSupported;
    }
  }

  /// Mevcut takip yetkisini döndürür.
  Future<TrackingStatus> get status async {
    if (kIsWeb || !Platform.isIOS) {
      return TrackingStatus.notSupported;
    }
    try {
      return await AppTrackingTransparency.trackingAuthorizationStatus;
    } catch (e) {
      return TrackingStatus.notSupported;
    }
  }

  /// Reklam veya analiz SDK'ları için reklam tanımlayıcısını güvenle çeker.
  Future<String?> getAdvertisingId() async {
    if (kIsWeb || !Platform.isIOS) return null;
    try {
      final authStatus = await status;
      if (authStatus == TrackingStatus.authorized) {
        return await AppTrackingTransparency.getAdvertisingIdentifier();
      }
    } catch (e) {
      debugPrint('[ATT Service] getAdvertisingId error: $e');
    }
    return null;
  }
}
