import 'package:flutter_test/flutter_test.dart';

import 'package:second_flutter_app/main.dart';

void main() {
  testWidgets('Product app loads product catalog', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('E-Commerce Shop'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Apple iPhone 17 Pro Max'), findsOneWidget);
  });
}
