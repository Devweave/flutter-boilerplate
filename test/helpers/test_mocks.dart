import 'package:mockito/annotations.dart';
import 'package:flutter_boilerplate/core/services/local_storage_service.dart';
import 'package:flutter_boilerplate/core/network/api_client.dart';
import 'package:flutter_boilerplate/features/todos/domain/repositories/todo_repository.dart';
import 'package:flutter_boilerplate/features/todos/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_boilerplate/features/todos/domain/usecases/get_todos.dart';
import 'package:flutter_boilerplate/features/todos/domain/usecases/get_todo_by_id.dart';
import 'package:flutter_boilerplate/features/todos/domain/usecases/update_todo.dart';
import 'package:flutter_boilerplate/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';

// This file generates all shared mocks used across tests
// Run: fvm dart run build_runner build to generate the mocks

@GenerateMocks([
  // Core services
  LocalStorageService,
  ApiClient,

  // Todo feature
  TodoRepository,
  TodoRemoteDataSource,
  GetTodos,
  GetTodoById,
  UpdateTodo,
  TodosBloc,

  // Auth feature
  LoginUseCase,
  LogoutUseCase,
  AuthBloc,
])
void main() {
  // This is just for mock generation, no actual implementation needed
}
