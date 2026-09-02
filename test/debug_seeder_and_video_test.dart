import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aura_pregnancy/services/database_helper.dart';
import 'package:aura_pregnancy/services/debug_seeder_service.dart';
import 'package:aura_pregnancy/services/video_story_generator_service.dart';
import 'package:aura_pregnancy/views/debug/widgets/debug_panel_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeDateFormatting('tr_TR', null);
  });

  setUp(() async {
    await DatabaseHelper.instance.ensureDefaultProfile();
  });

  group('Debug Seeder ve Time-lapse Video Motoru Testleri', () {
    test('1. 40 Haftalık Test Verisi Doldurma (Seeding) ve Görünürlük Kontrolü', () async {
      // 40 haftalık veriyi doldur
      final result = await DebugSeederService.instance.seedFullPregnancyData();
      expect(result['logs'], greaterThanOrEqualTo(40));
      expect(result['diaries'], greaterThanOrEqualTo(10));

      // Veritabanı istatistiklerini kontrol et
      final stats = await DebugSeederService.instance.getDatabaseStats();
      expect(stats['totalLogs'], greaterThanOrEqualTo(40));
      expect(stats['totalDiaries'], greaterThanOrEqualTo(10));
      expect(stats['totalPhotos'], greaterThan(0));
      expect(stats['totalAudios'], greaterThan(0));
      expect(stats['totalSteps'], greaterThan(100000));
      expect(stats['totalWaterMl'], greaterThan(50000));

      // Tüm kayıtların veritabanından başarıyla okunabildiğini doğrula
      final allLogs = await DatabaseHelper.instance.getAllDailyLogs();
      final allDiaries = await DatabaseHelper.instance.getAllDiaries();
      expect(allLogs.length, equals(stats['totalLogs']));
      expect(allDiaries.length, equals(stats['totalDiaries']));
    });

    test('2. Time-lapse Video Hikaye Motoru Kareleri Üretir', () async {
      final frames = await VideoStoryGeneratorService.instance.generateStoryFrames();
      expect(frames, isNotEmpty);
      expect(frames.first.photoPath, isNotEmpty);
      expect(frames.first.title, contains('Hafta'));
    });

    test('3. Hızlı Hafta Atlama ve DB Sıfırlama Çalışır', () async {
      // 32. Haftaya atla
      await DebugSeederService.instance.jumpToWeek(32);
      var profile = await DatabaseHelper.instance.getProfile();
      expect(profile?.currentWeek, equals(32));

      // Veritabanını sıfırla
      await DebugSeederService.instance.resetAllDatabase();
      final statsAfterReset = await DebugSeederService.instance.getDatabaseStats();
      expect(statsAfterReset['totalLogs'], equals(0));
      expect(statsAfterReset['totalDiaries'], equals(0));
    });

    testWidgets('4. DebugPanelBottomSheet arayüzü ve butonları doğru render eder', (WidgetTester tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Scaffold(
            body: DebugPanelBottomSheet(onDataChanged: () {}),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('debug_title'.tr()), findsOneWidget);
      expect(find.text('debug_seed_btn'.tr()), findsOneWidget);
      expect(find.text('debug_timelapse_btn'.tr()), findsOneWidget);
      expect(find.text('debug_reset_btn'.tr()), findsOneWidget);
    });
  });
}
