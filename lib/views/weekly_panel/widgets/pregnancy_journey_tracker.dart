import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/clay_theme.dart';

/// Gebelik Gelişim Aşaması Bilgi Modeli
class JourneyStageData {
  final String title;
  final String fruitComparison;
  final String weekRange;
  final String sizeInfo;
  final String description;
  final String emoji;
  final IconData icon;

  const JourneyStageData({
    required this.title,
    required this.fruitComparison,
    required this.weekRange,
    required this.sizeInfo,
    required this.description,
    required this.emoji,
    required this.icon,
  });
}

/// Dribbble Aesthetic - Claymorphism 3D Fetal Journey Tracker (Tüm Boyut & Meyve Karşılaştırmaları)
class PregnancyJourneyTracker extends StatefulWidget {
  final int initialIndex;
  final Function(int)? onStageSelected;

  const PregnancyJourneyTracker({
    super.key,
    this.initialIndex = 4,
    this.onStageSelected,
  });

  @override
  State<PregnancyJourneyTracker> createState() => _PregnancyJourneyTrackerState();
}

class _PregnancyJourneyTrackerState extends State<PregnancyJourneyTracker> {
  late int _activeIndex;
  late ScrollController _scrollController;

  static const List<JourneyStageData> stages = [
    JourneyStageData(
      title: 'Yaşamın Tohumu',
      fruitComparison: 'Haşhaş Tohumu',
      weekRange: '4 - 5. Hafta',
      sizeInfo: '📏 ~1.5 mm • ⚖️ < 1 gr',
      description: 'Mucizevi yolculuğun başlangıcı! Döllenmiş minik hücre rahme güvenle tutundu ve ilk kalp tüpü şekillenmeye başladı 🌱',
      emoji: '🌱',
      icon: Icons.spa_rounded,
    ),
    JourneyStageData(
      title: 'İlk Kalp Pırıltısı',
      fruitComparison: 'Yaban Mersini',
      weekRange: '6 - 8. Hafta',
      sizeInfo: '📏 ~1.5 cm • ⚖️ ~1.5 gr',
      description: 'Minik kalbi dakikada 160 kez atıyor! Göz ve kulak kabarcıkları beliriyor, el ve ayak tomurcukları hızla uzuyor 🫐',
      emoji: '🫐',
      icon: Icons.bubble_chart_rounded,
    ),
    JourneyStageData(
      title: 'Minik Parmaklar',
      fruitComparison: 'Çilek / Zeytin',
      weekRange: '9 - 10. Hafta',
      sizeInfo: '📏 ~3.2 cm • ⚖️ ~5 gr',
      description: 'Artık bir embriyo değil, resmi olarak bir fetüs! Parmaklarındaki perdeler eriyor, dirsek ve diz eklemleri bükülüyor 🍓',
      emoji: '🍓',
      icon: Icons.favorite_rounded,
    ),
    JourneyStageData(
      title: 'İlk Trimester Zaferi',
      fruitComparison: 'Limon / İncir',
      weekRange: '11 - 13. Hafta',
      sizeInfo: '📏 ~7.5 cm • ⚖️ ~25 gr',
      description: 'Kritik organ oluşumu tamamlandı! Minik tırnaklar çıkıyor, yutkunma refleksleri başlıyor ve ultrasonda taklalar atıyor 🍋',
      emoji: '🍋',
      icon: Icons.wb_sunny_rounded,
    ),
    JourneyStageData(
      title: 'Kıvrık Fetüs & Mimikler',
      fruitComparison: 'Avokado',
      weekRange: '14 - 16. Hafta',
      sizeInfo: '📏 ~12 cm • ⚖️ ~100 gr',
      description: 'Kaşlarını çatabiliyor, gülümseyebiliyor ve sesinizi duyabiliyor! İncecik ipeksi lanugo tüyleri cildini korumaya başladı 🥑',
      emoji: '🥑',
      icon: Icons.child_care_rounded,
    ),
    JourneyStageData(
      title: 'İlk Tekmeler & Merhaba',
      fruitComparison: 'Muz / Mango',
      weekRange: '17 - 20. Hafta',
      sizeInfo: '📏 ~25 cm • ⚖️ ~300 gr',
      description: 'Yolun yarısı! Bebeğiniz başparmağını emiyor ve annesine ilk kıpırtılarıyla "Buradayım!" diye hafif tekmeler atıyor 🍌',
      emoji: '🍌',
      icon: Icons.motion_photos_on_rounded,
    ),
    JourneyStageData(
      title: 'Göz Kırpma & Tat Alma',
      fruitComparison: 'Patlıcan / Mısır',
      weekRange: '21 - 24. Hafta',
      sizeInfo: '📏 ~30 cm • ⚖️ ~600 gr',
      description: 'Tat alma duyusu gelişti; yediğiniz tatlıların lezzetini alabiliyor! Göz kapakları açılıp kapanıyor ve ritmik hıçkırıklar başlıyor 🍆',
      emoji: '🍆',
      icon: Icons.remove_red_eye_rounded,
    ),
    JourneyStageData(
      title: 'Büyüyen Akciğerler',
      fruitComparison: 'Hindistan Cevizi',
      weekRange: '25 - 27. Hafta',
      sizeInfo: '📏 ~36 cm • ⚖️ ~1.0 kg',
      description: '2. Trimester bitti! Akciğerlerinde nefes almayı sağlayan sürfaktan maddesi üretiliyor, babasının sesine tepki verip tekmeliyor 🥥',
      emoji: '🥥',
      icon: Icons.air_rounded,
    ),
    JourneyStageData(
      title: 'Rüyalar & REM Uykusu',
      fruitComparison: 'Ananas / Lahana',
      weekRange: '28 - 32. Hafta',
      sizeInfo: '📏 ~42 cm • ⚖️ ~1.8 kg',
      description: '3. Trimesterdayız! Beyin dalgaları artık rüya gördüğünü gösteriyor. Kemikleri güçleniyor ve göz bebekleri ışığa tepki veriyor 🍍',
      emoji: '🍍',
      icon: Icons.bedtime_rounded,
    ),
    JourneyStageData(
      title: 'Doğum Pozisyonu & Güç',
      fruitComparison: 'Kavun / Kereviz',
      weekRange: '33 - 36. Hafta',
      sizeInfo: '📏 ~47 cm • ⚖️ ~2.7 kg',
      description: 'Bebeğiniz doğum için baş aşağı pozisyonunu alıyor. Cilt altı yağ dokusu doluyor, anneden gelen koruyucu antikorlarla güçleniyor 🍈',
      emoji: '🍈',
      icon: Icons.shield_rounded,
    ),
    JourneyStageData(
      title: 'Kollara Hazır Melek',
      fruitComparison: 'Bal Kabağı / Bebek',
      weekRange: '37 - 40. Hafta',
      sizeInfo: '📏 ~51 cm • ⚖️ ~3.4 kg',
      description: 'Tüm hazırlıklar tamamlandı! Dünyaya gözlerini açıp annenizin ve babanızın sıcak kucağına gelmek için sabırsızlanıyor 👶🌸✨',
      emoji: '👶',
      icon: Icons.face_retouching_natural_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.initialIndex.clamp(0, stages.length - 1);
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToActive());
  }

