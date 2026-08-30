import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/fruit_3d_widget.dart';
import 'ad_reward_dialog.dart';

/// Gebelik Gelişim Aşaması Bilgi Modeli
class JourneyStageData {
  final String title;
  final String fruitComparison;
  final String weekRange;
  final String sizeInfo;
  final String description;
  final IconData icon;
  final Color themeColor;

  const JourneyStageData({
    required this.title,
    required this.fruitComparison,
    required this.weekRange,
    required this.sizeInfo,
    required this.description,
    required this.icon,
    required this.themeColor,
  });
}

/// Dribbble Aesthetic - Claymorphism 3D Fetal Journey Tracker
/// Evre butonları tıklanamaz (serüven göstergesi); daima mevcut haftanın evre bilgisini sunar.
class PregnancyJourneyTracker extends StatefulWidget {
  final int currentWeek;
  final int initialIndex;

  const PregnancyJourneyTracker({
    super.key,
    this.currentWeek = 12,
    this.initialIndex = 3,
  });

  @override
  State<PregnancyJourneyTracker> createState() => _PregnancyJourneyTrackerState();
}

class _PregnancyJourneyTrackerState extends State<PregnancyJourneyTracker> {
  late int _maxUnlockedIndex;
  late ScrollController _scrollController;

  static const List<JourneyStageData> stages = [
    JourneyStageData(
      title: 'Yaşamın Tohumu',
      fruitComparison: 'Haşhaş Tohumu',
      weekRange: '4 - 5. Hafta',
      sizeInfo: '~1.5 mm • < 1 gr',
      description: 'Mucizevi yolculuğun başlangıcı! Döllenmiş minik hücre rahme güvenle tutundu ve ilk kalp tüpü şekillenmeye başladı.',
      icon: Icons.spa_rounded,
      themeColor: Color(0xFF4E8D55),
    ),
    JourneyStageData(
      title: 'İlk Kalp Pırıltısı',
      fruitComparison: 'Yaban Mersini',
      weekRange: '6 - 8. Hafta',
      sizeInfo: '~1.5 cm • ~1.5 gr',
      description: 'Minik kalbi dakikada 160 kez atıyor! Göz ve kulak kabarcıkları beliriyor, el ve ayak tomurcukları hızla uzuyor.',
      icon: Icons.bubble_chart_rounded,
      themeColor: Color(0xFF5C6BC0),
    ),
    JourneyStageData(
      title: 'Minik Parmaklar',
      fruitComparison: 'Çilek / Zeytin',
      weekRange: '9 - 10. Hafta',
      sizeInfo: '~3.2 cm • ~5 gr',
      description: 'Artık bir embriyo değil, resmi olarak bir fetüs! Parmaklarındaki perdeler eriyor, dirsek ve diz eklemleri bükülüyor.',
      icon: Icons.eco_rounded,
      themeColor: Color(0xFFE57373),
    ),
    JourneyStageData(
      title: 'İlk Trimester Zaferi',
      fruitComparison: 'Limon / İncir',
      weekRange: '11 - 13. Hafta',
      sizeInfo: '~7.5 cm • ~25 gr',
      description: 'Kritik organ oluşumu tamamlandı! Minik tırnaklar çıkıyor, yutkunma refleksleri başlıyor ve ultrasonda taklalar atıyor.',
      icon: Icons.wb_sunny_rounded,
      themeColor: Color(0xFFFBC02D),
    ),
    JourneyStageData(
      title: 'Kıvrık Fetüs & Mimikler',
      fruitComparison: 'Avokado',
      weekRange: '14 - 16. Hafta',
      sizeInfo: '~12 cm • ~100 gr',
      description: 'Kaşlarını çatabiliyor, gülümseyebiliyor ve sesinizi duyabiliyor! İncecik ipeksi lanugo tüyleri cildini korumaya başladı.',
      icon: Icons.nature_rounded,
      themeColor: Color(0xFF689F38),
    ),
    JourneyStageData(
      title: 'İlk Tekmeler & Merhaba',
      fruitComparison: 'Muz / Mango',
      weekRange: '17 - 20. Hafta',
      sizeInfo: '~25 cm • ~300 gr',
      description: 'Yolun yarısı! Bebeğiniz başparmağını emiyor ve annesine ilk kıpırtılarıyla "Buradayım!" diye hafif tekmeler atıyor.',
      icon: Icons.motion_photos_on_rounded,
      themeColor: Color(0xFFFFA000),
    ),
    JourneyStageData(
      title: 'Göz Kırpma & Tat Alma',
      fruitComparison: 'Patlıcan / Mısır',
      weekRange: '21 - 24. Hafta',
      sizeInfo: '~30 cm • ~600 gr',
      description: 'Tat alma duyusu gelişti; yediğiniz tatlıların lezzetini alabiliyor! Göz kapakları açılıp kapanıyor ve ritmik hıçkırıklar başlıyor.',
      icon: Icons.grass_rounded,
      themeColor: Color(0xFF7B1FA2),
    ),
    JourneyStageData(
      title: 'Büyüyen Akciğerler',
      fruitComparison: 'Hindistan Cevizi',
      weekRange: '25 - 27. Hafta',
      sizeInfo: '~36 cm • ~1.0 kg',
      description: '2. Trimester bitti! Akciğerlerinde nefes almayı sağlayan sürfaktan maddesi üretiliyor, babasının sesine tepki verip tekmeliyor.',
      icon: Icons.air_rounded,
      themeColor: Color(0xFF8D6E63),
    ),
    JourneyStageData(
      title: 'Rüyalar & REM Uykusu',
      fruitComparison: 'Ananas / Lahana',
      weekRange: '28 - 32. Hafta',
      sizeInfo: '~42 cm • ~1.8 kg',
      description: '3. Trimesterdayız! Beyin dalgaları artık rüya gördüğünü gösteriyor. Kemikleri güçleniyor ve göz bebekleri ışığa tepki veriyor.',
      icon: Icons.bedtime_rounded,
      themeColor: Color(0xFFFFB300),
    ),
    JourneyStageData(
      title: 'Doğum Pozisyonu & Güç',
      fruitComparison: 'Kavun / Kereviz',
      weekRange: '33 - 36. Hafta',
      sizeInfo: '~47 cm • ~2.7 kg',
      description: 'Bebeğiniz doğum için baş aşağı pozisyonunu alıyor. Cilt altı yağ dokusu doluyor, anneden gelen koruyucu antikorlarla güçleniyor.',
      icon: Icons.shield_rounded,
      themeColor: Color(0xFF43A047),
    ),
    JourneyStageData(
      title: 'Kollara Hazır Melek',
      fruitComparison: 'Balkabağı / Bebek',
      weekRange: '37 - 40. Hafta',
      sizeInfo: '~51 cm • ~3.4 kg',
      description: 'Tüm hazırlıklar tamamlandı! Dünyaya gözlerini açıp annenizin ve babanızın sıcak kucağına gelmek için sabırsızlanıyor.',
      icon: Icons.face_retouching_natural_rounded,
      themeColor: Color(0xFFE91E63),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _maxUnlockedIndex = widget.initialIndex.clamp(0, stages.length - 1);
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToActive());
  }

