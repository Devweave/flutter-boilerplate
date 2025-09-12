import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/locator/injectable.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/features/todos/domain/usecases/get_todo_by_id.dart';

class TodoDetailPage extends StatelessWidget {
  final String todoId;

  const TodoDetailPage({
    super.key,
    required this.todoId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
      ),
      body: FutureBuilder<Result<Todo>>(
        future: getIt<GetTodoById>()(int.parse(todoId)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final result = snapshot.data;
          if (result == null) {
            return const Center(child: Text('No data'));
          }

          return switch (result) {
            Success<Todo>() => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  result.data.completed
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: result.data.completed
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  result.data.completed
                                      ? 'Completed'
                                      : 'Pending',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: result.data.completed
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Title',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              result.data.title,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'User ID',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              result.data.userId.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Todo ID',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              result.data.id.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Error<Todo>() => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${result.failure.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
