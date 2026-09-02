import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aura_pregnancy/views/widgets/medical_disclaimer_sheet.dart';
import 'test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Aura Pregnancy Tıbbi Sorumluluk Reddi & Yasal Bilgilendirme Testleri', () {
    testWidgets('MedicalInfoButton ekranda düzgün render edilir ve dokunulabilir', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const Scaffold(
            body: Center(
              child: MedicalInfoButton(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MedicalInfoButton), findsOneWidget);
      expect(find.byIcon(Icons.shield_outlined), findsOneWidget);
    });

    testWidgets('MedicalDisclaimerBanner ekranda düzgün render edilir ve metin gösterir', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const Scaffold(
            body: Center(
              child: MedicalDisclaimerBanner(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MedicalDisclaimerBanner), findsOneWidget);
      expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);
    });

    testWidgets('MedicalDisclaimerSheet 4 temel yasal maddeyi ve anladım butonunu içerir', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const Scaffold(
            body: Center(
              child: MedicalDisclaimerSheet(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MedicalDisclaimerSheet), findsOneWidget);
      expect(find.byIcon(Icons.verified_user_rounded), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline_rounded), findsOneWidget);
      // 4 Yasal Madde İkonları
      expect(find.byIcon(Icons.medical_services_outlined), findsOneWidget);
      expect(find.byIcon(Icons.local_hospital_outlined), findsOneWidget);
      expect(find.byIcon(Icons.emergency_outlined), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
    });
  });
}
