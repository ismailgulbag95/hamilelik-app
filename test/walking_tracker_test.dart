import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aura_pregnancy/views/daily_tracker/daily_tracker_screen.dart';
import 'package:aura_pregnancy/views/daily_tracker/widgets/walking_tracker_card.dart';
import 'package:aura_pregnancy/views/dashboard/dashboard_screen.dart';
import 'package:aura_pregnancy/controllers/daily_tracker_controller.dart';
import 'package:aura_pregnancy/services/database_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeDateFormatting('tr_TR', null);
  });

  setUp(() async {
    await DatabaseHelper.instance.ensureDefaultProfile();
  });

  group('Yürüyüş ve Adım Takibi Testleri', () {
    testWidgets('1. WalkingTrackerCard adım, mesafe, kalori ve butonları doğru gösterir', (WidgetTester tester) async {
      int addedSteps = 0;
      int addedMinutes = 0;
      bool resetCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
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

      expect(find.text('Günlük Yürüyüş & Adım'), findsOneWidget);
      expect(find.text('3000'), findsOneWidget);
      expect(find.text('2.10 km'), findsOneWidget); // 3000 * 0.0007 = 2.1 km
      expect(find.text('120 kcal'), findsOneWidget); // 3000 * 0.04 = 120 kcal
      expect(find.text('20 dk'), findsOneWidget);

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
        const MaterialApp(
          home: DailyTrackerScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(WalkingTrackerCard), findsOneWidget);
      expect(find.text('Günlük Yürüyüş & Adım'), findsOneWidget);

      // +1000 Adım ekle
      await tester.tap(find.text('+1.000'));
      await tester.pumpAndSettle();

      expect(find.text('1000'), findsOneWidget);
    });

    testWidgets('3. DashboardScreen üzerinde hızlı yürüyüş butonları çalışır', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardScreen(onNavigateTab: (_) {}),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Yürüyüş & Adım'), findsOneWidget);
      expect(find.text('+500'), findsOneWidget);
      expect(find.text('+1000'), findsOneWidget);

      // +500 butonuna bas
      await tester.tap(find.text('+500'));
      await tester.pumpAndSettle();

      expect(find.text('500 / 6000 Adım'), findsOneWidget);
    });
  });
}
