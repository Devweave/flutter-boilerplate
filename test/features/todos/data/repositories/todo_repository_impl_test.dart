import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_boilerplate/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:flutter_boilerplate/features/todos/data/models/todo_model.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import '../../../../helpers/test_mocks.mocks.dart';
import '../../../../helpers/test_setup.dart';

void main() {
  late TodoRepositoryImpl repository;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    repository = TodoRepositoryImpl(mockApiClient);
    setupTestDummies();
  });

  group('TodoRepositoryImpl', () {
    const todoModel = TodoModel(
      userId: 1,
      id: 1,
      title: 'Test Todo',
      completed: false,
    );

    const todo = Todo(
      userId: 1,
      id: 1,
      title: 'Test Todo',
      completed: false,
    );

    group('getTodos', () {
      test('should return list of todos when API call succeeds', () async {
        // arrange
        final responseData = [todoModel.toJson()];
        final response = Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos'),
        );
        when(mockApiClient.get('/todos')).thenAnswer((_) async => response);

        // act
        final result = await repository.getTodos();

        // assert
        expect(result, isA<Success<List<Todo>>>());
        switch (result) {
          case Success(data: final todos):
            expect(todos.length, 1);
            expect(todos.first.id, 1);
            expect(todos.first.title, 'Test Todo');
          case Error():
            fail('Should not be an error');
        }
        verify(mockApiClient.get('/todos')).called(1);
      });

      test('should return server failure when API throws exception', () async {
        // arrange
        when(mockApiClient.get('/todos')).thenThrow(Exception('Server error'));

        // act
        final result = await repository.getTodos();

        // assert
        expect(result, isA<Error<List<Todo>>>());
        switch (result) {
          case Success():
            fail('Should not be a success');
          case Error(failure: final error):
            expect(error, isA<ServerFailure>());
            expect(error.message, 'Exception: Server error');
        }
      });

      test('should return empty list when API returns empty list', () async {
        // arrange
        final response = Response(
          data: <dynamic>[],
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos'),
        );
        when(mockApiClient.get('/todos')).thenAnswer((_) async => response);

        // act
        final result = await repository.getTodos();

        // assert
        expect(result, isA<Success<List<Todo>>>());
        switch (result) {
          case Success(data: final todos):
            expect(todos, isEmpty);
          case Error():
            fail('Should not be an error');
        }
      });

      test('should handle DioException correctly', () async {
        // arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/todos'),
          type: DioExceptionType.connectionTimeout,
        );
        when(mockApiClient.get('/todos')).thenThrow(dioException);

        // act
        final result = await repository.getTodos();

        // assert
        expect(result, isA<Error<List<Todo>>>());
        switch (result) {
          case Success():
            fail('Should not be a success');
          case Error(failure: final error):
            expect(error, isA<NetworkFailure>());
            expect(error.message, 'Connection timeout');
        }
      });
    });

    group('getTodoById', () {
      test('should return todo when API call succeeds', () async {
        // arrange
        const todoId = 1;
        final response = Response(
          data: todoModel.toJson(),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos/$todoId'),
        );
        when(mockApiClient.get('/todos/$todoId'))
            .thenAnswer((_) async => response);

        // act
        final result = await repository.getTodoById(todoId);

        // assert
        expect(result, isA<Success<Todo>>());
        switch (result) {
          case Success(data: final todo):
            expect(todo.id, todoId);
            expect(todo.title, 'Test Todo');
          case Error():
            fail('Should not be an error');
        }
        verify(mockApiClient.get('/todos/$todoId')).called(1);
      });

      test('should return server failure when API throws exception', () async {
        // arrange
        const todoId = 1;
        when(mockApiClient.get('/todos/$todoId'))
            .thenThrow(Exception('Todo not found'));

        // act
        final result = await repository.getTodoById(todoId);

        // assert
        expect(result, isA<Error<Todo>>());
        switch (result) {
          case Success():
            fail('Should not be a success');
          case Error(failure: final error):
            expect(error, isA<ServerFailure>());
            expect(error.message, 'Exception: Todo not found');
        }
      });
    });

    group('createTodo', () {
      test('should return created todo when API call succeeds', () async {
        // arrange
        final response = Response(
          data: todoModel.toJson(),
          statusCode: 201,
          requestOptions: RequestOptions(path: '/todos'),
        );
        when(mockApiClient.post('/todos', data: anyNamed('data')))
            .thenAnswer((_) async => response);

        // act
        final result = await repository.createTodo(todo);

        // assert
        expect(result, isA<Success<Todo>>());
        switch (result) {
          case Success(data: final createdTodo):
            expect(createdTodo.id, 1);
            expect(createdTodo.title, 'Test Todo');
          case Error():
            fail('Should not be an error');
        }
      });
    });

    group('updateTodo', () {
      test('should return updated todo when API call succeeds', () async {
        // arrange
        const updatedTodoModel = TodoModel(
          userId: 1,
          id: 1,
          title: 'Updated Todo',
          completed: true,
        );
        final response = Response(
          data: updatedTodoModel.toJson(),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/todos/1'),
        );
        when(mockApiClient.put('/todos/${todo.id}', data: anyNamed('data')))
            .thenAnswer((_) async => response);

        // act
        final result = await repository.updateTodo(todo);

        // assert
        expect(result, isA<Success<Todo>>());
        switch (result) {
          case Success(data: final updatedTodo):
            expect(updatedTodo.id, 1);
            expect(updatedTodo.title, 'Updated Todo');
            expect(updatedTodo.completed, true);
          case Error():
            fail('Should not be an error');
        }
      });

      test('should return server failure when API throws exception', () async {
        // arrange
        when(mockApiClient.put('/todos/${todo.id}', data: anyNamed('data')))
            .thenThrow(Exception('Update failed'));

        // act
        final result = await repository.updateTodo(todo);

        // assert
        expect(result, isA<Error<Todo>>());
        switch (result) {
          case Success():
            fail('Should not be a success');
          case Error(failure: final error):
            expect(error, isA<ServerFailure>());
            expect(error.message, 'Exception: Update failed');
        }
      });
    });

    group('deleteTodo', () {
      test('should complete successfully when API call succeeds', () async {
        // arrange
        const todoId = 1;
        final response = Response(
          data: null,
          statusCode: 204,
          requestOptions: RequestOptions(path: '/todos/$todoId'),
        );
        when(mockApiClient.delete('/todos/$todoId'))
            .thenAnswer((_) async => response);

        // act
        final result = await repository.deleteTodo(todoId);

        // assert
        expect(result, isA<Success<void>>());
        verify(mockApiClient.delete('/todos/$todoId')).called(1);
      });

      test('should return server failure when API throws exception', () async {
        // arrange
        const todoId = 1;
        when(mockApiClient.delete('/todos/$todoId'))
            .thenThrow(Exception('Delete failed'));

        // act
        final result = await repository.deleteTodo(todoId);

        // assert
        expect(result, isA<Error<void>>());
        switch (result) {
          case Success():
            fail('Should not be a success');
          case Error(failure: final error):
            expect(error, isA<ServerFailure>());
        }
      });
    });

    group('Model to Entity conversion', () {
      test('should convert TodoModel to Todo correctly', () {
        // arrange
        const model = TodoModel(
          userId: 2,
          id: 3,
          title: 'Convert Test',
          completed: true,
        );

        // act
        final entity = model.toEntity();

        // assert
        expect(entity.userId, 2);
        expect(entity.id, 3);
        expect(entity.title, 'Convert Test');
        expect(entity.completed, true);
      });

      test('should convert Todo to TodoModel correctly', () {
        // arrange
        const entity = Todo(
          userId: 4,
          id: 5,
          title: 'Entity Test',
          completed: false,
        );

        // act
        final model = TodoModel.fromEntity(entity);

        // assert
        expect(model.userId, 4);
        expect(model.id, 5);
        expect(model.title, 'Entity Test');
        expect(model.completed, false);
      });
    });
  });
}
