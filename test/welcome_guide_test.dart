import 'package:flutter_test/flutter_test.dart';
import 'package:aura_pregnancy/views/welcome/welcome_congratulation_screen.dart';
import 'package:aura_pregnancy/views/welcome/app_guide_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'test_helper.dart';

void main() {
  testWidgets('WelcomeCongratulationScreen loads and triggers onNext callback', (WidgetTester tester) async {
    bool nextTriggered = false;

    await tester.pumpWidget(
      createLocalizedTestWidget(
        child: WelcomeCongratulationScreen(
          onNext: () {
            nextTriggered = true;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('welcome_title'.tr()), findsOneWidget);
    final btnFinder = find.text('welcome_button'.tr());
    expect(btnFinder, findsOneWidget);

    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    expect(nextTriggered, isTrue);
  });

  testWidgets('AppGuideScreen displays steps and triggers skip or complete callback', (WidgetTester tester) async {
    bool guideCompleted = false;

    await tester.pumpWidget(
      createLocalizedTestWidget(
        child: AppGuideScreen(
          onCompleteGuide: () {
            guideCompleted = true;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Initial step 1
    expect(find.text('guide_app_title'.tr()), findsOneWidget);
    expect(find.text('guide_step1_title'.tr()), findsOneWidget);
    final skipBtn = find.text('guide_skip'.tr());
    expect(skipBtn, findsOneWidget);

    // Test skip action
    await tester.tap(skipBtn);
    await tester.pumpAndSettle();

    expect(guideCompleted, isTrue);
  });
}
