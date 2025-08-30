import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/features/todos/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_boilerplate/features/todos/data/models/todo_model.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/features/todos/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _remoteDataSource;

  TodoRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<Todo>>> getTodos() async {
    try {
      final todos = await _remoteDataSource.getTodos();
      return Success(todos.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Error(_handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Todo>> getTodoById(int id) async {
    try {
      final todo = await _remoteDataSource.getTodoById(id);
      return Success(todo.toEntity());
    } on DioException catch (e) {
      return Error(_handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Todo>> createTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final createdTodo = await _remoteDataSource.createTodo(todoModel);
      return Success(createdTodo.toEntity());
    } on DioException catch (e) {
      return Error(_handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final updatedTodo = await _remoteDataSource.updateTodo(todoModel);
      return Success(updatedTodo.toEntity());
    } on DioException catch (e) {
      return Error(_handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteTodo(int id) async {
    try {
      await _remoteDataSource.deleteTodo(id);
      return const Success(null);
    } on DioException catch (e) {
      return Error(_handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      case DioExceptionType.badResponse:
        return ServerFailure('Server error: ${e.response?.statusCode}');
      default:
        return ServerFailure(e.message ?? 'Unknown error');
    }
  }
}
