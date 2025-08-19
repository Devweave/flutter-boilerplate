import 'package:flutter_boilerplate/core/services/local_storage_service.dart';
import 'package:flutter_boilerplate/domain/usecases/auth/login/login_usecase.dart';
import 'package:flutter_boilerplate/domain/usecases/auth/logout/logout_usecase.dart';
import 'package:flutter_boilerplate/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection(
    SharedPreferences sharedPreferences) async {
  // Register SharedPreferences instance
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register services
  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(getIt<SharedPreferences>()),
  );

  // Register use cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<LocalStorageService>()),
  );

  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<LocalStorageService>()),
  );

  // Register blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      getIt<LoginUseCase>(),
      getIt<LogoutUseCase>(),
      getIt<LocalStorageService>(),
    ),
  );
}
