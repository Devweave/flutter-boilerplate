import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/domain/entities/todo.dart';
import 'package:flutter_boilerplate/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTodos {
  final TodoRepository _repository;

  GetTodos(this._repository);

  Future<Result<List<Todo>>> call() async {
    return await _repository.getTodos();
  }
}
