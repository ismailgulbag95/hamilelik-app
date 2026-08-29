import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aura_pregnancy/views/welcome/app_guide_screen.dart';
import 'package:aura_pregnancy/views/onboarding/onboarding_screen.dart';
import 'package:aura_pregnancy/views/main_navigation_scaffold.dart';
import 'package:aura_pregnancy/services/database_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Reset or ensure clean state
    await DatabaseHelper.instance.close();
  });

  group('Onboarding ve Navigasyon Akış Testleri', () {
    testWidgets('OnboardingScreen adımları tamamlanır ve Profili Kaydet ve Başla ana ekrana yönlendirir', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OnboardingScreen(),
        ),
      );

      // Adım 1: Hamilelik Başlangıcı
      expect(find.text('Hamilelik Başlangıcı'), findsOneWidget);
      expect(find.text('Devam Et →'), findsOneWidget);
      await tester.tap(find.text('Devam Et →'));
      await tester.pumpAndSettle();

      // Adım 2: Boy & Kilo Bilgisi
      expect(find.text('Boy & Kilo Bilgisi'), findsOneWidget);
      expect(find.text('Özeti Görüntüle →'), findsOneWidget);
      await tester.tap(find.text('Özeti Görüntüle →'));
      await tester.pumpAndSettle();

      // Adım 3: Özet ve Kayıt
      expect(find.text('Aura Yolculuğunuz Başlıyor!'), findsOneWidget);
      expect(find.text('✨ Profili Kaydet ve Başla'), findsOneWidget);

      // Profili Kaydet ve Başla'ya bas
      await tester.tap(find.text('✨ Profili Kaydet ve Başla'));
      await tester.pumpAndSettle();

      // Ana Sayfa Dashboard'a geçiş doğrulama
      expect(find.byType(MainNavigationScaffold), findsOneWidget);
      expect(find.text('Ana Sayfa'), findsOneWidget);
      expect(find.text('Haftalık'), findsOneWidget);
      expect(find.text('Takip'), findsOneWidget);
    });

    testWidgets('AppGuideScreen tamamlanınca OnboardingScreen açılır', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppGuideScreen(),
        ),
      );

      expect(find.text('Uygulama Rehberi'), findsOneWidget);
      expect(find.text('Atla ➔'), findsOneWidget);

      // Atla butonuna bas
      await tester.tap(find.text('Atla ➔'));
      await tester.pumpAndSettle();

      // OnboardingScreen açılmış olmalı
      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(find.text('Hamilelik Başlangıcı'), findsOneWidget);
    });
  });
}
