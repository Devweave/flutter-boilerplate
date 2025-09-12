import 'package:mockito/mockito.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/features/todos/data/models/todo_model.dart';

/// Setup helpers for tests
/// Call this function in setUpAll() of test files that need dummy values
void setupTestDummies() {
  // Provide dummy values for complex types that Mockito can't auto-generate

  // For Result<List<Todo>>
  provideDummy<Result<List<Todo>>>(
    const Success<List<Todo>>([]),
  );

  // For Result<Todo>
  provideDummy<Result<Todo>>(
    const Success<Todo>(
      Todo(
        userId: 1,
        id: 1,
        title: 'Dummy Todo',
        completed: false,
      ),
    ),
  );

  // For List<TodoModel>
  provideDummy<List<TodoModel>>(
    const [
      TodoModel(
        userId: 1,
        id: 1,
        title: 'Dummy TodoModel',
        completed: false,
      ),
    ],
  );

  // For TodoModel
  provideDummy<TodoModel>(
    const TodoModel(
      userId: 1,
      id: 1,
      title: 'Dummy TodoModel',
      completed: false,
    ),
  );
}
