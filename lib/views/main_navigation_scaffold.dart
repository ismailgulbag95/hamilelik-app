import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/fluid_clay_bottom_bar.dart';
import 'dashboard/dashboard_screen.dart';
import 'weekly_panel/weekly_panel_screen.dart';
import 'daily_tracker/daily_tracker_screen.dart';
import 'timeline/timeline_screen.dart';
import 'journal/journal_screen.dart';
import 'emergency/emergency_screen.dart';

import 'debug/debug_floating_button.dart';

/// Aura Pregnancy - Ana Gezinme İskeleti (6 Sekmeli Akışkan Claymorphic Navigasyon)
class MainNavigationScaffold extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScaffold({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScaffold> createState() => _MainNavigationScaffoldState();
}

class _MainNavigationScaffoldState extends State<MainNavigationScaffold> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardScreen(onNavigateTab: _onTabTapped),
      const WeeklyPanelScreen(),
      const DailyTrackerScreen(),
      const TimelineScreen(),
      const JournalScreen(),
      const EmergencyScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          // 🛠️ Sağ Kenar Geliştirici & Test Paneli Butonu (Prodüksiyonda kolayca kaldırılabilir)
          DebugFloatingButton(
            onDataChanged: () {
              setState(() {});
            },
          ),
        ],
      ),
      bottomNavigationBar: FluidClayBottomNavBar(
        selectedIndex: _currentIndex,
        onTabSelected: _onTabTapped,
        items: const [
          FluidNavItem(
            icon: Icons.home_rounded,
            label: 'Ana Sayfa',
          ),
          FluidNavItem(
            icon: Icons.calendar_month_rounded,
            label: 'Haftalık',
          ),
          FluidNavItem(
            icon: Icons.search_rounded, // Büyüteç ikonu
            label: 'Takip',
          ),
          FluidNavItem(
            icon: Icons.auto_graph_rounded, // Yolculuk / Timeline grafiği
            label: 'Yolculuk',
          ),
          FluidNavItem(
            icon: Icons.menu_book_rounded,
            label: 'Günlük',
          ),
          FluidNavItem(
            icon: Icons.emergency_rounded,
            label: 'Acil',
            isEmergency: true,
          ),
        ],
      ),
    );
  }
}


