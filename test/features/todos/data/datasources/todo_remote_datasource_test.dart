import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/features/todos/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_boilerplate/features/todos/data/models/todo_model.dart';
import '../../../../helpers/test_mocks.mocks.dart';
import '../../../../helpers/test_setup.dart';

void main() {
  late TodoRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = TodoRemoteDataSourceImpl(mockApiClient);
    setupTestDummies();
  });

  group('TodoRemoteDataSourceImpl', () {
    const todoModel = TodoModel(
      userId: 1,
      id: 1,
      title: 'Test Todo',
      completed: false,
    );

    group('getTodos', () {
      test('should return list of TodoModel when API call is successful',
          () async {
        // arrange
        final responseData = [
          {'userId': 1, 'id': 1, 'title': 'Test Todo', 'completed': false},
          {'userId': 1, 'id': 2, 'title': 'Test Todo 2', 'completed': true},
        ];

        when(mockApiClient.get('/todos')).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/todos'),
          ),
        );

        // act
        final result = await dataSource.getTodos();

        // assert
        expect(result, isA<List<TodoModel>>());
        expect(result.length, 2);
        expect(result[0].title, 'Test Todo');
        expect(result[1].completed, true);
        verify(mockApiClient.get('/todos')).called(1);
      });

      test('should throw exception when API call fails', () async {
        // arrange
        when(mockApiClient.get('/todos')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/todos'),
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: '/todos'),
            ),
          ),
        );

        // act & assert
        expect(() => dataSource.getTodos(), throwsA(isA<DioException>()));
        verify(mockApiClient.get('/todos')).called(1);
      });

      test('should throw exception when response data is invalid', () async {
        // arrange
        when(mockApiClient.get('/todos')).thenAnswer(
          (_) async => Response(
            data: 'invalid data',
            statusCode: 200,
            requestOptions: RequestOptions(path: '/todos'),
          ),
        );

        // act & assert
        expect(() => dataSource.getTodos(), throwsA(isA<TypeError>()));
      });
    });

    group('getTodoById', () {
      test('should return TodoModel when API call is successful', () async {
        // arrange
        const todoId = 1;
        final responseData = {
          'userId': 1,
          'id': 1,
          'title': 'Test Todo',
          'completed': false,
        };

        when(mockApiClient.get('/todos/$todoId')).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/todos/$todoId'),
          ),
        );

        // act
        final result = await dataSource.getTodoById(todoId);

        // assert
        expect(result, isA<TodoModel>());
        expect(result.id, todoId);
        expect(result.title, 'Test Todo');
        expect(result.completed, false);
        verify(mockApiClient.get('/todos/$todoId')).called(1);
      });

      test('should throw exception when todo is not found', () async {
        // arrange
        const todoId = 999;

        when(mockApiClient.get('/todos/$todoId')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/todos/$todoId'),
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: '/todos/$todoId'),
            ),
          ),
        );

        // act & assert
        expect(
          () => dataSource.getTodoById(todoId),
          throwsA(isA<DioException>()),
        );
        verify(mockApiClient.get('/todos/$todoId')).called(1);
      });
    });

    group('updateTodo', () {
      test('should return updated TodoModel when API call is successful',
          () async {
        // arrange
        const updatedTodo = TodoModel(
          userId: 1,
          id: 1,
          title: 'Updated Todo',
          completed: true,
        );

        final responseData = {
          'userId': 1,
          'id': 1,
          'title': 'Updated Todo',
          'completed': true,
        };

        when(
          mockApiClient.put(
            '/todos/${updatedTodo.id}',
            data: updatedTodo.toJson(),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/todos/${updatedTodo.id}'),
          ),
        );

        // act
        final result = await dataSource.updateTodo(updatedTodo);

        // assert
        expect(result, isA<TodoModel>());
        expect(result.id, updatedTodo.id);
        expect(result.title, 'Updated Todo');
        expect(result.completed, true);
        verify(
          mockApiClient.put(
            '/todos/${updatedTodo.id}',
            data: updatedTodo.toJson(),
          ),
        ).called(1);
      });

      test('should throw exception when update fails', () async {
        // arrange
        when(
          mockApiClient.put(
            '/todos/${todoModel.id}',
            data: todoModel.toJson(),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/todos/${todoModel.id}'),
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: '/todos/${todoModel.id}'),
            ),
          ),
        );

        // act & assert
        expect(
          () => dataSource.updateTodo(todoModel),
          throwsA(isA<DioException>()),
        );
        verify(
          mockApiClient.put(
            '/todos/${todoModel.id}',
            data: todoModel.toJson(),
          ),
        ).called(1);
      });
    });

    group('createTodo', () {
      test('should return created TodoModel when API call is successful',
          () async {
        // arrange
        const newTodo = TodoModel(
          userId: 1,
          id: 0, // Usually 0 for new todos
          title: 'New Todo',
          completed: false,
        );

        final responseData = {
          'userId': 1,
          'id': 201, // Server assigns new ID
          'title': 'New Todo',
          'completed': false,
        };

        when(mockApiClient.post('/todos', data: newTodo.toJson())).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 201,
            requestOptions: RequestOptions(path: '/todos'),
          ),
        );

        // act
        final result = await dataSource.createTodo(newTodo);

        // assert
        expect(result, isA<TodoModel>());
        expect(result.id, 201);
        expect(result.title, 'New Todo');
        expect(result.completed, false);
        expect(result.userId, 1);
        verify(mockApiClient.post('/todos', data: newTodo.toJson())).called(1);
      });

      test('should throw exception when create fails', () async {
        // arrange
        const newTodo = TodoModel(
          userId: 1,
          id: 0,
          title: 'New Todo',
          completed: false,
        );

        when(mockApiClient.post('/todos', data: newTodo.toJson())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/todos'),
            response: Response(
              statusCode: 400,
              requestOptions: RequestOptions(path: '/todos'),
            ),
          ),
        );

        // act & assert
        expect(
          () => dataSource.createTodo(newTodo),
          throwsA(isA<DioException>()),
        );
        verify(mockApiClient.post('/todos', data: newTodo.toJson())).called(1);
      });

      test('should throw exception when response data is invalid for create',
          () async {
        // arrange
        const newTodo = TodoModel(
          userId: 1,
          id: 0,
          title: 'New Todo',
          completed: false,
        );

        when(mockApiClient.post('/todos', data: newTodo.toJson())).thenAnswer(
          (_) async => Response(
            data: 'invalid response',
            statusCode: 201,
            requestOptions: RequestOptions(path: '/todos'),
          ),
        );

        // act & assert
        expect(() => dataSource.createTodo(newTodo), throwsA(isA<TypeError>()));
      });
    });

    group('deleteTodo', () {
      test('should complete successfully when API call is successful',
          () async {
        // arrange
        const todoId = 1;

        when(mockApiClient.delete('/todos/$todoId')).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: '/todos/$todoId'),
          ),
        );

        // act & assert - should not throw
        await expectLater(dataSource.deleteTodo(todoId), completes);
        verify(mockApiClient.delete('/todos/$todoId')).called(1);
      });

      test('should complete successfully even with 204 status code', () async {
        // arrange
        const todoId = 1;

        when(mockApiClient.delete('/todos/$todoId')).thenAnswer(
          (_) async => Response(
            statusCode: 204, // No Content
            requestOptions: RequestOptions(path: '/todos/$todoId'),
          ),
        );

        // act & assert - should not throw
        await expectLater(dataSource.deleteTodo(todoId), completes);
        verify(mockApiClient.delete('/todos/$todoId')).called(1);
      });

      test('should throw exception when delete fails', () async {
        // arrange
        const todoId = 1;

        when(mockApiClient.delete('/todos/$todoId')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/todos/$todoId'),
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: '/todos/$todoId'),
            ),
          ),
        );

        // act & assert
        expect(
          () => dataSource.deleteTodo(todoId),
          throwsA(isA<DioException>()),
        );
        verify(mockApiClient.delete('/todos/$todoId')).called(1);
      });

      test('should throw exception when todo to delete is not found', () async {
        // arrange
        const todoId = 999;

        when(mockApiClient.delete('/todos/$todoId')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/todos/$todoId'),
            response: Response(
              statusCode: 404,
              statusMessage: 'Not Found',
              requestOptions: RequestOptions(path: '/todos/$todoId'),
            ),
          ),
        );

        // act & assert
        expect(
          () => dataSource.deleteTodo(todoId),
          throwsA(isA<DioException>()),
        );
        verify(mockApiClient.delete('/todos/$todoId')).called(1);
      });

      test('should throw exception when delete fails with server error',
          () async {
        // arrange
        const todoId = 1;

        when(mockApiClient.delete('/todos/$todoId')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/todos/$todoId'),
            response: Response(
              statusCode: 500,
              statusMessage: 'Internal Server Error',
              requestOptions: RequestOptions(path: '/todos/$todoId'),
            ),
          ),
        );

        // act & assert
        expect(
          () => dataSource.deleteTodo(todoId),
          throwsA(isA<DioException>()),
        );
        verify(mockApiClient.delete('/todos/$todoId')).called(1);
      });
    });

    group('Error handling', () {
      test('should handle network timeout', () async {
        // arrange
        when(mockApiClient.get('/todos')).thenThrow(
          DioException(
            type: DioExceptionType.connectionTimeout,
            requestOptions: RequestOptions(path: '/todos'),
          ),
        );

        // act & assert
        expect(() => dataSource.getTodos(), throwsA(isA<DioException>()));
      });

      test('should handle no internet connection', () async {
        // arrange
        when(mockApiClient.get('/todos')).thenThrow(
          DioException(
            type: DioExceptionType.connectionError,
            requestOptions: RequestOptions(path: '/todos'),
          ),
        );

        // act & assert
        expect(() => dataSource.getTodos(), throwsA(isA<DioException>()));
      });

      test('should handle network timeout for createTodo', () async {
        // arrange
        const newTodo = TodoModel(
          userId: 1,
          id: 0,
          title: 'New Todo',
          completed: false,
        );

        when(mockApiClient.post('/todos', data: newTodo.toJson())).thenThrow(
          DioException(
            type: DioExceptionType.connectionTimeout,
            requestOptions: RequestOptions(path: '/todos'),
          ),
        );

        // act & assert
        expect(
          () => dataSource.createTodo(newTodo),
          throwsA(isA<DioException>()),
        );
      });

      test('should handle network timeout for deleteTodo', () async {
        // arrange
        const todoId = 1;

        when(mockApiClient.delete('/todos/$todoId')).thenThrow(
          DioException(
            type: DioExceptionType.connectionTimeout,
            requestOptions: RequestOptions(path: '/todos/$todoId'),
          ),
        );

        // act & assert
        expect(
          () => dataSource.deleteTodo(todoId),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}
