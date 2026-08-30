import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';
import '../../../models/medication_model.dart';
import '../../../services/database_helper.dart';
import '../../../utils/date_utils.dart';

/// Claymorphic İlaç & Vitamin Takip Kartı
class MedicationTrackerCard extends StatefulWidget {
  const MedicationTrackerCard({super.key});

  @override
  State<MedicationTrackerCard> createState() => _MedicationTrackerCardState();
}

class _MedicationTrackerCardState extends State<MedicationTrackerCard> {
  List<MedicationModel> _medications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMedications();
    DatabaseHelper.appDataRevision.addListener(_onDataChanged);
  }

  void _onDataChanged() {
    if (mounted) _loadMedications();
  }

  @override
  void dispose() {
    DatabaseHelper.appDataRevision.removeListener(_onDataChanged);
    super.dispose();
  }

  Future<void> _loadMedications() async {
    try {
      final list = await DatabaseHelper.instance.getMedications();
      if (mounted) {
        setState(() {
          _medications = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Load medications error: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleTaken(MedicationModel med) async {
    final today = AppDateUtils.todayIso();
    final isCurrentlyTaken = med.isTakenOnDate(today);
    final nextState = !isCurrentlyTaken;

    await DatabaseHelper.instance.toggleMedicationTaken(med.id!, today, nextState);
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          nextState
              ? '${med.name} alındı olarak işaretlendi.'
              : '${med.name} alımı geri alındı.',
        ),
        backgroundColor: nextState ? AppColors.successGreen : AppColors.secondaryPeach,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openAddMedicationSheet() {
    final nameController = TextEditingController();
    final dosageController = TextEditingController(text: '1 Tablet');
    String selectedTime = 'Sabah Tok';
    String selectedCategory = 'Vitamin';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.medication_rounded, color: AppColors.primaryDark, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Yeni İlaç / Vitamin Ekle',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // İlaç Adı
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'İlaç veya Vitamin Adı',
                      hintText: 'Örn: Folik Asit, Magnezyum, Ferrum',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Dozaj
                  TextField(
                    controller: dosageController,
                    decoration: InputDecoration(
                      labelText: 'Dozaj / Miktar',
                      hintText: 'Örn: 1 Tablet, 400 mcg, 2 Damla',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Öğün / Saat Seçimi
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedTime,
                          decoration: InputDecoration(
                            labelText: 'Kullanım Zamanı',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          ),
                          items: ['Sabah Aç', 'Sabah Tok', 'Öğle', 'Akşam Tok', 'Gece Yatarken']
                              .map((t) => DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(fontSize: 13))))
                              .toList(),
                          onChanged: (val) => setSheetState(() => selectedTime = val ?? selectedTime),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: InputDecoration(
                            labelText: 'Kategori',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          ),
                          items: ['Vitamin', 'Mineral', 'Demir', 'İlaç', 'Takviye']
                              .map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13))))
                              .toList(),
                          onChanged: (val) => setSheetState(() => selectedCategory = val ?? selectedCategory),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ClayButton(
                    color: AppColors.clayMint,
                    onPressed: () async {
                      final name = nameController.text.trim();
                      if (name.isEmpty) return;

                      final newMed = MedicationModel(
                        name: name,
                        dosage: dosageController.text.trim().isNotEmpty ? dosageController.text.trim() : '1 Tablet',
                        time: selectedTime,
                        category: selectedCategory,
                      );

                      await DatabaseHelper.instance.insertMedication(newMed);
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_rounded, color: AppColors.successGreen, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Kaydet ve Listeye Ekle',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.successGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todayIso = AppDateUtils.todayIso();
    final takenCount = _medications.where((m) => m.isTakenOnDate(todayIso)).length;
    final totalCount = _medications.length;

    return ClayCard(
      color: AppColors.clayLavender,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst Başlık ve İlaç Ekle Butonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: ClayTheme.clayDecoration(
                      color: Colors.white,
                      borderRadius: 12,
                    ),
                    child: const Center(
                      child: Icon(Icons.medication_rounded, color: AppColors.lavenderPurple, size: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'İlaç & Vitamin Takibi',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      Text(
                        '$totalCount İlaçtan $takenCount Tanesi Alındı',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ClayButton(
                color: AppColors.clayRose,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                onPressed: _openAddMedicationSheet,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded, size: 16, color: AppColors.primaryPink),
                    SizedBox(width: 2),
                    Text(
                      'İlaç Ekle',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          if (_isLoading)
            const Center(child: Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(color: AppColors.primaryPink)))
          else if (_medications.isEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Text(
                  'Henüz kayıtlı ilaç veya vitamin yok. Yukarıdaki "+ İlaç Ekle" ile ekleyebilirsiniz.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ),
            )
          else
            Column(
              children: _medications.map((med) {
                final isTaken = med.isTakenOnDate(todayIso);

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isTaken ? AppColors.clayMint : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isTaken ? AppColors.successGreen.withOpacity(0.3) : Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Alındı / Alınmadı Checkbox Butonu
                      GestureDetector(
                        onTap: () => _toggleTaken(med),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: ClayTheme.clayDecoration(
                            color: isTaken ? AppColors.successGreen : AppColors.clayCardSurface,
                            borderRadius: 10,
                            isPressed: isTaken,
                          ),
                          child: Center(
                            child: Icon(
                              isTaken ? Icons.check_rounded : Icons.circle_outlined,
                              size: 18,
                              color: isTaken ? Colors.white : AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // İlaç Detayları
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              med.name,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: isTaken ? AppColors.successGreen : AppColors.primaryDark,
                                decoration: isTaken ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${med.dosage} • ${med.time}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Silme Butonu
                      IconButton(
                        icon: const Icon(Icons.close_rounded, size: 16, color: AppColors.textMuted),
                        tooltip: 'Sil',
                        onPressed: () async {
                          await DatabaseHelper.instance.deleteMedication(med.id!);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
