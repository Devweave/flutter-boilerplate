import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_boilerplate/features/todos/domain/usecases/update_todo.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import '../../../../helpers/test_mocks.mocks.dart';
import '../../../../helpers/test_setup.dart';

void main() {
  late UpdateTodo useCase;
  late MockTodoRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoRepository();
    useCase = UpdateTodo(mockRepository);
    setupTestDummies();
  });

  group('UpdateTodo', () {
    const todo = Todo(
      userId: 1,
      id: 1,
      title: 'Updated Todo',
      completed: true,
    );

    test('should update todo in repository when todo is valid', () async {
      // arrange
      when(mockRepository.updateTodo(todo))
          .thenAnswer((_) async => const Success(todo));

      // act
      final result = await useCase.call(todo);

      // assert
      expect(result, isA<Success<Todo>>());
      switch (result) {
        case Success(data: final data):
          expect(data.id, todo.id);
          expect(data.title, 'Updated Todo');
          expect(data.completed, true);
        case Error():
          fail('Should not be an error');
      }
      verify(mockRepository.updateTodo(todo)).called(1);
    });

    test('should return failure when repository returns error', () async {
      // arrange
      const failure = ServerFailure('Update failed');
      when(mockRepository.updateTodo(todo))
          .thenAnswer((_) async => const Error<Todo>(failure));

      // act
      final result = await useCase.call(todo);

      // assert
      expect(result, isA<Error<Todo>>());
      switch (result) {
        case Success():
          fail('Should not be a success');
        case Error(failure: final error):
          expect(error, failure);
          expect(error.message, 'Update failed');
      }
      verify(mockRepository.updateTodo(todo)).called(1);
    });

    test('should handle network failure during update', () async {
      // arrange
      const failure = NetworkFailure('Network error');
      when(mockRepository.updateTodo(todo))
          .thenAnswer((_) async => const Error<Todo>(failure));

      // act
      final result = await useCase.call(todo);

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

    test('should handle cache failure during update', () async {
      // arrange
      const failure = CacheFailure('Cache error');
      when(mockRepository.updateTodo(todo))
          .thenAnswer((_) async => const Error<Todo>(failure));

      // act
      final result = await useCase.call(todo);

      // assert
      expect(result, isA<Error<Todo>>());
      switch (result) {
        case Success():
          fail('Should not be a success');
        case Error(failure: final error):
          expect(error, isA<CacheFailure>());
          expect(error.message, 'Cache error');
      }
    });

    test('should update different todo properties correctly', () async {
      // arrange
      const updatedTodo = Todo(
        userId: 1,
        id: 2,
        title: 'New Title',
        completed: false,
      );
      when(mockRepository.updateTodo(updatedTodo))
          .thenAnswer((_) async => const Success(updatedTodo));

      // act
      final result = await useCase.call(updatedTodo);

      // assert
      expect(result, isA<Success<Todo>>());
      switch (result) {
        case Success(data: final data):
          expect(data.id, 2);
          expect(data.title, 'New Title');
          expect(data.completed, false);
        case Error():
          fail('Should not be an error');
      }
    });
  });
}
