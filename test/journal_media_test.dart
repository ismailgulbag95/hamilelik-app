import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aura_pregnancy/models/diary_model.dart';
import 'package:aura_pregnancy/views/journal/new_entry_screen.dart';
import 'package:aura_pregnancy/views/journal/widgets/journal_entry_card.dart';
import 'package:aura_pregnancy/views/journal/widgets/clay_audio_player.dart';
import 'package:aura_pregnancy/views/journal/widgets/audio_recording_sheet.dart';
import 'package:aura_pregnancy/services/audio_service.dart';
import 'package:aura_pregnancy/services/media_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeDateFormatting('tr_TR', null);
  });

  group('Aura Journal Fotoğraf ve Ses Kayıt Testleri', () {
    testWidgets('1. NewEntryScreen Fotoğraf Ekleme ve Ses Kaydı Akışı', (WidgetTester tester) async {
      DiaryModel? savedEntry;

      await tester.pumpWidget(
        MaterialApp(
          home: NewEntryScreen(
            currentWeek: 14,
            onSave: (entry) {
              savedEntry = entry;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Yeni Anı Yaz'), findsOneWidget);
      expect(find.text('Fotoğraf Ekle'), findsOneWidget);
      expect(find.text('Ses Kaydet'), findsOneWidget);

      // Fotoğraf Ekle butonuna bas
      await tester.tap(find.text('Fotoğraf Ekle'));
      await tester.pumpAndSettle();

      // Modal Bottom Sheet açılmış olmalı
      expect(find.text('Ultrason Hatıra Fotoğrafı'), findsOneWidget);
      await tester.tap(find.text('Ultrason Hatıra Fotoğrafı'));
      await tester.pumpAndSettle();

      // Fotoğraf eklenmiş olmalı
      expect(find.text('Eklenen Fotoğraf'), findsOneWidget);

      // Not metni gir
      await tester.enterText(find.byType(TextField).first, 'Bebeğimin ultrasonunu gördüm!');

      // Anıyı Kaydet
      await tester.tap(find.text('✨ Anıyı Kaydet'));
      await tester.pumpAndSettle();

      expect(savedEntry, isNotNull);
      expect(savedEntry!.photoPath, equals('assets/images/sample_ultrasound.png'));
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
        MaterialApp(
          home: Scaffold(
            body: JournalEntryCard(entry: entry),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('16. Hafta Anısı'), findsOneWidget);
      expect(find.text('Bebeğime ilk sesli mektubum.'), findsOneWidget);
      expect(find.text('Özel An'), findsOneWidget);
      expect(find.byType(ClayAudioPlayer), findsOneWidget);

      // Oynatıcı butonunu bul ve çalmaya başla
      expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
      await tester.tap(find.byIcon(Icons.play_arrow_rounded));
      await tester.pump();

      // Oynatma durumunu kontrol et
      expect(AudioPlaybackService.instance.isPlaying, isTrue);

      // Durdur
      AudioPlaybackService.instance.stop();
      await tester.pump();
      expect(AudioPlaybackService.instance.isPlaying, isFalse);
    });

    testWidgets('3. AudioRecordingService ve AudioPlaybackService birim işlevleri', (WidgetTester tester) async {
      final recService = AudioRecordingService.instance;
      recService.startRecording();
      expect(recService.isRecording, isTrue);

      final result = await recService.stopRecording();
      expect(result['path'], contains('voice_letter.m4a'));
      expect(recService.isRecording, isFalse);

      final playService = AudioPlaybackService.instance;
      playService.play('assets/audio/voice_letter.m4a', durationSeconds: 20);
      expect(playService.isPlaying, isTrue);
      expect(playService.currentPlayingPath, equals('assets/audio/voice_letter.m4a'));

      playService.pause();
      expect(playService.isPaused, isTrue);

      playService.resume();
      expect(playService.isPaused, isFalse);

      playService.stop();
      expect(playService.isPlaying, isFalse);
    });
  });
}
