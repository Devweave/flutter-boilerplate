import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';

void main() {
  group('Todo Entity', () {
    group('Constructor', () {
      test('should create todo with all required fields', () {
        // arrange & act
        const todo = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // assert
        expect(todo.id, 1);
        expect(todo.userId, 1);
        expect(todo.title, 'Test Todo');
        expect(todo.completed, false);
      });

      test('should create completed todo', () {
        // arrange & act
        const todo = Todo(
          id: 2,
          userId: 1,
          title: 'Completed Todo',
          completed: true,
        );

        // assert
        expect(todo.id, 2);
        expect(todo.userId, 1);
        expect(todo.title, 'Completed Todo');
        expect(todo.completed, true);
      });

      test('should create todo with long title', () {
        // arrange & act
        const longTitle =
            'This is a very long todo title that should be handled properly by the Todo entity';
        const todo = Todo(
          id: 3,
          userId: 2,
          title: longTitle,
          completed: false,
        );

        // assert
        expect(todo.id, 3);
        expect(todo.userId, 2);
        expect(todo.title, longTitle);
        expect(todo.completed, false);
      });
    });

    group('Equality', () {
      test('should be equal when all properties are same', () {
        // arrange
        const todo1 = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );
        const todo2 = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // assert
        expect(todo1, equals(todo2));
        expect(todo1.hashCode, equals(todo2.hashCode));
      });

      test('should not be equal when id is different', () {
        // arrange
        const todo1 = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );
        const todo2 = Todo(
          id: 2,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // assert
        expect(todo1, isNot(equals(todo2)));
        expect(todo1.hashCode, isNot(equals(todo2.hashCode)));
      });

      test('should not be equal when userId is different', () {
        // arrange
        const todo1 = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );
        const todo2 = Todo(
          id: 1,
          userId: 2,
          title: 'Test Todo',
          completed: false,
        );

        // assert
        expect(todo1, isNot(equals(todo2)));
      });

      test('should not be equal when title is different', () {
        // arrange
        const todo1 = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );
        const todo2 = Todo(
          id: 1,
          userId: 1,
          title: 'Different Todo',
          completed: false,
        );

        // assert
        expect(todo1, isNot(equals(todo2)));
      });

      test('should not be equal when completed status is different', () {
        // arrange
        const todo1 = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );
        const todo2 = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: true,
        );

        // assert
        expect(todo1, isNot(equals(todo2)));
      });
    });

    group('CopyWith', () {
      test('should create copy with updated id', () {
        // arrange
        const todo = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // act
        final updatedTodo = todo.copyWith(id: 2);

        // assert
        expect(updatedTodo.id, 2);
        expect(updatedTodo.userId, 1);
        expect(updatedTodo.title, 'Test Todo');
        expect(updatedTodo.completed, false);
        expect(todo.id, 1); // original should be unchanged
      });

      test('should create copy with updated userId', () {
        // arrange
        const todo = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // act
        final updatedTodo = todo.copyWith(userId: 2);

        // assert
        expect(updatedTodo.id, 1);
        expect(updatedTodo.userId, 2);
        expect(updatedTodo.title, 'Test Todo');
        expect(updatedTodo.completed, false);
      });

      test('should create copy with updated title', () {
        // arrange
        const todo = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // act
        final updatedTodo = todo.copyWith(title: 'Updated Todo');

        // assert
        expect(updatedTodo.id, 1);
        expect(updatedTodo.userId, 1);
        expect(updatedTodo.title, 'Updated Todo');
        expect(updatedTodo.completed, false);
      });

      test('should create copy with updated completed status', () {
        // arrange
        const todo = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // act
        final updatedTodo = todo.copyWith(completed: true);

        // assert
        expect(updatedTodo.id, 1);
        expect(updatedTodo.userId, 1);
        expect(updatedTodo.title, 'Test Todo');
        expect(updatedTodo.completed, true);
      });

      test('should create copy with multiple updated fields', () {
        // arrange
        const todo = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // act
        final updatedTodo = todo.copyWith(
          id: 2,
          userId: 3,
          title: 'New Todo',
          completed: true,
        );

        // assert
        expect(updatedTodo.id, 2);
        expect(updatedTodo.userId, 3);
        expect(updatedTodo.title, 'New Todo');
        expect(updatedTodo.completed, true);
      });
    });

    group('JSON serialization', () {
      test('should create todo from JSON', () {
        // arrange
        final json = {
          'id': 1,
          'userId': 1,
          'title': 'Test Todo',
          'completed': false,
        };

        // act
        final todo = Todo.fromJson(json);

        // assert
        expect(todo.id, 1);
        expect(todo.userId, 1);
        expect(todo.title, 'Test Todo');
        expect(todo.completed, false);
      });

      test('should create completed todo from JSON', () {
        // arrange
        final json = {
          'id': 2,
          'userId': 1,
          'title': 'Completed Todo',
          'completed': true,
        };

        // act
        final todo = Todo.fromJson(json);

        // assert
        expect(todo.id, 2);
        expect(todo.userId, 1);
        expect(todo.title, 'Completed Todo');
        expect(todo.completed, true);
      });

      test('should convert todo to JSON', () {
        // arrange
        const todo = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // act
        final json = todo.toJson();

        // assert
        expect(json['id'], 1);
        expect(json['userId'], 1);
        expect(json['title'], 'Test Todo');
        expect(json['completed'], false);
      });

      test('should convert completed todo to JSON', () {
        // arrange
        const todo = Todo(
          id: 2,
          userId: 3,
          title: 'Completed Task',
          completed: true,
        );

        // act
        final json = todo.toJson();

        // assert
        expect(json['id'], 2);
        expect(json['userId'], 3);
        expect(json['title'], 'Completed Task');
        expect(json['completed'], true);
      });

      test('should handle round trip JSON conversion', () {
        // arrange
        const originalTodo = Todo(
          id: 1,
          userId: 1,
          title: 'Round Trip Todo',
          completed: false,
        );

        // act
        final json = originalTodo.toJson();
        final reconstructedTodo = Todo.fromJson(json);

        // assert
        expect(reconstructedTodo, equals(originalTodo));
      });
    });

    group('ToString', () {
      test('should return string representation of todo', () {
        // arrange
        const todo = Todo(
          id: 1,
          userId: 1,
          title: 'Test Todo',
          completed: false,
        );

        // act
        final result = todo.toString();

        // assert
        expect(result, contains('Todo'));
        expect(result, contains('1'));
        expect(result, contains('Test Todo'));
        expect(result, contains('false'));
      });

      test('should return string representation of completed todo', () {
        // arrange
        const todo = Todo(
          id: 2,
          userId: 1,
          title: 'Completed Todo',
          completed: true,
        );

        // act
        final result = todo.toString();

        // assert
        expect(result, contains('Todo'));
        expect(result, contains('2'));
        expect(result, contains('Completed Todo'));
        expect(result, contains('true'));
      });
    });

    group('Business logic helpers', () {
      test('should identify incomplete todos', () {
        // arrange
        const incompleteTodo = Todo(
          id: 1,
          userId: 1,
          title: 'Incomplete Todo',
          completed: false,
        );

        // assert
        expect(incompleteTodo.completed, false);
      });

      test('should identify completed todos', () {
        // arrange
        const completedTodo = Todo(
          id: 1,
          userId: 1,
          title: 'Completed Todo',
          completed: true,
        );

        // assert
        expect(completedTodo.completed, true);
      });
    });
  });
}
