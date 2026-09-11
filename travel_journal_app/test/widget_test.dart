import 'package:flutter_test/flutter_test.dart';
import 'package:travel_journal_app/main.dart';

void main() {
  testWidgets('MyApp builds and renders Travel Journal home screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Travel Journal'), findsOneWidget);
  });
}