  void _scrollToActive() {
    if (_scrollController.hasClients) {
      final activeIndex = widget.initialIndex.clamp(0, stages.length - 1);
      final targetOffset = (activeIndex * 84.0) - 60.0;
      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void didUpdateWidget(covariant PregnancyJourneyTracker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      if (widget.initialIndex > _maxUnlockedIndex) {
        setState(() {
          _maxUnlockedIndex = widget.initialIndex.clamp(0, stages.length - 1);
        });
      }
      _scrollToActive();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openMysteryStageAd() {
    final nextIndex = _maxUnlockedIndex + 1;
    if (nextIndex >= stages.length) return;

    final nextStage = stages[nextIndex];

    AdRewardDialog.show(
      context: context,
      title: 'Sonraki Meyve Boyutunu Keşfet',
      subtitle: '${nextStage.weekRange} için bebeğinizin meyve boyut benzerliğini ve gelişim özelliklerini öğrenmek için kısa bir video izleyin.',
      unlockTargetName: '${nextStage.weekRange} Boyut Keşfi',
      onRewardEarned: () {
        setState(() {
          _maxUnlockedIndex = nextIndex;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToActive());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = widget.initialIndex.clamp(0, stages.length - 1);
    final activeStage = stages[activeIndex];
    final hasMysteryBox = _maxUnlockedIndex < stages.length - 1;
    final displayItemCount = (_maxUnlockedIndex + 1) + (hasMysteryBox ? 1 : 0);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF7F4),
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9E7B83).withOpacity(0.08),
            offset: const Offset(0, 16),
            blurRadius: 36,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Üst Başlık & Hafta Aralığı Rozeti
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bebeğinin Büyüme Serüveni',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2D232E),
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Meyve & Boyut Karşılaştırmaları (${activeIndex + 1}/${stages.length})',
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF7A6E78),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4EBD6),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4E8D55).withOpacity(0.18),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(activeStage.icon, size: 14, color: const Color(0xFF2E6135)),
                      const SizedBox(width: 4),
                      Text(
                        activeStage.weekRange,
                        style: GoogleFonts.nunito(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2E6135),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Yatay 3D Meyve Serüveni Şeridi (Tıklanamaz - Sadece İzleme & Soru İşareti Reklam Kutusu)
          SizedBox(
            height: 124,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Arka plandaki bağlantı şeridi
                Positioned(
                  top: 36,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8D7DC).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Liste
                ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: displayItemCount,
                  itemBuilder: (context, index) {
                    // Eğer son index ve gizem kutusu ise
                    if (hasMysteryBox && index == displayItemCount - 1) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: _openMysteryStageAd,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 3D Soru İşareti Küresi (Mystery Clay Box)
                              Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFC48B4B).withOpacity(0.24),
                                      offset: const Offset(0, 8),
                                      blurRadius: 16,
                                    ),
                                  ],
                                  border: Border.all(
                                    color: const Color(0xFFE0A96D),
                                    width: 1.5,
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withOpacity(0.80),
                                      const Color(0xFFF9E7D0),
                                      const Color(0xFFE8CAA4),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.help_outline_rounded,
                                    size: 28,
                                    color: Color(0xFF8C5319),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Sonraki Boyut ?',
                                style: GoogleFonts.nunito(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF8C5319),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // Normal Açık Evre (Tıklanamaz, sabit serüven vitrini)
                    final isCurrent = index == activeIndex;
                    final stage = stages[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 3D Meyve Görseli
                          Container(
                            padding: EdgeInsets.all(isCurrent ? 3.0 : 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: isCurrent
                                  ? Border.all(color: const Color(0xFF4E8D55), width: 2.5)
                                  : null,
                            ),
                            child: Fruit3DWidget(
                              stageIndex: index,
                              size: isCurrent ? 64 : 54,
                              borderRadius: isCurrent ? 32 : 27,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            stage.fruitComparison,
                            style: GoogleFonts.nunito(
                              fontSize: isCurrent ? 11.5 : 10.0,
                              fontWeight: isCurrent ? FontWeight.w900 : FontWeight.w700,
                              color: isCurrent ? const Color(0xFF2E6135) : const Color(0xFF5C4F53),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 3. Mevcut Aşama İçin 3D Detay Kartı (Daima seçili/aktif haftanın evresini sunar)
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9E7B83).withOpacity(0.08),
                  offset: const Offset(0, 8),
                  blurRadius: 20,
                ),
              ],
              border: Border.all(
                color: const Color(0xFFD4EBD6).withOpacity(0.6),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Fruit3DWidget(
                            stageIndex: activeIndex,
                            size: 48,
                            borderRadius: 16,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activeStage.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF2D232E),
                                  ),
                                ),
                                Text(
                                  '${activeStage.weekRange} • ${activeStage.fruitComparison}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF7A6E78),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF7F4),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE8D7DC)),
                      ),
                      child: Text(
                        activeStage.sizeInfo,
                        style: GoogleFonts.nunito(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2D232E),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Text(
                  activeStage.description,
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5C4F53),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
