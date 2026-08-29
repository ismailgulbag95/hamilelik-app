import 'package:flutter/material.dart';

/// Aura Pregnancy Pastel & Claymorphism Renk Paleti
class AppColors {
  // Arka Plan Tint Tonları (Soft Tinted Background)
  static const Color background = Color(0xFFFDF7F4); // Soft warm porcelain
  static const Color backgroundSubtle = Color(0xFFF6ECE7);

  // Clay Kart Yüzeyleri (Light Pastels)
  static const Color clayRose = Color(0xFFFDE8ED);      // Romantik Pembe
  static const Color clayPeach = Color(0xFFFEE8D6);     // Şeftali / Somon
  static const Color clayLavender = Color(0xFFEDE7F6);  // Lavanta
  static const Color clayMint = Color(0xFFE8F5E9);      // Nane Yeşili
  static const Color claySky = Color(0xFFE3F2FD);       // Bebek Mavisi
  static const Color clayCream = Color(0xFFFFF8E7);     // Sıcak Krem
  static const Color clayCardSurface = Color(0xFFFFF5F5); // Temel Kart

  // Vurgu & Aksiyon Renkleri (4.5:1 kontrast garantili)
  static const Color primaryPink = Color(0xFFD85A7F);    // Ana Romantik Pembe
  static const Color primaryDark = Color(0xFF8E2A4B);    // Kontrast Başlık Rengi
  static const Color secondaryPeach = Color(0xFFE07A5F); // Şeftali Vurgu
  static const Color accentGold = Color(0xFFD4A373);     // Romantik Gold / Bal
  static const Color lavenderPurple = Color(0xFF7E57C2); // Lavanta Moru Vurgu
  static const Color medicalAlertRed = Color(0xFFD32F2F);// Acil Durum / Kırmızı Alarm
  static const Color medicalAlertBg = Color(0xFFFFEBEE); // Acil Kart Arka Planı
  static const Color successGreen = Color(0xFF388E3C);   // Tamamlandı / Başarı
  static const Color waterBlue = Color(0xFF42A5F5);      // Su Takibi
  static const Color caffeineBrown = Color(0xFF8D6E63);  // Kafein Takibi

  // Tipografi Renkleri (Yüksek okunabilirlik)
  static const Color textPrimary = Color(0xFF2D232E);    // Koyu Erik / Siyah
  static const Color textSecondary = Color(0xFF6B5E62);  // Yumuşak Gri-Mürdüm
  static const Color textMuted = Color(0xFF9E8F94);      // Soluk Gri

  // Claymorphic Gölge Renkleri (Shadow Recipe Helpers)
  static const Color clayHighlightTop = Color(0xFFFFFFFF); // Üst Işık (255,255,255, .65)
  static const Color clayShadowDark = Color(0x28000000);   // Alt İç Gölge (rgba(0,0,0, .16))
  static const Color clayOuterDrop = Color(0x24C49A9E);    // Dış Yumuşak Gölge (rgba(196,154,158, .18))
}
