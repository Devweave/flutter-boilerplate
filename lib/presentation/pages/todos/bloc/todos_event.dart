part of 'todos_bloc.dart';

@freezed
class TodosEvent with _$TodosEvent {
  const factory TodosEvent.loadRequested() = TodosLoadRequested;
  const factory TodosEvent.refreshRequested() = TodosRefreshRequested;
  const factory TodosEvent.toggleCompleted(int todoId) = TodoToggleCompleted;
}
