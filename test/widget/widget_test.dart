import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/injection/injection.dart';
import 'package:task_manager_app/presentation/common/app.dart';

void main() {
  setUp(() => setupDependencies());

  testWidgets(
    'Home screen smoke test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Statistics'), findsOneWidget);
      expect(find.text('Tasks list'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.bar_chart_sharp), findsOneWidget);
    },
  );
}
