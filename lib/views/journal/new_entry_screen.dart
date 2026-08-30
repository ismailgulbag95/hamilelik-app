import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/clay_theme.dart';
import '../../models/diary_model.dart';
import '../../utils/date_utils.dart';
import '../../services/media_service.dart';
import 'widgets/mood_selector_widget.dart';
import 'widgets/audio_recording_sheet.dart';
import 'widgets/clay_audio_player.dart';
import 'widgets/photo_view_dialog.dart';

/// Yeni Romantik Günlük & Anı Ekleme Ekranı
class NewEntryScreen extends StatefulWidget {
  final int currentWeek;
  final Function(DiaryModel) onSave;

  const NewEntryScreen({
    super.key,
    required this.currentWeek,
    required this.onSave,
  });

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final TextEditingController _noteController = TextEditingController();
  late int _selectedWeek;
  late DateTime _selectedDate;
  int _selectedMood = 5;
  bool _isRomanticHighlight = true;
  String? _photoPath;
  String? _audioPath;
  int _audioDurationSeconds = 30;

  @override
  void initState() {
    super.initState();
    _selectedWeek = widget.currentWeek;
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryPink,
              onPrimary: Colors.white,
              onSurface: AppColors.primaryDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickPhoto() async {
    final selected = await MediaService.instance.showPhotoPickerDialog(context);
    if (selected != null && mounted) {
      setState(() {
        _photoPath = selected;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fotoğraf başarıyla eklendi.'),
          backgroundColor: AppColors.successGreen,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _recordAudio() async {
    final result = await AudioRecordingSheet.show(context);
    if (result != null && mounted) {
      setState(() {
        _audioPath = result['path'] as String?;
        _audioDurationSeconds = (result['duration_sec'] as int?) ?? 30;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sesli mektup kaydı başarıyla alındı.'),
          backgroundColor: AppColors.successGreen,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = AppDateUtils.toIso(_selectedDate);
    final dateDisplayStr = AppDateUtils.formatDisplay(dateStr);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Yeni Anı Yaz',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hafta & Tarih Seçici Kartı
              ClayCard(
                color: AppColors.clayRose,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: _selectedWeek,
                              isDense: true,
                              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryPink, size: 20),
                              items: List.generate(40, (index) => index + 1).map((w) {
                                return DropdownMenuItem<int>(
                                  value: w,
                                  child: Text(
                                    '$w. Hafta',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _selectedWeek = val);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.primaryPink),
                            const SizedBox(width: 6),
                            Text(
                              dateDisplayStr,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primaryDark),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Mood Seçici
              ClayCard(
                color: AppColors.clayCardSurface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bugünkü Ruh Haliniz:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    MoodSelectorWidget(
                      selectedMood: _selectedMood,
                      onMoodSelected: (m) => setState(() => _selectedMood = m),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Not Metin Alanı
              ClayCard(
                color: AppColors.clayCardSurface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bebeğinize Mektup / Günlük Notu:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            offset: const Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(14),
                      child: TextField(
                        controller: _noteController,
                        maxLines: 5,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: const InputDecoration(
                          hintText: 'Bugün hissettiğiniz duyguları, kalp atışlarını veya bebeğinize söylemek istediklerinizi yazın...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Fotoğraf Alanı
              if (_photoPath != null) ...[
                ClayCard(
                  color: AppColors.clayCardSurface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.photo_camera_rounded, size: 18, color: AppColors.primaryPink),
                              SizedBox(width: 6),
                              Text(
                                'Eklenen Fotoğraf',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_rounded, size: 20, color: AppColors.primaryPink),
                                onPressed: _pickPhoto,
                                tooltip: 'Fotoğrafı Değiştir',
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.medicalAlertRed),
                                onPressed: () => setState(() => _photoPath = null),
                                tooltip: 'Kaldır',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => PhotoViewDialog.show(context, _photoPath!, title: '$_selectedWeek. Hafta Fotoğrafı'),
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              MediaService.buildPhotoWidget(
                                _photoPath!,
                                width: double.infinity,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.zoom_in_rounded, color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text('Büyüt', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Ses Kaydı Alanı
              if (_audioPath != null) ...[
                ClayCard(
                  color: AppColors.clayCardSurface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.mic_rounded, size: 18, color: AppColors.primaryPink),
                              SizedBox(width: 6),
                              Text(
                                'Eklenen Ses Kaydı (Dinle)',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.mic_rounded, size: 20, color: AppColors.primaryPink),
                                onPressed: _recordAudio,
                                tooltip: 'Yeniden Kaydet',
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.medicalAlertRed),
                                onPressed: () => setState(() => _audioPath = null),
                                tooltip: 'Kaldır',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClayAudioPlayer(
                        audioPath: _audioPath!,
                        title: 'Bebeğime Sesli Mektup ($_selectedWeek. Hafta)',
                        durationSeconds: _audioDurationSeconds,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Medya Ekleme Butonları
              Row(
                children: [
                  Expanded(
                    child: ClayButton(
                      color: _photoPath != null ? AppColors.clayMint : AppColors.clayPeach,
                      onPressed: _pickPhoto,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _photoPath != null ? Icons.check_circle_rounded : Icons.add_a_photo_rounded,
                            size: 18,
                            color: _photoPath != null ? AppColors.successGreen : AppColors.secondaryPeach,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _photoPath != null ? 'Fotoğraf Seçildi' : 'Fotoğraf Ekle',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                              color: _photoPath != null ? AppColors.successGreen : AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ClayButton(
                      color: _audioPath != null ? AppColors.clayMint : AppColors.clayLavender,
                      onPressed: _recordAudio,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _audioPath != null ? Icons.check_circle_rounded : Icons.mic_rounded,
                            size: 18,
                            color: _audioPath != null ? AppColors.successGreen : AppColors.primaryPink,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _audioPath != null ? 'Ses Kaydedildi' : 'Ses Kaydet',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                              color: _audioPath != null ? AppColors.successGreen : AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Özel An Seçimi
              ClayCard(
                color: AppColors.clayRose,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star_rounded, size: 16, color: AppColors.primaryPink),
                              SizedBox(width: 4),
                              Text('Özel An Olarak İşaretle', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                            ],
                          ),
                          Text('Time-lapse Yolculuk Videosuna dahil edilir.', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    Switch(
                      value: _isRomanticHighlight,
                      activeColor: AppColors.primaryPink,
                      onChanged: (val) => setState(() => _isRomanticHighlight = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Kaydet Butonu
              ClayButton(
                color: AppColors.clayMint,
                height: 54,
                onPressed: () {
                  final text = _noteController.text.trim();
                  final noteText = text.isNotEmpty ? text : 'Bebeğimle huzur ve sevgi dolu bir gün geçirdik.';
                  final entry = DiaryModel(
                    pregnancyWeek: _selectedWeek,
                    date: dateStr,
                    noteText: noteText,
                    photoPath: _photoPath,
                    audioPath: _audioPath,
                    moodRating: _selectedMood,
                    isRomanticHighlight: _isRomanticHighlight,
                  );

                  widget.onSave(entry);
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_rounded, color: AppColors.successGreen, size: 20),
                    SizedBox(width: 6),
                    Text(
                      'Anıyı Kaydet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.successGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
