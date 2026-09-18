import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_portfolio/main.dart';

void main() {
  testWidgets('Home dashboard shows welcome greeting and activity cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.textContaining('Welcome back'), findsOneWidget);

    expect(find.text('Activity 1'), findsOneWidget);
    expect(find.text('Activity 2'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}