import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/todos/presentation/widgets/todos_empty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TodosEmpty Widget', () {
    testWidgets('should render correctly with all expected elements',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: TodosEmpty(),
        ),
      );

      // Assert
      expect(find.byType(TodosEmpty), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
      expect(find.text('No todos found'), findsOneWidget);
      expect(find.text('Pull to refresh or check back later'), findsOneWidget);

      // Check that the widget structure exists (without counting exact numbers)
      expect(find.byType(Center), findsWidgets);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('should have correct icon properties', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: TodosEmpty(),
        ),
      );

      // Assert
      final iconWidget =
          tester.widget<Icon>(find.byIcon(Icons.check_circle_outline));
      expect(iconWidget.icon, equals(Icons.check_circle_outline));
      expect(iconWidget.size, equals(64));
      expect(iconWidget.color, equals(Colors.grey[400]));
    });

    testWidgets('should have correct text styling for title', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: TodosEmpty(),
        ),
      );

      // Assert
      final titleTextWidget = tester.widget<Text>(find.text('No todos found'));
      final titleStyle = titleTextWidget.style;

      expect(titleStyle?.color, equals(Colors.grey[600]));
      // The style should be based on headlineSmall theme
      expect(titleStyle, isNotNull);
    });

    testWidgets('should have correct text styling for subtitle',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: TodosEmpty(),
        ),
      );

      // Assert
      final subtitleTextWidget =
          tester.widget<Text>(find.text('Pull to refresh or check back later'));
      final subtitleStyle = subtitleTextWidget.style;

      expect(subtitleStyle?.color, equals(Colors.grey[500]));
      // The style should be based on bodyMedium theme
      expect(subtitleStyle, isNotNull);
    });

    testWidgets('should have correct layout structure', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: TodosEmpty(),
        ),
      );

      // Assert - Find the Column widget within the TodosEmpty widget
      final columnFinder = find.descendant(
        of: find.byType(TodosEmpty),
        matching: find.byType(Column),
      );
      expect(columnFinder, findsOneWidget);

      final columnWidget = tester.widget<Column>(columnFinder);
      expect(columnWidget.mainAxisAlignment, equals(MainAxisAlignment.center));

      // Just check that Center widgets exist (don't count them due to MaterialApp)
      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('should have proper spacing between elements', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: TodosEmpty(),
        ),
      );

      // Assert - Find SizedBox widgets within the TodosEmpty widget
      final sizedBoxFinder = find.descendant(
        of: find.byType(TodosEmpty),
        matching: find.byType(SizedBox),
      );

      final sizedBoxes = tester.widgetList<SizedBox>(sizedBoxFinder);

      // Check that we have the expected spacing SizedBoxes
      final spacingSizedBoxes = sizedBoxes
          .where((box) => box.height != null && box.width == null)
          .toList();
      expect(spacingSizedBoxes.length, equals(2));

      // Sort by height to get predictable order
      spacingSizedBoxes
          .sort((a, b) => (b.height ?? 0).compareTo(a.height ?? 0));

      expect(spacingSizedBoxes[0].height, equals(16)); // First spacing (larger)
      expect(
        spacingSizedBoxes[1].height,
        equals(8),
      ); // Second spacing (smaller)
    });

    testWidgets('should adapt to different theme contexts', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: const TodosEmpty(),
        ),
      );

      // Assert - should render without errors in dark theme
      expect(find.byType(TodosEmpty), findsOneWidget);
      expect(find.text('No todos found'), findsOneWidget);
      expect(find.text('Pull to refresh or check back later'), findsOneWidget);
    });

    testWidgets('should be accessible with proper semantics', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: TodosEmpty(),
        ),
      );

      // Assert - Check that text elements are discoverable
      expect(find.text('No todos found'), findsOneWidget);
      expect(find.text('Pull to refresh or check back later'), findsOneWidget);

      // Verify the widget can be found by semantic properties
      final titleSemantics = tester.getSemantics(find.text('No todos found'));
      expect(titleSemantics.label, equals('No todos found'));

      final subtitleSemantics =
          tester.getSemantics(find.text('Pull to refresh or check back later'));
      expect(
        subtitleSemantics.label,
        equals('Pull to refresh or check back later'),
      );
    });

    testWidgets('should render consistently across different screen sizes',
        (tester) async {
      // Test with small screen
      await tester.binding.setSurfaceSize(const Size(320, 568));
      await tester.pumpWidget(
        const MaterialApp(
          home: TodosEmpty(),
        ),
      );

      expect(find.byType(TodosEmpty), findsOneWidget);
      expect(find.text('No todos found'), findsOneWidget);

      // Test with large screen
      await tester.binding.setSurfaceSize(const Size(1024, 768));
      await tester.pumpWidget(
        const MaterialApp(
          home: TodosEmpty(),
        ),
      );

      expect(find.byType(TodosEmpty), findsOneWidget);
      expect(find.text('No todos found'), findsOneWidget);

      // Reset to default size
      await tester.binding.setSurfaceSize(null);
    });
  });
}
