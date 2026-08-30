import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

// Web uyumluluğu için koşullu importlar
import 'dart:io' if (dart.library.html) 'services/io_stubs.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' if (dart.library.html) 'services/sqflite_ffi_stubs.dart';
import 'core/theme/clay_theme.dart';
import 'core/constants/app_colors.dart';
import 'services/database_helper.dart';
import 'models/profile_model.dart';
import 'views/welcome/welcome_congratulation_screen.dart';
import 'views/welcome/app_guide_screen.dart';

import 'views/main_navigation_scaffold.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await initializeDateFormatting('tr_TR', null);
  } catch (e) {
    debugPrint('Date formatting init error: $e');
  }

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const AuraPregnancyApp());
}

class AuraPregnancyApp extends StatelessWidget {
  const AuraPregnancyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aura Pregnancy',
      debugShowCheckedModeBanner: false,
      theme: ClayTheme.themeData,
      home: const RootGateScreen(),
    );
  }
}

/// Veritabanı ve Profil Durumuna Göre Yönlendirici (Gatekeeper)
class RootGateScreen extends StatefulWidget {
  const RootGateScreen({super.key});

  @override
  State<RootGateScreen> createState() => _RootGateScreenState();
}

class _RootGateScreenState extends State<RootGateScreen> {
  bool _isLoading = true;
  ProfileModel? _profile;

  @override
  void initState() {
    super.initState();
    _checkInitialState();
  }

  Future<void> _checkInitialState() async {
    try {
      final profile = await DatabaseHelper.instance.getProfile();
      setState(() {
        _profile = profile;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('RootGateScreen error: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: ClayTheme.clayDecoration(
                  color: AppColors.clayRose,
                  borderRadius: 35,
                ),
                child: const Center(
                  child: Icon(Icons.favorite_rounded, color: AppColors.primaryPink, size: 36),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Aura Pregnancy',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 8),
              const CircularProgressIndicator(color: AppColors.primaryPink),
            ],
          ),
        ),
      );
    }

    // Profil varsa doğrudan ana navigasyona yönlendir
    if (_profile != null) {
      return const MainNavigationScaffold();
    }

    // Yeni kullanıcı için: Hoş Geldiniz -> Uygulama Rehberi -> Onboarding -> Ana Uygulama (Dashboard)
    return WelcomeCongratulationScreen(
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AppGuideScreen(),
          ),
        );
      },
    );
  }
}
