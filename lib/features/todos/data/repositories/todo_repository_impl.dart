import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import 'package:flutter_boilerplate/core/network/api_client.dart';
import 'package:flutter_boilerplate/core/utils/dio_error_handler.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/features/todos/data/models/todo_model.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/features/todos/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final ApiClient _apiClient;

  TodoRepositoryImpl(this._apiClient);

  @override
  Future<Result<List<Todo>>> getTodos() async {
    try {
      final response = await _apiClient.get('/todos');
      final List<dynamic> jsonList = response.data as List<dynamic>;
      final todos = jsonList
          .map((json) => TodoModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList();
      return Success(todos);
    } on DioException catch (e) {
      return Error(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Todo>> getTodoById(int id) async {
    try {
      final response = await _apiClient.get('/todos/$id');
      final todo = TodoModel.fromJson(response.data);
      return Success(todo.toEntity());
    } on DioException catch (e) {
      return Error(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Todo>> createTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final response =
          await _apiClient.post('/todos', data: todoModel.toJson());
      final createdTodo = TodoModel.fromJson(response.data);
      return Success(createdTodo.toEntity());
    } on DioException catch (e) {
      return Error(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final response =
          await _apiClient.put('/todos/${todo.id}', data: todoModel.toJson());
      final updatedTodo = TodoModel.fromJson(response.data);
      return Success(updatedTodo.toEntity());
    } on DioException catch (e) {
      return Error(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteTodo(int id) async {
    try {
      await _apiClient.delete('/todos/$id');
      return const Success(null);
    } on DioException catch (e) {
      return Error(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }
}
