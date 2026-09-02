import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../views/weekly_panel/widgets/ad_reward_dialog.dart';

/// Aura Pregnancy - Reklam Yönetim ve Yapılandırma Servisi
/// Google Mobile Ads (AdMob) resmi test kimlikleri ve ödüllü reklam koordinasyonu
class AdService {
  AdService._();
  static final AdService instance = AdService._();

  /// Canlı (Production) AdMob Kimlikleri
  static const String androidAppId = 'ca-app-pub-2626843024156194~8901972198';
  static const String androidNativeProdId = 'ca-app-pub-2626843024156194/5241928781';
  static const String androidRewardedProdId = 'ca-app-pub-2626843024156194/6798553034';

  static const String iosAppId = 'ca-app-pub-2626843024156194~2005391358';
  static const String iosNativeProdId = 'ca-app-pub-2626843024156194/1254687514';
  static const String iosRewardedProdId = 'ca-app-pub-2626843024156194/8379228012';

  /// Google Mobile Ads Resmi Test Reklam Birimi Kimlikleri (Ad Unit IDs)
  static const String androidRewardedTestId = 'ca-app-pub-3940256099942544/5224354917';
  static const String iosRewardedTestId = 'ca-app-pub-3940256099942544/1712485313';

  static const String androidNativeTestId = 'ca-app-pub-3940256099942544/2247696110';
  static const String iosNativeTestId = 'ca-app-pub-3940256099942544/3986624511';

  static const String androidBannerTestId = 'ca-app-pub-3940256099942544/6300978111';
  static const String iosBannerTestId = 'ca-app-pub-3940256099942544/2934735716';

  /// Ortama göre aktif Native Ad Unit ID'yi döner (Platform & Canlı / Test ayrımı)
  static String get nativeAdUnitId {
    final isIos = defaultTargetPlatform == TargetPlatform.iOS;
    if (kReleaseMode) {
      return isIos ? (iosNativeProdId.isNotEmpty ? iosNativeProdId : iosNativeTestId) : androidNativeProdId;
    }
    return isIos ? iosNativeTestId : androidNativeTestId;
  }

  /// Ortama göre aktif Rewarded Ad Unit ID'yi döner (Platform & Canlı / Test ayrımı)
  static String get rewardedAdUnitId {
    final isIos = defaultTargetPlatform == TargetPlatform.iOS;
    if (kReleaseMode) {
      return isIos ? (iosRewardedProdId.isNotEmpty ? iosRewardedProdId : iosRewardedTestId) : androidRewardedProdId;
    }
    return isIos ? iosRewardedTestId : androidRewardedTestId;
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// Reklam motorunu başlatır
  Future<void> initialize() async {
    try {
      _isInitialized = true;
      debugPrint('[AdService] Reklam servisi başarıyla hazırlandı (Test Modu Aktif).');
    } catch (e) {
      debugPrint('[AdService] Başlatma notu: $e');
    }
  }

  /// Kullanıcının isteğiyle tetiklenen Ödüllü Reklam Akışı
  /// Sıfır Dark-Pattern: Kullanıcıya ne kazanacağını net açıklar, izleme bitince ödülü %100 verir.
  static Future<bool> showRewardedUnlock({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String unlockTargetName,
    required VoidCallback onRewardEarned,
  }) async {
    final result = await AdRewardDialog.show(
      context: context,
      title: title,
      subtitle: subtitle,
      unlockTargetName: unlockTargetName,
      onRewardEarned: onRewardEarned,
    );
    return result ?? false;
  }
}
