import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;

  const TodoItem({
    super.key,
    required this.todo,
    this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: GestureDetector(
          onTap: onToggle,
          child: Icon(
            todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: todo.completed ? Colors.green : Colors.grey,
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? Colors.grey : null,
          ),
        ),
        subtitle: Text('User ID: ${todo.userId}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
