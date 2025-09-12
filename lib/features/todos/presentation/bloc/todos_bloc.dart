import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/utils/resources.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/features/todos/domain/usecases/get_todos.dart';
import 'package:flutter_boilerplate/features/todos/domain/usecases/update_todo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'todos_event.dart';
part 'todos_state.dart';
part 'todos_bloc.freezed.dart';

@injectable
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final GetTodos _getTodos;
  final UpdateTodo _updateTodo;

  TodosBloc(
    this._getTodos,
    this._updateTodo,
  ) : super(TodosState.initial()) {
    on<TodosLoadRequested>(_onTodosLoadRequested);
    on<TodosRefreshRequested>(_onTodosRefreshRequested);
    on<TodoToggleCompleted>(_onTodoToggleCompleted);
  }

  Future<void> _onTodosLoadRequested(
    TodosLoadRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(todoResource: Resource.loading()));

    try {
      final result = await _getTodos();

      switch (result) {
        case Success<List<Todo>>():
          emit(state.copyWith(todoResource: Resource.success(result.data)));
        case Error<List<Todo>>():
          emit(
            state.copyWith(
              todoResource: Resource.error(result.failure.message),
            ),
          );
      }
    } catch (e) {
      emit(state.copyWith(todoResource: Resource.error(e.toString())));
    }
  }

  Future<void> _onTodosRefreshRequested(
    TodosRefreshRequested event,
    Emitter<TodosState> emit,
  ) async {
    emit(state.copyWith(todoResource: Resource.loading()));

    try {
      final result = await _getTodos();

      switch (result) {
        case Success<List<Todo>>():
          emit(state.copyWith(todoResource: Resource.success(result.data)));
        case Error<List<Todo>>():
          emit(
            state.copyWith(
              todoResource: Resource.error(result.failure.message),
            ),
          );
      }
    } catch (e) {
      emit(state.copyWith(todoResource: Resource.error(e.toString())));
    }
  }

  Future<void> _onTodoToggleCompleted(
    TodoToggleCompleted event,
    Emitter<TodosState> emit,
  ) async {
    final todoResource = state.todoResource;

    if (todoResource.isSuccess) {
      final todos = todoResource.data!;
      final todoIndex = todos.indexWhere((todo) => todo.id == event.todoId);

      if (todoIndex != -1) {
        final todo = todos[todoIndex];
        final updatedTodo = todo.copyWith(completed: !todo.completed);

        final result = await _updateTodo(updatedTodo);

        switch (result) {
          case Success<Todo>():
            final updatedTodos = List<Todo>.from(todos);
            updatedTodos[todoIndex] = result.data;
            emit(state.copyWith(todoResource: Resource.success(updatedTodos)));
          case Error<Todo>():
            emit(
              state.copyWith(
                todoResource: Resource.error(result.failure.message),
              ),
            );
        }
      }
    }
  }
}
