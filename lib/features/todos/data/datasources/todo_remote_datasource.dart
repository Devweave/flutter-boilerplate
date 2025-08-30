import 'package:flutter_boilerplate/core/network/api_client.dart';
import 'package:flutter_boilerplate/features/todos/data/models/todo_model.dart';
import 'package:injectable/injectable.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel> getTodoById(int id);
  Future<TodoModel> createTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
}

@Injectable(as: TodoRemoteDataSource)
class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final ApiClient _apiClient;

  TodoRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<TodoModel>> getTodos() async {
    final response = await _apiClient.get('/todos');
    final List<dynamic> jsonList = response.data as List<dynamic>;
    return jsonList.map((json) => TodoModel.fromJson(json)).toList();
  }

  @override
  Future<TodoModel> getTodoById(int id) async {
    final response = await _apiClient.get('/todos/$id');
    return TodoModel.fromJson(response.data);
  }

  @override
  Future<TodoModel> createTodo(TodoModel todo) async {
    final response = await _apiClient.post('/todos', data: todo.toJson());
    return TodoModel.fromJson(response.data);
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    final response =
        await _apiClient.put('/todos/${todo.id}', data: todo.toJson());
    return TodoModel.fromJson(response.data);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _apiClient.delete('/todos/$id');
  }
}
