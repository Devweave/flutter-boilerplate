import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/features/todos/domain/usecases/get_todos.dart';

import '../../../../helpers/test_mocks.mocks.dart';
import '../../../../helpers/test_setup.dart';

void main() {
  late GetTodos getTodos;
  late MockTodoRepository mockTodoRepository;

  setUpAll(() {
    setupTestDummies();
  });

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    getTodos = GetTodos(mockTodoRepository);
  });

  group('GetTodos', () {
    final tTodos = [
      const Todo(
        userId: 1,
        id: 1,
        title: 'Test Todo 1',
        completed: false,
      ),
      const Todo(
        userId: 1,
        id: 2,
        title: 'Test Todo 2',
        completed: true,
      ),
    ];

    test('should get todos from repository', () async {
      // Arrange
      when(mockTodoRepository.getTodos())
          .thenAnswer((_) async => Success(tTodos));

      // Act
      final result = await getTodos();

      // Assert
      expect(result, isA<Success<List<Todo>>>());
      final successResult = result as Success<List<Todo>>;
      expect(successResult.data, equals(tTodos));
      verify(mockTodoRepository.getTodos()).called(1);
    });

    test('should return error when repository fails', () async {
      // Arrange
      const tFailure = Error<List<Todo>>(NetworkFailure('Network error'));
      when(mockTodoRepository.getTodos()).thenAnswer((_) async => tFailure);

      // Act
      final result = await getTodos();

      // Assert
      expect(result, isA<Error<List<Todo>>>());
      final errorResult = result as Error<List<Todo>>;
      expect(errorResult.failure.message, 'Network error');
      verify(mockTodoRepository.getTodos()).called(1);
    });
  });
}
