import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import 'package:flutter_boilerplate/core/utils/resources.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';
import 'package:flutter_boilerplate/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_mocks.mocks.dart';
import '../../../../helpers/test_setup.dart';

// Custom matchers for Resource states
Matcher isLoadingResource() => predicate<TodosState>(
      (state) => state.todoResource.isLoading,
      'is loading resource',
    );

Matcher isSuccessResource(List<Todo> expectedTodos) => predicate<TodosState>(
      (state) =>
          state.todoResource.isSuccess &&
          state.todoResource.data?.length == expectedTodos.length,
      'is success resource with ${expectedTodos.length} todos',
    );

Matcher isErrorResource(String expectedMessage) => predicate<TodosState>(
      (state) =>
          state.todoResource.isError &&
          state.todoResource.error == expectedMessage,
      'is error resource with message: $expectedMessage',
    );

Matcher isInitialResource() => predicate<TodosState>(
      (state) => state.todoResource.isInitial,
      'is initial resource',
    );

void main() {
  late TodosBloc todosBloc;
  late MockGetTodos mockGetTodos;
  late MockUpdateTodo mockUpdateTodo;

  setUp(() {
    mockGetTodos = MockGetTodos();
    mockUpdateTodo = MockUpdateTodo();
    todosBloc = TodosBloc(mockGetTodos, mockUpdateTodo);
    setupTestDummies();
  });

  tearDown(() {
    todosBloc.close();
  });

  group('TodosBloc', () {
    const todo1 = Todo(
      userId: 1,
      id: 1,
      title: 'Test Todo 1',
      completed: false,
    );

    const todo2 = Todo(
      userId: 1,
      id: 2,
      title: 'Test Todo 2',
      completed: true,
    );

    const todos = [todo1, todo2];

    group('TodosLoadRequested', () {
      blocTest<TodosBloc, TodosState>(
        'emits loading then success when getTodos succeeds',
        build: () {
          when(mockGetTodos.call()).thenAnswer(
            (_) async => const Success(todos),
          );
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodosLoadRequested()),
        expect: () => [
          isLoadingResource(),
          isSuccessResource(todos),
        ],
        verify: (_) {
          verify(mockGetTodos.call()).called(1);
        },
      );

      blocTest<TodosBloc, TodosState>(
        'emits loading then error when getTodos fails',
        build: () {
          when(mockGetTodos.call()).thenAnswer(
            (_) async => const Error(ServerFailure('Server error')),
          );
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodosLoadRequested()),
        expect: () => [
          isLoadingResource(),
          isErrorResource('Server error'),
        ],
        verify: (_) {
          verify(mockGetTodos.call()).called(1);
        },
      );

      blocTest<TodosBloc, TodosState>(
        'emits loading then error when getTodos throws exception',
        build: () {
          when(mockGetTodos.call()).thenThrow(Exception('Unexpected error'));
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodosLoadRequested()),
        expect: () => [
          isLoadingResource(),
          isErrorResource('Exception: Unexpected error'),
        ],
        verify: (_) {
          verify(mockGetTodos.call()).called(1);
        },
      );
    });

    group('TodosRefreshRequested', () {
      blocTest<TodosBloc, TodosState>(
        'emits loading then success when refresh succeeds',
        build: () {
          when(mockGetTodos.call()).thenAnswer(
            (_) async => const Success(todos),
          );
          return todosBloc;
        },
        seed: () => TodosState.initial().copyWith(
          todoResource: Resource.success([todo1]),
        ),
        act: (bloc) => bloc.add(const TodosRefreshRequested()),
        expect: () => [
          isLoadingResource(),
          isSuccessResource(todos),
        ],
        verify: (_) {
          verify(mockGetTodos.call()).called(1);
        },
      );

      blocTest<TodosBloc, TodosState>(
        'emits error when refresh fails',
        build: () {
          when(mockGetTodos.call()).thenAnswer(
            (_) async => const Error(NetworkFailure('Network error')),
          );
          return todosBloc;
        },
        seed: () => TodosState.initial().copyWith(
          todoResource: Resource.success([todo1]),
        ),
        act: (bloc) => bloc.add(const TodosRefreshRequested()),
        expect: () => [
          isLoadingResource(),
          isErrorResource('Network error'),
        ],
        verify: (_) {
          verify(mockGetTodos.call()).called(1);
        },
      );

      blocTest<TodosBloc, TodosState>(
        'emits error when refresh throws exception',
        build: () {
          when(mockGetTodos.call())
              .thenThrow(Exception('Unexpected refresh error'));
          return todosBloc;
        },
        seed: () => TodosState.initial().copyWith(
          todoResource: Resource.success([todo1]),
        ),
        act: (bloc) => bloc.add(const TodosRefreshRequested()),
        expect: () => [
          isLoadingResource(),
          isErrorResource('Exception: Unexpected refresh error'),
        ],
        verify: (_) {
          verify(mockGetTodos.call()).called(1);
        },
      );
    });

    group('TodoToggleCompleted', () {
      const updatedTodo = Todo(
        userId: 1,
        id: 1,
        title: 'Test Todo 1',
        completed: true,
      );

      blocTest<TodosBloc, TodosState>(
        'emits success when toggle todo succeeds',
        build: () {
          when(mockUpdateTodo.call(updatedTodo)).thenAnswer(
            (_) async => const Success(updatedTodo),
          );
          return todosBloc;
        },
        seed: () => TodosState.initial().copyWith(
          todoResource: Resource.success([todo1, todo2]),
        ),
        act: (bloc) => bloc.add(const TodoToggleCompleted(1)),
        expect: () => [
          isSuccessResource([updatedTodo, todo2]),
        ],
        verify: (_) {
          verify(mockUpdateTodo.call(updatedTodo)).called(1);
        },
      );

      blocTest<TodosBloc, TodosState>(
        'emits error when toggle todo fails',
        build: () {
          when(mockUpdateTodo.call(updatedTodo)).thenAnswer(
            (_) async => const Error(ServerFailure('Update failed')),
          );
          return todosBloc;
        },
        seed: () => TodosState.initial().copyWith(
          todoResource: Resource.success([todo1, todo2]),
        ),
        act: (bloc) => bloc.add(const TodoToggleCompleted(1)),
        expect: () => [
          isErrorResource('Update failed'),
        ],
        verify: (_) {
          verify(mockUpdateTodo.call(updatedTodo)).called(1);
        },
      );

      blocTest<TodosBloc, TodosState>(
        'does not emit new state when todo is not found in current list',
        build: () {
          return todosBloc;
        },
        seed: () => TodosState.initial().copyWith(
          todoResource: Resource.success([todo1, todo2]),
        ),
        act: (bloc) => bloc.add(const TodoToggleCompleted(999)),
        expect: () => [],
        verify: (_) {
          verifyNever(mockUpdateTodo.call(any));
        },
      );
    });

    test('initial state should be correct', () {
      expect(todosBloc.state, isInitialResource());
    });
  });
}
