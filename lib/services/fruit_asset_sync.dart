/// Aura Pregnancy - 3D Claymorphic Meyve & Sebze Görsel Eşleştirici
/// %100 Web, Mobil ve Masaüstü Uyumlu (Saf Dart)
class Fruit3DAssetManager {
  /// Haftaya göre 3D meyve anahtarını döndürür
  static String getFruitKeyForWeek(int week) {
    if (week <= 5) return 'seed';
    if (week <= 8) return 'blueberry';
    if (week <= 10) return 'strawberry';
    if (week <= 11) return 'lemon';
    if (week <= 13) return 'peach';
    if (week <= 15) return 'peach';
    if (week <= 16) return 'avocado';
    if (week <= 17) return 'peach';
    if (week <= 19) return 'banana';
    if (week <= 20) return 'banana';
    if (week <= 23) return 'peach';
    if (week <= 24) return 'corn';
    if (week <= 27) return 'eggplant';
    if (week <= 29) return 'eggplant';
    if (week <= 31) return 'coconut';
    if (week <= 32) return 'pineapple';
    if (week <= 35) return 'melon';
    if (week <= 38) return 'melon';
    return 'watermelon';
  }

  /// 11 aşamalı serüven için index'e göre 3D meyve anahtarını döndürür
  static String getFruitKeyForStageIndex(int index) {
    switch (index) {
      case 0: return 'seed';
      case 1: return 'blueberry';
      case 2: return 'strawberry';
      case 3: return 'lemon';
      case 4: return 'avocado';
      case 5: return 'banana';
      case 6: return 'corn';
      case 7: return 'coconut';
      case 8: return 'pineapple';
      case 9: return 'melon';
      case 10: return 'watermelon';
      default: return 'avocado';
    }
  }

  /// Belirtilen meyve anahtarı için 3D görsel dosya yolunu döndürür
  static String getAssetImagePath(String fruitKey) {
    return 'assets/images/fruit_$fruitKey.jpg';
  }
}
