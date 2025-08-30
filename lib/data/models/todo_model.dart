import 'package:flutter_boilerplate/domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      userId: todo.userId,
      id: todo.id,
      title: todo.title,
      completed: todo.completed,
    );
  }
}
