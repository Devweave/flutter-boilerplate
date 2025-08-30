import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/features/todos/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTodoById {
  final TodoRepository _repository;

  GetTodoById(this._repository);

  Future<Result<Todo>> call(int id) async {
    return await _repository.getTodoById(id);
  }
}
