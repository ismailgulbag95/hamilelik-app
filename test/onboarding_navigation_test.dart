import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aura_pregnancy/views/welcome/app_guide_screen.dart';
import 'package:aura_pregnancy/views/onboarding/onboarding_screen.dart';
import 'package:aura_pregnancy/views/main_navigation_scaffold.dart';
import 'package:aura_pregnancy/services/database_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await DatabaseHelper.instance.close();
  });

  group('Onboarding ve Navigasyon Akış Testleri', () {
    testWidgets('OnboardingScreen adımları tamamlanır ve Profili Kaydet ve Başla ana ekrana yönlendirir', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const OnboardingScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Adım 1: Hamilelik Başlangıcı
      expect(find.text('onboarding_step1_title'.tr()), findsOneWidget);
      final next1 = find.text('onboarding_continue'.tr());
      expect(next1, findsOneWidget);
      await tester.ensureVisible(next1);
      await tester.tap(next1);
      await tester.pumpAndSettle();

      // Adım 2: Boy & Kilo Bilgisi
      expect(find.text('onboarding_step2_title'.tr()), findsOneWidget);
      final next2 = find.text('onboarding_step2_next'.tr());
      expect(next2, findsOneWidget);
      await tester.ensureVisible(next2);
      await tester.tap(next2);
      await tester.pumpAndSettle();

      // Adım 3: Bebek & Anne Bilgileri
      expect(find.text('onboarding_step3_title'.tr()), findsOneWidget);
      final next3 = find.text('onboarding_step3_next'.tr());
      expect(next3, findsOneWidget);
      await tester.ensureVisible(next3);
      await tester.tap(next3);
      await tester.pumpAndSettle();

      // Adım 4: Özet ve Kayıt
      expect(find.text('onboarding_step4_title'.tr()), findsOneWidget);
      final saveBtn = find.text('onboarding_step4_save'.tr());
      expect(saveBtn, findsOneWidget);

      // Profili Kaydet ve Başla'ya bas
      await tester.ensureVisible(saveBtn);
      await tester.tap(saveBtn);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));

      // Ana Sayfa Dashboard'a geçiş doğrulama
      expect(find.byType(MainNavigationScaffold), findsOneWidget);
      expect(find.text('nav_home'.tr()), findsOneWidget);
      expect(find.text('nav_weekly'.tr()), findsOneWidget);
      expect(find.text('nav_tracker'.tr()), findsOneWidget);
    });

    testWidgets('AppGuideScreen tamamlanınca OnboardingScreen açılır', (WidgetTester tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const AppGuideScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('guide_app_title'.tr()), findsOneWidget);
      final skipBtn = find.text('guide_skip'.tr());
      expect(skipBtn, findsOneWidget);

      // Atla butonuna bas
      await tester.tap(skipBtn);
      await tester.pumpAndSettle();

      // OnboardingScreen açılmış olmalı
      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(find.text('onboarding_step1_title'.tr()), findsOneWidget);
    });
  });
}
