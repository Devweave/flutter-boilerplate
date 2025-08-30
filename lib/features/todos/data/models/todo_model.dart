import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
abstract class TodoModel with _$TodoModel {
  const factory TodoModel({
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      userId: todo.userId,
      id: todo.id,
      title: todo.title,
      completed: todo.completed,
    );
  }
}

extension TodoModelX on TodoModel {
  Todo toEntity() {
    return Todo(
      userId: userId,
      id: id,
      title: title,
      completed: completed,
    );
  }
}
