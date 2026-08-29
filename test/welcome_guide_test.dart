import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aura_pregnancy/views/welcome/welcome_congratulation_screen.dart';
import 'package:aura_pregnancy/views/welcome/app_guide_screen.dart';
import 'package:aura_pregnancy/views/main_navigation_scaffold.dart';

void main() {
  testWidgets('WelcomeCongratulationScreen loads and triggers onNext callback', (WidgetTester tester) async {
    bool nextTriggered = false;

    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeCongratulationScreen(
          onNext: () {
            nextTriggered = true;
          },
        ),
      ),
    );

    expect(find.text('Tebrikler Anne Adayı! 🎉'), findsOneWidget);
    expect(find.text('Uygulama Rehberini İncele ✨'), findsOneWidget);

    await tester.tap(find.text('Uygulama Rehberini İncele ✨'));
    await tester.pumpAndSettle();

    expect(nextTriggered, isTrue);
  });

  testWidgets('AppGuideScreen displays steps and triggers skip or complete callback', (WidgetTester tester) async {
    bool guideCompleted = false;

    await tester.pumpWidget(
      MaterialApp(
        home: AppGuideScreen(
          onCompleteGuide: () {
            guideCompleted = true;
          },
        ),
      ),
    );

    // Initial step 1
    expect(find.text('Uygulama Rehberi'), findsOneWidget);
    expect(find.text('1. Kişiselleştirilmiş Gebelik Takibi'), findsOneWidget);
    expect(find.text('Atla ➔'), findsOneWidget);

    // Test 'Atla ➔' action
    await tester.tap(find.text('Atla ➔'));
    await tester.pumpAndSettle();

    expect(guideCompleted, isTrue);
  });
}
