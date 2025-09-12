import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/features/todos/presentation/widgets/todo_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TodoItem', () {
    const incompleteTodo = Todo(
      userId: 1,
      id: 1,
      title: 'Test Todo',
      completed: false,
    );

    const completedTodo = Todo(
      userId: 1,
      id: 2,
      title: 'Completed Todo',
      completed: true,
    );

    Widget createWidget({
      required Todo todo,
      VoidCallback? onTap,
      VoidCallback? onToggle,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: TodoItem(
            todo: todo,
            onTap: onTap,
            onToggle: onToggle,
          ),
        ),
      );
    }

    testWidgets('should display todo title', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(todo: incompleteTodo));

      expect(find.text('Test Todo'), findsOneWidget);
    });

    testWidgets('should display unchecked icon for incomplete todo',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(todo: incompleteTodo));

      expect(find.byIcon(Icons.radio_button_unchecked), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsNothing);
    });

    testWidgets('should display checked icon for completed todo',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(todo: completedTodo));

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_unchecked), findsNothing);
    });

    testWidgets('should apply strikethrough for completed todo',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(todo: completedTodo));

      final textWidget = tester.widget<Text>(find.text('Completed Todo'));
      expect(textWidget.style?.decoration, TextDecoration.lineThrough);
    });

    testWidgets('should not apply strikethrough for incomplete todo',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(todo: incompleteTodo));

      final textWidget = tester.widget<Text>(find.text('Test Todo'));
      expect(textWidget.style?.decoration, isNot(TextDecoration.lineThrough));
    });

    testWidgets('should call onToggle when leading icon is tapped',
        (WidgetTester tester) async {
      bool wasToggled = false;

      await tester.pumpWidget(
        createWidget(
          todo: incompleteTodo,
          onToggle: () => wasToggled = true,
        ),
      );

      await tester.tap(find.byIcon(Icons.radio_button_unchecked));
      expect(wasToggled, isTrue);
    });

    testWidgets('should call onTap when list tile is tapped',
        (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        createWidget(
          todo: incompleteTodo,
          onTap: () => wasTapped = true,
        ),
      );

      await tester.tap(find.byType(ListTile));
      expect(wasTapped, isTrue);
    });

    testWidgets('should handle null onToggle callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createWidget(
          todo: incompleteTodo,
          onToggle: null,
        ),
      );

      // Should not throw when tapped
      await tester.tap(find.byIcon(Icons.radio_button_unchecked));
      await tester.pump();
    });

    testWidgets('should handle null onTap callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createWidget(
          todo: incompleteTodo,
          onTap: null,
        ),
      );

      // Should not throw when tapped
      await tester.tap(find.byType(ListTile));
      await tester.pump();
    });

    testWidgets('should be wrapped in a Card', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(todo: incompleteTodo));

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should have correct card margin', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(todo: incompleteTodo));

      final cardWidget = tester.widget<Card>(find.byType(Card));
      expect(
        cardWidget.margin,
        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      );
    });
  });
}
