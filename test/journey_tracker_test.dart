import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aura_pregnancy/views/weekly_panel/widgets/pregnancy_journey_tracker.dart';
import 'package:aura_pregnancy/views/weekly_panel/weekly_panel_screen.dart';
import 'package:aura_pregnancy/services/database_helper.dart';

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
        const MaterialApp(
          home: Scaffold(
            body: PregnancyJourneyTracker(
              initialIndex: 0, // Haşhaş Tohumu
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Bebeğinin Büyüme Serüveni'), findsOneWidget);
      expect(find.text('Haşhaş Tohumu'), findsOneWidget);
      expect(find.text('Yaban Mersini'), findsOneWidget);
      expect(find.text('Yaşamın Tohumu'), findsOneWidget);
    });

    testWidgets('2. WeeklyPanelScreen içerisinde PregnancyJourneyTracker görüntülenir', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WeeklyPanelScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PregnancyJourneyTracker), findsOneWidget);
      expect(find.text('Bebeğinin Büyüme Serüveni'), findsOneWidget);
    });
  });
}
