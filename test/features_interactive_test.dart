import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aura_pregnancy/views/main_navigation_scaffold.dart';
import 'package:aura_pregnancy/views/dashboard/dashboard_screen.dart';
import 'package:aura_pregnancy/views/daily_tracker/daily_tracker_screen.dart';
import 'package:aura_pregnancy/views/journal/journal_screen.dart';
import 'package:aura_pregnancy/views/journal/new_entry_screen.dart';
import 'package:aura_pregnancy/views/weekly_panel/weekly_panel_screen.dart';
import 'package:aura_pregnancy/views/emergency/emergency_screen.dart';
import 'package:aura_pregnancy/services/database_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeDateFormatting('tr_TR', null);
  });

  setUp(() async {
    await DatabaseHelper.instance.ensureDefaultProfile();
  });

  group('Aura Pregnancy - Butonlar, Fonksiyonlar ve UI Etkileşim Testleri', () {
    testWidgets('1. Ana sayfada Su (+250ml, +500ml) ve Kafein (+60mg, +40mg) butonları sorunsuz çalışır', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DashboardScreen(onNavigateTab: (_) {}),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Bugünkü Takipleriniz'), findsOneWidget);
      expect(find.text('+250 ml'), findsOneWidget);
      expect(find.text('+500 ml'), findsOneWidget);
      expect(find.text('+60 mg'), findsOneWidget);
      expect(find.text('+40 mg'), findsOneWidget);

      // Su Ekle (+250 ml)
      await tester.tap(find.text('+250 ml'));
      await tester.pumpAndSettle();
      expect(find.text('250 / 2500 ml'), findsOneWidget);

      // Kafein Ekle (+60 mg)
      await tester.tap(find.text('+60 mg'));
      await tester.pumpAndSettle();
      expect(find.text('60 / 200 mg'), findsOneWidget);
    });

    testWidgets('2. Takip sekmesi hatasız açılır ve su/kafein işlemleri yapılır', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DailyTrackerScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Günlük Takip & Beslenme'), findsOneWidget);
      expect(find.text('Su Tüketimi'), findsOneWidget);
      expect(find.text('Kafein Takibi'), findsOneWidget);
      expect(find.text('Türk Kahvesi'), findsOneWidget);

      // Su ekle
      await tester.tap(find.text('+250 ml'));
      await tester.pumpAndSettle();

      // Kafein ekle
      await tester.tap(find.text('Türk Kahvesi'));
      await tester.pumpAndSettle();
    });

    testWidgets('3. Anı Yaz butonuna basılınca NewEntryScreen açılır ve anı kaydedilir', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: JournalScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Aura Journal (Anı Günlüğü)'), findsOneWidget);
      expect(find.text('Anı Yaz'), findsOneWidget);

      // Anı Yaz butonuna tıkla
      await tester.tap(find.text('Anı Yaz'));
      await tester.pumpAndSettle();

      // NewEntryScreen açılmış olmalı
      expect(find.text('Yeni Anı Yaz'), findsOneWidget);
      expect(find.text('✨ Anıyı Kaydet'), findsOneWidget);

      // Anı Metni gir ve kaydet
      await tester.enterText(find.byType(TextField), 'Test Anı Notu: Bugün harika bir gündü.');
      await tester.tap(find.text('✨ Anıyı Kaydet'));
      await tester.pumpAndSettle();

      // Tekrar Journal ekranına dönmüş ve not kaydedilmiş olmalı
      expect(find.text('Aura Journal (Anı Günlüğü)'), findsOneWidget);
    });

    testWidgets('4. MainNavigationScaffold 5 sekme arasında hatasız geçiş yapar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MainNavigationScaffold(),
        ),
      );
      await tester.pumpAndSettle();

      // 0: Ana Sayfa
      expect(find.text('Aura Pregnancy'), findsOneWidget);

      // 1: Haftalık
      await tester.tap(find.text('Haftalık'));
      await tester.pumpAndSettle();
      expect(find.byType(WeeklyPanelScreen), findsOneWidget);

      // 2: Takip
      await tester.tap(find.text('Takip'));
      await tester.pumpAndSettle();
      expect(find.byType(DailyTrackerScreen), findsOneWidget);

      // 3: Günlük
      await tester.tap(find.text('Günlük'));
      await tester.pumpAndSettle();
      expect(find.byType(JournalScreen), findsOneWidget);

      // 4: Acil
      await tester.tap(find.text('Acil'));
      await tester.pumpAndSettle();
      expect(find.byType(EmergencyScreen), findsOneWidget);
    });
  });
}
