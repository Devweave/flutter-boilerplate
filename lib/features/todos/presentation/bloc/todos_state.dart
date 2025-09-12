part of 'todos_bloc.dart';

@freezed
abstract class TodosState with _$TodosState {
  factory TodosState({
    required Resource<List<Todo>> todoResource,
  }) = _TodosState;

  factory TodosState.initial() => TodosState(
        todoResource: Resource.initial(),
      );
}
