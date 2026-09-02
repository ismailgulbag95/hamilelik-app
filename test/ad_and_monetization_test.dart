import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aura_pregnancy/core/services/ad_service.dart';
import 'package:aura_pregnancy/views/widgets/clay_native_ad_card.dart';
import 'test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Aura Monetizasyon ve Reklam Testleri', () {
    test('1. AdService test kimlikleri ve başlatma kontrolü', () async {
      final service = AdService.instance;
      expect(AdService.androidRewardedTestId, isNotEmpty);
      expect(AdService.iosRewardedTestId, isNotEmpty);
      expect(AdService.androidNativeTestId, isNotEmpty);
      expect(AdService.iosNativeTestId, isNotEmpty);

      await service.initialize();
      expect(service.isInitialized, isTrue);
    });

    testWidgets('2. ClayNativeAdCard widget arayüzde doğru render edilir', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const Scaffold(
            body: SingleChildScrollView(
              child: ClayNativeAdCard(
                title: 'Özel Sponsorlu Başlık',
                description: 'Özel sponsorlu açıklama metni',
                buttonText: 'İncele',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sponsorlu Destekçi'), findsOneWidget);
      expect(find.text('Özel Sponsorlu Başlık'), findsOneWidget);
      expect(find.text('Özel sponsorlu açıklama metni'), findsOneWidget);
      expect(find.text('İncele'), findsOneWidget);
    });
  });
}
