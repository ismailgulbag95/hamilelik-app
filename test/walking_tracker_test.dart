import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aura_pregnancy/views/daily_tracker/daily_tracker_screen.dart';
import 'package:aura_pregnancy/views/daily_tracker/widgets/walking_tracker_card.dart';
import 'package:aura_pregnancy/services/database_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await DatabaseHelper.instance.ensureDefaultProfile();
  });

  group('Yürüyüş ve Adım Takibi Testleri', () {
    testWidgets('1. WalkingTrackerCard adım, mesafe, kalori ve butonları doğru gösterir', (WidgetTester tester) async {
      int addedSteps = 0;
      int addedMinutes = 0;
      bool resetCalled = false;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Scaffold(
            body: WalkingTrackerCard(
              stepCount: 3000,
              walkingMinutes: 20,
              currentWeek: 16,
              onAddSteps: (steps, {minutes = 0}) {
                addedSteps += steps;
                addedMinutes += minutes;
              },
              onReset: () {
                resetCalled = true;
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('walking_title'.tr()), findsOneWidget);
      expect(find.text('3000'), findsOneWidget);
      expect(find.text('2.10 km'), findsOneWidget); // 3000 * 0.0007 = 2.1 km
      expect(find.text('120 kcal'), findsOneWidget); // 3000 * 0.04 = 120 kcal
      expect(find.text('20 Dk'), findsOneWidget);

      // +500 butonuna bas
      await tester.tap(find.text('+500'));
      await tester.pump();
      expect(addedSteps, equals(500));
      expect(addedMinutes, equals(4));

      // Sıfırla butonuna bas
      await tester.tap(find.byIcon(Icons.refresh_rounded));
      await tester.pump();
      expect(resetCalled, isTrue);
    });

    testWidgets('2. DailyTrackerScreen içerisinde Yürüyüş Takibi çalışır', (WidgetTester tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const DailyTrackerScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(WalkingTrackerCard), findsOneWidget);
      expect(find.text('walking_title'.tr()), findsOneWidget);

      // +1000 Adım ekle
      final add1000Finder = find.text('+1.000');
      if (add1000Finder.evaluate().isNotEmpty) {
        await tester.ensureVisible(add1000Finder);
        await tester.tap(add1000Finder);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('3. WalkingTrackerCard Süre Moduna geçer ve süre ekleme butonları çalışır', (WidgetTester tester) async {
      int addedSteps = 0;
      int addedMinutes = 0;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Scaffold(
            body: WalkingTrackerCard(
              stepCount: 1000,
              walkingMinutes: 10,
              currentWeek: 16,
              onAddSteps: (steps, {minutes = 0}) {
                addedSteps += steps;
                addedMinutes += minutes;
              },
              onReset: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Süre Modu sekmesine tıkla
      final durationTab = find.text('walking_tab_duration'.tr());
      expect(durationTab, findsOneWidget);
      await tester.tap(durationTab);
      await tester.pumpAndSettle();

      // +15 Dk butonuna bas
      final add15Min = find.text('+15 Dk');
      expect(add15Min, findsOneWidget);
      await tester.tap(add15Min);
      await tester.pump();

      expect(addedMinutes, equals(15));
      expect(addedSteps, equals(1800));
    });
  });
}
