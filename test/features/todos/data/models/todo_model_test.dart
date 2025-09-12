import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/todos/data/models/todo_model.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';

void main() {
  group('TodoModel', () {
    const tTodoModel = TodoModel(
      userId: 1,
      id: 1,
      title: 'Test Todo',
      completed: false,
    );

    const tTodo = Todo(
      userId: 1,
      id: 1,
      title: 'Test Todo',
      completed: false,
    );

    final tJson = {
      'userId': 1,
      'id': 1,
      'title': 'Test Todo',
      'completed': false,
    };

    test('should create TodoModel from JSON', () {
      // Act
      final result = TodoModel.fromJson(tJson);

      // Assert
      expect(result, equals(tTodoModel));
    });

    test('should convert TodoModel to JSON', () {
      // Act
      final result = tTodoModel.toJson();

      // Assert
      expect(result, equals(tJson));
    });

    test('should create TodoModel from Todo entity', () {
      // Act
      final result = TodoModel.fromEntity(tTodo);

      // Assert
      expect(result.userId, tTodo.userId);
      expect(result.id, tTodo.id);
      expect(result.title, tTodo.title);
      expect(result.completed, tTodo.completed);
    });

    test('should convert TodoModel to Todo entity', () {
      // Act
      final result = tTodoModel.toEntity();

      // Assert
      expect(result.userId, tTodoModel.userId);
      expect(result.id, tTodoModel.id);
      expect(result.title, tTodoModel.title);
      expect(result.completed, tTodoModel.completed);
    });

    test('should have proper equality', () {
      // Arrange
      const tTodoModel2 = TodoModel(
        userId: 1,
        id: 1,
        title: 'Test Todo',
        completed: false,
      );

      // Assert
      expect(tTodoModel, equals(tTodoModel2));
      expect(tTodoModel.hashCode, equals(tTodoModel2.hashCode));
    });

    test('should create copy with updated values', () {
      // Act
      final result = tTodoModel.copyWith(completed: true);

      // Assert
      expect(result.userId, tTodoModel.userId);
      expect(result.id, tTodoModel.id);
      expect(result.title, tTodoModel.title);
      expect(result.completed, true);
    });
  });
}
