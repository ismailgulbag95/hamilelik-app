import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aura_pregnancy/models/diary_model.dart';
import 'package:aura_pregnancy/views/journal/new_entry_screen.dart';
import 'package:aura_pregnancy/views/journal/widgets/journal_entry_card.dart';
import 'package:aura_pregnancy/views/journal/widgets/clay_audio_player.dart';
import 'package:aura_pregnancy/services/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeDateFormatting('tr_TR', null);
  });

  group('Aura Journal Fotoğraf ve Ses Kayıt Testleri', () {
    testWidgets('1. NewEntryScreen Fotoğraf Ekleme ve Ses Kaydı Arayüzü', (WidgetTester tester) async {
      DiaryModel? savedEntry;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: NewEntryScreen(
            currentWeek: 14,
            onSave: (entry) {
              savedEntry = entry;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('journal_new_entry_title'.tr()), findsOneWidget);
      expect(find.text('journal_add_photo'.tr()), findsOneWidget);
      expect(find.text('journal_record_audio'.tr()), findsOneWidget);

      // Not metni gir
      await tester.enterText(find.byType(TextField).first, 'Bebeğimin ultrasonunu gördüm!');

      // Anıyı Kaydet
      final saveFinder = find.text('journal_save_entry'.tr());
      await tester.ensureVisible(saveFinder);
      await tester.tap(saveFinder);
      await tester.pumpAndSettle();

      expect(savedEntry, isNotNull);
      expect(savedEntry!.noteText, equals('Bebeğimin ultrasonunu gördüm!'));
    });

    testWidgets('2. JournalEntryCard Fotoğraf ve Ses Oynatıcıyı Gösterir ve Çalıştırır', (WidgetTester tester) async {
      final entry = DiaryModel(
        pregnancyWeek: 16,
        date: '2026-08-29',
        noteText: 'Bebeğime ilk sesli mektubum.',
        photoPath: 'assets/images/sample_ultrasound.png',
        audioPath: 'assets/audio/voice_letter.m4a',
        moodRating: 5,
        isRomanticHighlight: true,
      );

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Scaffold(
            body: SingleChildScrollView(
              child: JournalEntryCard(entry: entry),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('journal_week_entry_title'.tr(args: ['16'])), findsOneWidget);
      expect(find.text('Bebeğime ilk sesli mektubum.'), findsOneWidget);
      expect(find.text('journal_highlight_badge'.tr()), findsOneWidget);
      expect(find.byType(ClayAudioPlayer), findsOneWidget);

      // Oynatıcı butonunu bul
      expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
      await tester.tap(find.byIcon(Icons.play_arrow_rounded));
      await tester.pump();
    });

    testWidgets('3. AudioRecordingService ve AudioPlaybackService zaman ve durum formatlama fonksiyonları', (WidgetTester tester) async {
      final recService = AudioRecordingService.instance;
      expect(recService.formattedDuration, equals('00:00'));

      final playService = AudioPlaybackService.instance;
      expect(playService.formatTime(95), equals('01:35'));
      expect(playService.formatTime(0), equals('00:00'));
      expect(playService.progressRatio, equals(0.0));
    });
  });
}
