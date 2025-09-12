import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_boilerplate/features/todos/domain/usecases/get_todo_by_id.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import '../../../../helpers/test_mocks.mocks.dart';
import '../../../../helpers/test_setup.dart';

void main() {
  late GetTodoById useCase;
  late MockTodoRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoRepository();
    useCase = GetTodoById(mockRepository);
    setupTestDummies();
  });

  group('GetTodoById', () {
    const todoId = 1;
    const todo = Todo(
      userId: 1,
      id: todoId,
      title: 'Test Todo',
      completed: false,
    );

    test('should get todo from repository when id is valid', () async {
      // arrange
      when(mockRepository.getTodoById(todoId))
          .thenAnswer((_) async => const Success(todo));

      // act
      final result = await useCase.call(todoId);

      // assert
      expect(result, isA<Success<Todo>>());
      switch (result) {
        case Success(data: final data):
          expect(data.id, todoId);
          expect(data.title, 'Test Todo');
        case Error():
          fail('Should not be an error');
      }
      verify(mockRepository.getTodoById(todoId)).called(1);
    });

    test('should return failure when repository returns error', () async {
      // arrange
      const failure = ServerFailure('Server error');
      when(mockRepository.getTodoById(todoId))
          .thenAnswer((_) async => const Error<Todo>(failure));

      // act
      final result = await useCase.call(todoId);

      // assert
      expect(result, isA<Error<Todo>>());
      switch (result) {
        case Success():
          fail('Should not be a success');
        case Error(failure: final error):
          expect(error, failure);
      }
      verify(mockRepository.getTodoById(todoId)).called(1);
    });

    test('should return failure when id is negative', () async {
      // arrange
      const invalidId = -1;
      const failure = ServerFailure('Invalid ID');
      when(mockRepository.getTodoById(invalidId))
          .thenAnswer((_) async => const Error<Todo>(failure));

      // act
      final result = await useCase.call(invalidId);

      // assert
      expect(result, isA<Error<Todo>>());
      switch (result) {
        case Success():
          fail('Should not be a success');
        case Error(failure: final error):
          expect(error, isA<ServerFailure>());
      }
      verify(mockRepository.getTodoById(invalidId)).called(1);
    });

    test('should handle network failure', () async {
      // arrange
      const failure = NetworkFailure('Network error');
      when(mockRepository.getTodoById(todoId))
          .thenAnswer((_) async => const Error<Todo>(failure));

      // act
      final result = await useCase.call(todoId);

      // assert
      expect(result, isA<Error<Todo>>());
      switch (result) {
        case Success():
          fail('Should not be a success');
        case Error(failure: final error):
          expect(error, isA<NetworkFailure>());
          expect(error.message, 'Network error');
      }
    });
  });
}