  void _scrollToActive() {
    if (_scrollController.hasClients) {
      final targetOffset = (_activeIndex * 84.0) - 60.0;
      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void didUpdateWidget(covariant PregnancyJourneyTracker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      setState(() {
        _activeIndex = widget.initialIndex.clamp(0, stages.length - 1);
      });
      _scrollToActive();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeStage = stages[_activeIndex];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF7F4), // Yumuşak krem zemin
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
                        color: const Color(0xFF2D232E), // Yüksek kontrastlı koyu metin
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Meyve & Boyut Karşılaştırmaları (${_activeIndex + 1}/${stages.length})',
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
                      Text(activeStage.emoji, style: const TextStyle(fontSize: 14)),
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

          // 2. Yatay 3D Claymorphic Yolculuk Butonları (11 Aşamalı Boyut Akışı)
          SizedBox(
            height: 128,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Arka plandaki yumuşak bağlantı şeridi
                Positioned(
                  top: 38,
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

                // Buton Listesi (Yatay Kaydırılabilir)
                ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: stages.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == _activeIndex;
                    final stage = stages[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() => _activeIndex = index);
                        widget.onStageSelected?.call(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 3D Clay Küre / Buton
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 320),
                              curve: Curves.easeOutBack,
                              width: isSelected ? 76 : 60,
                              height: isSelected ? 76 : 60,
                              decoration: BoxDecoration(
                                // Aktif olan Yumuşak Nane Yeşili (#D4EBD6), diğerleri Şeftali (#FEE6E0)
                                color: isSelected ? const Color(0xFFD4EBD6) : const Color(0xFFFEE6E0),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  // Dış Yumuşak Gölge
                                  BoxShadow(
                                    color: isSelected
                                        ? const Color(0xFF4E8D55).withOpacity(0.28)
                                        : const Color(0xFF9E7B83).withOpacity(0.18),
                                    offset: Offset(0, isSelected ? 12 : 8),
                                    blurRadius: isSelected ? 22 : 14,
                                  ),
                                  // Taban Gölgesi
                                  BoxShadow(
                                    color: const Color(0xFF7A6E78).withOpacity(isSelected ? 0.22 : 0.14),
                                    offset: const Offset(0, 4),
                                    blurRadius: 8,
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: isSelected
                                      ? [
                                          Colors.white.withOpacity(0.70), // Üst parlak ışık
                                          const Color(0xFFD4EBD6),
                                          const Color(0xFFBFDEC2), // Alt koyu gölge
                                        ]
                                      : [
                                          Colors.white.withOpacity(0.60),
                                          const Color(0xFFFEE6E0),
                                          const Color(0xFFECD0CA),
                                        ],
                                  stops: const [0.0, 0.45, 1.0],
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Üst Işık Yansıması (Specular Oval)
                                  Positioned(
                                    top: isSelected ? 8 : 6,
                                    child: Container(
                                      width: isSelected ? 34 : 24,
                                      height: isSelected ? 12 : 8,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.55),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  // İkon ve Emoji
                                  Text(
                                    stage.emoji,
                                    style: TextStyle(fontSize: isSelected ? 26 : 20),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Meyve İsmi
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: GoogleFonts.nunito(
                                fontSize: isSelected ? 12 : 10.5,
                                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                                color: isSelected ? const Color(0xFF2E6135) : const Color(0xFF5C4F53),
                              ),
                              child: Text(stage.fruitComparison),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 3. Seçilen Aşama İçin 3D Detay Kartı (Hero Expansion)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Container(
              key: ValueKey<int>(_activeIndex),
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
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: ClayTheme.clayDecoration(
                              color: const Color(0xFFFEE6E0),
                              borderRadius: 14,
                            ),
                            child: Center(
                              child: Text(activeStage.emoji, style: const TextStyle(fontSize: 22)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeStage.title,
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF2D232E),
                                ),
                              ),
                              Text(
                                '${activeStage.weekRange} • ${activeStage.fruitComparison}',
                                style: GoogleFonts.quicksand(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF7A6E78),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

                  // Açıklama Metni
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
          ),
        ],
      ),
    );
  }
}
