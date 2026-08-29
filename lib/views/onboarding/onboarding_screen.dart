import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/clay_theme.dart';
import '../../controllers/onboarding_controller.dart';
import '../../utils/date_utils.dart';
import '../main_navigation_scaffold.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback? onCompleted;

  const OnboardingScreen({super.key, this.onCompleted});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingController _controller = OnboardingController();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

  final TextEditingController _momNameController = TextEditingController();
  final TextEditingController _babyNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _momNameController.dispose();
    _babyNameController.dispose();
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
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
          'Aura Pregnancy',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primaryDark),
                onPressed: _prevPage,
              )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Claymorphic İlerleme Adımları (4 Adım)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: List.generate(_totalPages, (index) {
                  final isActive = index <= _currentPage;
                  return Expanded(
                    child: Container(
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primaryPink : AppColors.backgroundSubtle,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: AppColors.primaryPink.withOpacity(0.4),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildDateSelectionStep(),
                  _buildBmiStep(),
                  _buildBabyAndMomInfoStep(),
                  _buildSummaryStep(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Adım 1: SAT veya Doğum Tarihi Seçimi
  Widget _buildDateSelectionStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClayCard(
            color: AppColors.clayRose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('🌸', style: TextStyle(fontSize: 26)),
                    SizedBox(width: 10),
                    Text(
                      'Hamilelik Başlangıcı',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bebeğinizin gelişimini ve tıbbi test takvimini hesaplamak için Son Adet Tarihinizi (SAT) veya tahmini doğum tarihinizi seçin.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Seçim Modu Değiştirici (Clay Switcher)
          ClayCard(
            color: AppColors.clayLavender,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _controller.setDateInputMode(DateInputMode.lmp),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: _controller.inputMode == DateInputMode.lmp
                          ? ClayTheme.clayDecoration(
                              color: AppColors.clayRose,
                              borderRadius: 20,
                            )
                          : null,
                      child: Center(
                        child: Text(
                          'Son Adet Tarihi (SAT)',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _controller.inputMode == DateInputMode.lmp
                                ? AppColors.primaryDark
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _controller.setDateInputMode(DateInputMode.dueDate),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: _controller.inputMode == DateInputMode.dueDate
                          ? ClayTheme.clayDecoration(
                              color: AppColors.clayRose,
                              borderRadius: 20,
                            )
                          : null,
                      child: Center(
                        child: Text(
                          'Doğum Tarihi',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _controller.inputMode == DateInputMode.dueDate
                                ? AppColors.primaryDark
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tarih Seçici Kartı
          ClayCard(
            color: AppColors.clayCardSurface,
            child: Column(
              children: [
                Text(
                  _controller.inputMode == DateInputMode.lmp ? 'Seçilen SAT:' : 'Tahmini Doğum Tarihi:',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppDateUtils.formatDisplay(AppDateUtils.toIso(_controller.selectedDate)),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 16),
                ClayButton(
                  color: AppColors.clayPeach,
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _controller.selectedDate,
                      firstDate: DateTime.now().subtract(const Duration(days: 300)),
                      lastDate: DateTime.now().add(const Duration(days: 300)),
                    );
                    if (picked != null) {
                      _controller.setSelectedDate(picked);
                    }
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_month_rounded, color: AppColors.secondaryPeach, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Tarihi Değiştir',
                        style: TextStyle(
                          color: AppColors.secondaryPeach,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Anlık Hesaplanan Hafta Göstergesi
          ClayCard(
            color: AppColors.clayMint,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hesaplanan Gebelik:',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_controller.currentWeek}. Hafta (${_controller.trimester}. Trimester)',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.successGreen,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: ClayTheme.clayDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: 16,
                  ),
                  child: Text(
                    '${AppDateUtils.daysUntil(AppDateUtils.toIso(_controller.calculatedDueDate))} Gün Kaldı',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          ClayButton(
            color: AppColors.clayRose,
            onPressed: _nextPage,
            child: const Text(
              'Devam Et →',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Adım 2: Boy, Kilo ve VKİ Analizi
  Widget _buildBmiStep() {
    final guideline = _controller.weightGuideline;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClayCard(
            color: AppColors.clayPeach,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('⚖️', style: TextStyle(fontSize: 26)),
                    SizedBox(width: 10),
                    Text(
                      'Boy & Kilo Bilgisi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondaryPeach,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Hamilelik öncesi kilonuz ve boyunuz, sağlıklı kilo artış hedefinizi belirler.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Boy Ayarlayıcı
          ClayCard(
            color: AppColors.clayCardSurface,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Boyunuz:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    Text(
                      '${_controller.heightCm.toInt()} cm',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                    ),
                  ],
                ),
                Slider(
                  value: _controller.heightCm,
                  min: 140,
                  max: 200,
                  divisions: 60,
                  activeColor: AppColors.primaryPink,
                  inactiveColor: AppColors.backgroundSubtle,
                  onChanged: (val) => _controller.setHeight(val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Kilo Ayarlayıcı
          ClayCard(
            color: AppColors.clayCardSurface,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Hamilelik Öncesi Kilo:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    Text(
                      '${_controller.prePregnancyWeightKg.toStringAsFixed(1)} kg',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.secondaryPeach),
                    ),
                  ],
                ),
                Slider(
                  value: _controller.prePregnancyWeightKg,
                  min: 40,
                  max: 140,
                  divisions: 200,
                  activeColor: AppColors.secondaryPeach,
                  inactiveColor: AppColors.backgroundSubtle,
                  onChanged: (val) => _controller.setWeight(val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // VKİ ve IOM Hedef Kartı
          ClayCard(
            color: AppColors.claySky,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'VKİ: ${_controller.vki} (${guideline['category_tr']})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.waterBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '• Toplam İdeal Kilo Alımı: ${guideline['range']}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  '• ${guideline['weekly_desc']}',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          ClayButton(
            color: AppColors.clayRose,
            onPressed: _nextPage,
            child: const Text(
              'Bebek Bilgilerine Geç →',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
            ),
          ),
        ],
      ),
    );
  }

  /// Adım 3: Anne & Bebek İsmi ve Cinsiyet Bilgileri
  Widget _buildBabyAndMomInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClayCard(
            color: AppColors.clayLavender,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('👶', style: TextStyle(fontSize: 26)),
                    SizedBox(width: 10),
                    Text(
                      'Bebek & Anne Bilgileri',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Bebeğinizin ismi veya cinsiyeti belliyse girin; uygulama boyunca bebeğinize özel hitaplarla seslenelim ✨',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 1. Anne İsmi
          ClayCard(
            color: AppColors.clayCardSurface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🌸 Anne Adayının Adı (Opsiyonel):', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _momNameController,
                  onChanged: (val) => _controller.setMomName(val),
                  decoration: InputDecoration(
                    hintText: 'Örn: Elif, Zeynep',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 2. Bebeğin İsmi
          ClayCard(
            color: AppColors.clayCardSurface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('👶 Bebeğinize İsim Seçtiniz mi?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                const SizedBox(height: 4),
                const Text('İsim girdiğinizde uygulama "Ayşe Bebek bugün 150 gr" gibi özel hitap edecektir.', style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                TextField(
                  controller: _babyNameController,
                  onChanged: (val) => _controller.setBabyName(val),
                  decoration: InputDecoration(
                    hintText: 'Örn: Ayşe, Mehmet, Mavi (Boş bırakılabilir)',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 3. Bebeğin Cinsiyeti
          ClayCard(
            color: AppColors.clayCardSurface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🎀 Bebeğinizin Cinsiyeti:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildGenderOption('Kız 👧', 'girl', AppColors.clayRose, AppColors.primaryPink),
                    const SizedBox(width: 8),
                    _buildGenderOption('Erkek 👦', 'boy', AppColors.claySky, AppColors.waterBlue),
                    const SizedBox(width: 8),
                    _buildGenderOption('Sürpriz 💛', 'surprise', AppColors.clayCream, AppColors.accentGold),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          ClayButton(
            color: AppColors.clayRose,
            onPressed: _nextPage,
            child: const Text(
              'Özeti Görüntüle →',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String label, String value, Color bgColor, Color activeColor) {
    final isSelected = _controller.babyGender == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => _controller.setBabyGender(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : bgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isSelected ? activeColor.withOpacity(0.3) : Colors.black.withOpacity(0.04),
                blurRadius: isSelected ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Adım 4: Özet ve SQLite Profil Kaydı
  Widget _buildSummaryStep() {
    final guideline = _controller.weightGuideline;
    final babyNameText = _controller.babyName.trim().isNotEmpty
        ? '${_controller.babyName.trim()} Bebek'
        : 'Belirlenmedi (Bebeğiniz)';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClayCard(
            color: AppColors.clayLavender,
            child: Column(
              children: [
                const Text('🎉', style: TextStyle(fontSize: 36)),
                const SizedBox(height: 8),
                const Text(
                  'Aura Yolculuğunuz Başlıyor!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Aşağıdaki profil bilgileriyle medikal takip ve anı günlüğünüz oluşturulacaktır.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ClayCard(
            color: AppColors.clayCardSurface,
            child: Column(
              children: [
                _buildSummaryRow('Bebek Hitap Adı', babyNameText),
                const Divider(height: 18),
                _buildSummaryRow('Cinsiyet', _controller.babyGender == 'girl' ? 'Kız 👧' : _controller.babyGender == 'boy' ? 'Erkek 👦' : 'Sürpriz 💛'),
                const Divider(height: 18),
                _buildSummaryRow('Gebelik Haftası', '${_controller.currentWeek}. Hafta'),
                const Divider(height: 18),
                _buildSummaryRow('Tahmini Doğum', AppDateUtils.formatDisplay(AppDateUtils.toIso(_controller.calculatedDueDate))),
                const Divider(height: 18),
                _buildSummaryRow('VKİ ve Kategori', '${_controller.vki} (${_controller.vkiCategoryKey})'),
                const Divider(height: 18),
                _buildSummaryRow('Hedeflenen Kilo Artışı', '${guideline['range']}'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          if (_controller.errorMessage != null) ...[
            Text(
              _controller.errorMessage!,
              style: const TextStyle(color: AppColors.medicalAlertRed, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
          ],

          ClayButton(
            color: AppColors.clayMint,
            onPressed: _controller.isLoading ? null : _saveAndContinue,
            child: _controller.isLoading
                ? const CircularProgressIndicator(color: AppColors.successGreen)
                : const Text(
                    '✨ Profili Kaydet ve Başla',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.successGreen,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveAndContinue() async {
    final success = await _controller.saveProfileToDatabase();
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil başarıyla oluşturuldu ve kaydedildi! ✨'),
          backgroundColor: AppColors.successGreen,
          duration: Duration(seconds: 2),
        ),
      );

      if (widget.onCompleted != null) {
        try {
          widget.onCompleted!();
        } catch (e) {
          debugPrint('onCompleted callback error: $e');
        }
      }

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MainNavigationScaffold()),
          (route) => false,
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_controller.errorMessage ?? 'Profil kaydedilemedi. Lütfen tekrar deneyin.'),
          backgroundColor: AppColors.medicalAlertRed,
          action: SnackBarAction(
            label: 'Yine de Başla',
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const MainNavigationScaffold()),
                (route) => false,
              );
            },
          ),
        ),
      );
    }
  }

  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
      ],
    );
  }
}
