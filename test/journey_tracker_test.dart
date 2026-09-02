import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aura_pregnancy/views/weekly_panel/widgets/pregnancy_journey_tracker.dart';
import 'package:aura_pregnancy/views/weekly_panel/weekly_panel_screen.dart';
import 'package:aura_pregnancy/services/database_helper.dart';
import 'test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeDateFormatting('tr_TR', null);
  });

  setUp(() async {
    await DatabaseHelper.instance.ensureDefaultProfile();
  });

  group('PregnancyJourneyTracker Widget Testleri', () {
    testWidgets('1. PregnancyJourneyTracker tüm 11 aşamayı doğru render eder', (WidgetTester tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const Scaffold(
            body: PregnancyJourneyTracker(
              initialIndex: 2, // Haşhaş Tohumu, Susam, Karabiber
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Bebeğinin Büyüme Serüveni'), findsOneWidget);
      expect(find.text('Haşhaş Tohumu Tomurcuğu'), findsOneWidget);
      expect(find.text('Susam Tanesi'), findsOneWidget);
      expect(find.text('Karabiber Tanesi'), findsOneWidget);
    });

    testWidgets('2. WeeklyPanelScreen içerisinde PregnancyJourneyTracker görüntülenir', (WidgetTester tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const WeeklyPanelScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PregnancyJourneyTracker), findsOneWidget);
      expect(find.text('Bebeğinin Büyüme Serüveni'), findsOneWidget);
    });
  });
}
