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
  late MockTodoRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTodoRemoteDataSource();
    repository = TodoRepositoryImpl(mockRemoteDataSource);
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
      test('should return list of todos when data source succeeds', () async {
        // arrange
        final todoModels = [todoModel];
        when(mockRemoteDataSource.getTodos())
            .thenAnswer((_) async => todoModels);

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
        verify(mockRemoteDataSource.getTodos()).called(1);
      });

      test('should return server failure when data source throws exception',
          () async {
        // arrange
        when(mockRemoteDataSource.getTodos())
            .thenThrow(Exception('Server error'));

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

      test('should return empty list when data source returns empty list',
          () async {
        // arrange
        when(mockRemoteDataSource.getTodos())
            .thenAnswer((_) async => <TodoModel>[]);

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
    });

    group('getTodoById', () {
      test('should return todo when data source succeeds', () async {
        // arrange
        const todoId = 1;
        when(mockRemoteDataSource.getTodoById(todoId))
            .thenAnswer((_) async => todoModel);

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
        verify(mockRemoteDataSource.getTodoById(todoId)).called(1);
      });

      test('should return server failure when data source throws exception',
          () async {
        // arrange
        const todoId = 1;
        when(mockRemoteDataSource.getTodoById(todoId))
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

    group('updateTodo', () {
      test('should return updated todo when data source succeeds', () async {
        // arrange
        const updatedTodoModel = TodoModel(
          userId: 1,
          id: 1,
          title: 'Updated Todo',
          completed: true,
        );

        when(mockRemoteDataSource.updateTodo(any))
            .thenAnswer((_) async => updatedTodoModel);

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
        verify(mockRemoteDataSource.updateTodo(any)).called(1);
      });

      test('should return server failure when data source throws exception',
          () async {
        // arrange
        when(mockRemoteDataSource.updateTodo(any))
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

      test('should convert todo entity to model correctly', () async {
        // arrange
        const expectedModel = TodoModel(
          userId: 1,
          id: 1,
          title: 'Test Todo',
          completed: false,
        );

        when(mockRemoteDataSource.updateTodo(expectedModel))
            .thenAnswer((_) async => expectedModel);

        // act
        await repository.updateTodo(todo);

        // assert
        verify(mockRemoteDataSource.updateTodo(expectedModel)).called(1);
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
