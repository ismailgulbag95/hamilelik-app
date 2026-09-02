import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aura_pregnancy/core/widgets/micro_animations.dart';
import 'package:aura_pregnancy/core/theme/clay_theme.dart';
import 'package:aura_pregnancy/core/constants/app_colors.dart';

void main() {
  group('Aura Pregnancy - Mikro Animasyon ve Etkileşim Testleri', () {
    testWidgets('1. PulseAura bileşeni çocuğu doğru çizer ve nefes alma aurası oluşturur', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PulseAura(
              auraColor: Color(0x33FFB6C1),
              child: Text('Fetus Card'),
            ),
          ),
        ),
      );

      expect(find.text('Fetus Card'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('Fetus Card'), findsOneWidget);
    });

    testWidgets('2. CountingNumberText sayıyı 0 dan hedef değere doğru sayar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CountingNumberText(
              value: 2500,
              suffix: ' ml',
              style: TextStyle(fontSize: 16),
              duration: Duration(milliseconds: 300),
            ),
          ),
        ),
      );

      // Başlangıçta 0 ml civarı
      await tester.pump();
      expect(find.text('0 ml'), findsOneWidget);

      // 350 ms sonra hedefe (2500 ml) ulaşır
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('2500 ml'), findsOneWidget);
    });

    testWidgets('3. RippleShockwave tıklandığında şok dalgası animasyonunu tetikler', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RippleShockwave(
              onTap: () => tapped = true,
              child: const Icon(Icons.touch_app),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.touch_app), findsOneWidget);
      await tester.tap(find.byIcon(Icons.touch_app));
      await tester.pump();
      expect(tapped, isTrue);

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 350));
    });

    testWidgets('4. StaggeredSlideFade kademeli kayma ve opaklık geçişi sağlar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                StaggeredSlideFade(
                  index: 0,
                  child: Text('Kart 1'),
                ),
                StaggeredSlideFade(
                  index: 1,
                  child: Text('Kart 2'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.text('Kart 1'), findsOneWidget);
      expect(find.text('Kart 2'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Kart 1'), findsOneWidget);
    });

    testWidgets('5. SparkleBurst parçacık patlaması başlatıldığında sorunsuz render eder', (tester) async {
      final GlobalKey<SparkleBurstState> key = GlobalKey<SparkleBurstState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SparkleBurst(
              key: key,
              child: const Text('Hedef Tamamlandı'),
            ),
          ),
        ),
      );

      expect(find.text('Hedef Tamamlandı'), findsOneWidget);
      key.currentState?.fire();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump(const Duration(milliseconds: 400));
    });

    testWidgets('6. ClayButton basıldığında ve bırakıldığında yaylanma eğrisini uygular', (tester) async {
      bool clicked = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClayButton(
              color: AppColors.clayPeach,
              height: 44,
              onPressed: () => clicked = true,
              child: const Text('Dokun'),
            ),
          ),
        ),
      );

      final buttonFinder = find.text('Dokun');
      expect(buttonFinder, findsOneWidget);

      final gesture = await tester.startGesture(tester.getCenter(buttonFinder));
      await tester.pump(const Duration(milliseconds: 50));

      await gesture.up();
      await tester.pump(const Duration(milliseconds: 200));

      expect(clicked, isTrue);
    });
  });
}
