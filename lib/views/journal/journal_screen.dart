import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/clay_theme.dart';
import '../../controllers/journal_controller.dart';
import 'widgets/journal_entry_card.dart';
import 'widgets/video_renderer_dialog.dart';
import 'new_entry_screen.dart';

/// Aura Journal (Romantik Anı Günlüğü) Ana Ekranı
class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final JournalController _controller = JournalController();

  @override
  void initState() {
    super.initState();
    _controller.loadDiaries();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Aura Journal (Anı Günlüğü)',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        actions: [
          // Time-Lapse Video Üretici Butonu
          IconButton(
            icon: const Icon(Icons.movie_creation_rounded, color: AppColors.primaryPink),
            tooltip: 'Yolculuk Videosu Oluştur',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => VideoRendererDialog(
                  highlightEntries: _controller.highlightEntries,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _controller.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.primaryPink))
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                children: [
                  // Üst Bilgi ve Video Banner
                  ClayCard(
                    color: AppColors.clayLavender,
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: ClayTheme.clayDecoration(
                            color: AppColors.clayRose,
                            borderRadius: 16,
                          ),
                          child: const Center(
                            child: Text('🎬', style: TextStyle(fontSize: 24)),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Time-Lapse Yolculuk Videosu',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                              Text(
                                '${_controller.highlightEntries.length} özel an seçildi • FFmpeg Render',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClayButton(
                          color: AppColors.clayRose,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => VideoRendererDialog(
                                highlightEntries: _controller.highlightEntries,
                              ),
                            );
                          },
                          child: const Text(
                            'Üret',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.primaryDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  const Text(
                    'Zaman Tüneli (Timeline)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Günlük Kartları
                  ..._controller.entries.map(
                    (entry) => JournalEntryCard(
                      entry: entry,
                      onDelete: () => _controller.deleteEntry(entry.id!),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryPink,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => NewEntryScreen(
                currentWeek: _controller.currentWeek,
                onSave: (entry) => _controller.addEntry(entry),
              ),
            ),
          );
        },
        icon: const Icon(Icons.favorite_rounded, color: Colors.white),
        label: const Text(
          'Anı Yaz',
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.2),
        ),
      ),
    );
  }
}
