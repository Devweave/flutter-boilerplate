// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_boilerplate/core/locator/register_module.dart' as _i917;
import 'package:flutter_boilerplate/core/network/api_client.dart' as _i868;
import 'package:flutter_boilerplate/core/network/network_module.dart' as _i594;
import 'package:flutter_boilerplate/core/services/local_storage_service.dart'
    as _i1018;
import 'package:flutter_boilerplate/features/todos/data/datasources/todo_remote_datasource.dart'
    as _i302;
import 'package:flutter_boilerplate/features/todos/data/repositories/todo_repository_impl.dart'
    as _i598;
import 'package:flutter_boilerplate/features/todos/domain/repositories/todo_repository.dart'
    as _i962;
import 'package:flutter_boilerplate/features/auth/domain/usecases/login_usecase.dart'
    as _i878;
import 'package:flutter_boilerplate/features/auth/domain/usecases/logout_usecase.dart'
    as _i955;
import 'package:flutter_boilerplate/features/todos/domain/usecases/get_todo_by_id.dart'
    as _i982;
import 'package:flutter_boilerplate/features/todos/domain/usecases/get_todos.dart' as _i248;
import 'package:flutter_boilerplate/features/todos/domain/usecases/update_todo.dart' as _i497;
import 'package:flutter_boilerplate/features/auth/presentation/bloc/auth_bloc.dart'
    as _i40;
import 'package:flutter_boilerplate/features/todos/presentation/bloc/todos_bloc.dart'
    as _i253;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => registerModule.flutterSecureStorage);
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i868.ApiClient>(() => _i868.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i1018.LocalStorageService>(
        () => _i1018.LocalStorageService(gh<_i558.FlutterSecureStorage>()));
    gh.factory<_i302.TodoRemoteDataSource>(
        () => _i302.TodoRemoteDataSourceImpl(gh<_i868.ApiClient>()));
    gh.factory<_i962.TodoRepository>(
        () => _i598.TodoRepositoryImpl(gh<_i302.TodoRemoteDataSource>()));
    gh.factory<_i878.LoginUseCase>(
        () => _i878.LoginUseCase(gh<_i1018.LocalStorageService>()));
    gh.factory<_i955.LogoutUseCase>(
        () => _i955.LogoutUseCase(gh<_i1018.LocalStorageService>()));
    gh.factory<_i497.UpdateTodo>(
        () => _i497.UpdateTodo(gh<_i962.TodoRepository>()));
    gh.factory<_i248.GetTodos>(
        () => _i248.GetTodos(gh<_i962.TodoRepository>()));
    gh.factory<_i982.GetTodoById>(
        () => _i982.GetTodoById(gh<_i962.TodoRepository>()));
    gh.factory<_i40.AuthBloc>(() => _i40.AuthBloc(
          gh<_i878.LoginUseCase>(),
          gh<_i955.LogoutUseCase>(),
          gh<_i1018.LocalStorageService>(),
        ));
    gh.factory<_i253.TodosBloc>(() => _i253.TodosBloc(
          gh<_i248.GetTodos>(),
          gh<_i497.UpdateTodo>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i917.RegisterModule {}

class _$NetworkModule extends _i594.NetworkModule {}
