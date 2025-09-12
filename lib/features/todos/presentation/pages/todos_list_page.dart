import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/locator/injectable.dart';
import 'package:flutter_boilerplate/core/router/app_routes.dart';
import 'package:flutter_boilerplate/core/utils/enum.dart';
import 'package:flutter_boilerplate/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:flutter_boilerplate/features/todos/presentation/widgets/todo_item.dart';
import 'package:flutter_boilerplate/features/todos/presentation/widgets/todos_empty.dart';

class TodosListView extends StatelessWidget {
  const TodosListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          BlocBuilder<TodosBloc, TodosState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: state.todoResource.status == ResourceStatus.loading
                    ? null
                    : () => context
                        .read<TodosBloc>()
                        .add(const TodosRefreshRequested()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          return switch (state.todoResource.status) {
            ResourceStatus.initial => const Center(
                child: Text('Welcome to Todos'),
              ),
            ResourceStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            ResourceStatus.success => (state.todoResource.data ?? []).isEmpty
                ? const TodosEmpty()
                : RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<TodosBloc>()
                          .add(const TodosRefreshRequested());
                    },
                    child: ListView.builder(
                      itemCount: state.todoResource.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final todo = state.todoResource.data![index];
                        return TodoItem(
                          todo: todo,
                          onTap: () => TodoDetailRoute(todoId: '${todo.id}')
                              .push(context),
                          onToggle: () => context
                              .read<TodosBloc>()
                              .add(TodoToggleCompleted(todo.id)),
                        );
                      },
                    ),
                  ),
            ResourceStatus.failed => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.todoResource.error}',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context
                          .read<TodosBloc>()
                          .add(const TodosLoadRequested()),
                      child: const Text('Retry'),
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

class TodosListPage extends StatelessWidget {
  const TodosListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TodosBloc>()..add(const TodosLoadRequested()),
      child: const TodosListView(),
    );
  }
}
