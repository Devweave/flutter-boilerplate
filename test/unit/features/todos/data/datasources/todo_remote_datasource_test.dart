import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/features/todos/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_boilerplate/features/todos/data/models/todo_model.dart';
import '../../../../../helpers/test_mocks.mocks.dart';
import '../../../../../helpers/test_setup.dart';

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

        when(mockApiClient.get('/todos')).thenAnswer((_) async => Response(
              data: responseData,
              statusCode: 200,
              requestOptions: RequestOptions(path: '/todos'),
            ));

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
        when(mockApiClient.get('/todos')).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/todos'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/todos'),
          ),
        ));

        // act & assert
        expect(() => dataSource.getTodos(), throwsA(isA<DioException>()));
        verify(mockApiClient.get('/todos')).called(1);
      });

      test('should throw exception when response data is invalid', () async {
        // arrange
        when(mockApiClient.get('/todos')).thenAnswer((_) async => Response(
              data: 'invalid data',
              statusCode: 200,
              requestOptions: RequestOptions(path: '/todos'),
            ));

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

        when(mockApiClient.get('/todos/$todoId'))
            .thenAnswer((_) async => Response(
                  data: responseData,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/todos/$todoId'),
                ));

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

        when(mockApiClient.get('/todos/$todoId')).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/todos/$todoId'),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/todos/$todoId'),
          ),
        ));

        // act & assert
        expect(
            () => dataSource.getTodoById(todoId), throwsA(isA<DioException>()));
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

        when(mockApiClient.put('/todos/${updatedTodo.id}',
                data: updatedTodo.toJson()))
            .thenAnswer((_) async => Response(
                  data: responseData,
                  statusCode: 200,
                  requestOptions:
                      RequestOptions(path: '/todos/${updatedTodo.id}'),
                ));

        // act
        final result = await dataSource.updateTodo(updatedTodo);

        // assert
        expect(result, isA<TodoModel>());
        expect(result.id, updatedTodo.id);
        expect(result.title, 'Updated Todo');
        expect(result.completed, true);
        verify(mockApiClient.put('/todos/${updatedTodo.id}',
                data: updatedTodo.toJson()))
            .called(1);
      });

      test('should throw exception when update fails', () async {
        // arrange
        when(mockApiClient.put('/todos/${todoModel.id}',
                data: todoModel.toJson()))
            .thenThrow(DioException(
          requestOptions: RequestOptions(path: '/todos/${todoModel.id}'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/todos/${todoModel.id}'),
          ),
        ));

        // act & assert
        expect(() => dataSource.updateTodo(todoModel),
            throwsA(isA<DioException>()));
        verify(mockApiClient.put('/todos/${todoModel.id}',
                data: todoModel.toJson()))
            .called(1);
      });
    });

    group('Error handling', () {
      test('should handle network timeout', () async {
        // arrange
        when(mockApiClient.get('/todos')).thenThrow(DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: '/todos'),
        ));

        // act & assert
        expect(() => dataSource.getTodos(), throwsA(isA<DioException>()));
      });

      test('should handle no internet connection', () async {
        // arrange
        when(mockApiClient.get('/todos')).thenThrow(DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: '/todos'),
        ));

        // act & assert
        expect(() => dataSource.getTodos(), throwsA(isA<DioException>()));
      });
    });
  });
}
