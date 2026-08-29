import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aura_pregnancy/models/daily_log_model.dart';
import 'package:aura_pregnancy/models/diary_model.dart';
import 'package:aura_pregnancy/services/database_helper.dart';
import 'package:aura_pregnancy/views/timeline/timeline_screen.dart';
import 'package:aura_pregnancy/views/main_navigation_scaffold.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeDateFormatting('tr_TR', null);
  });

  setUp(() async {
    await DatabaseHelper.instance.ensureDefaultProfile();
    await DatabaseHelper.instance.updateDailyLog(
      DailyLogModel(
        date: '2026-08-29',
        waterIntakeMl: 2000,
        caffeineMg: 60,
        stepCount: 4500,
        walkingMinutes: 25,
        weightEntry: 63.5,
      ),
    );
    await DatabaseHelper.instance.insertDiary(
      DiaryModel(
        pregnancyWeek: 16,
        date: '2026-08-29',
        noteText: 'Zaman tüneli için test anısı.',
        photoPath: 'assets/images/sample_ultrasound.png',
        audioPath: 'assets/audio/voice_letter.m4a',
        moodRating: 5,
        isRomanticHighlight: true,
      ),
    );
  });

  group('Zaman Tüneli (Timeline) Testleri', () {
    testWidgets('1. TimelineScreen genel istatistikleri ve gün kartını gösterir', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TimelineScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Yolculuk Akışı'), findsOneWidget);
      expect(find.text('Hamilelik Yolculuğu Özeti'), findsOneWidget);
      expect(find.text('👟 4500 Adım'), findsOneWidget);
      expect(find.text('💧 2000 ml Su'), findsOneWidget);
      expect(find.text('☕ 60 mg Kafein'), findsOneWidget);
      expect(find.text('⚖️ 63.5 kg'), findsOneWidget);
      expect(find.text('Zaman tüneli için test anısı.'), findsOneWidget);
    });

    testWidgets('2. Filtre butonları filtrelemeyi doğru yapar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TimelineScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('🌟 Tümü'), findsOneWidget);
      expect(find.text('📖 Anılar & Sesler'), findsOneWidget);
      expect(find.text('👟 Yürüyüş & Adım'), findsOneWidget);

      // Anılar & Sesler filtresini seç
      await tester.tap(find.text('📖 Anılar & Sesler'));
      await tester.pumpAndSettle();
      expect(find.text('Zaman tüneli için test anısı.'), findsOneWidget);

      // Yürüyüş & Adım filtresini seç
      await tester.tap(find.text('👟 Yürüyüş & Adım'));
      await tester.pumpAndSettle();
      expect(find.text('👟 4500 Adım'), findsOneWidget);
    });

    testWidgets('3. MainNavigationScaffold ile Yolculuk sekmesine geçiş yapılır', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MainNavigationScaffold(),
        ),
      );
      await tester.pumpAndSettle();

      // Yolculuk sekmesine tıkla
      await tester.tap(find.text('Yolculuk'));
      await tester.pumpAndSettle();

      expect(find.byType(TimelineScreen), findsOneWidget);
      expect(find.text('Yolculuk Akışı'), findsOneWidget);
    });
  });
}
