import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:aura_pregnancy/main.dart';
import 'test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeDateFormatting('tr_TR', null);
  });

  testWidgets('App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      createLocalizedTestWidget(
        child: const RootGateScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(RootGateScreen), findsOneWidget);
  });
}
