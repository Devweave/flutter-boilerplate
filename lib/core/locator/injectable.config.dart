// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_boilerplate/core/locator/register_module.dart' as _i917;
import 'package:flutter_boilerplate/core/services/local_storage_service.dart'
    as _i1018;
import 'package:flutter_boilerplate/domain/usecases/auth/login/login_usecase.dart'
    as _i878;
import 'package:flutter_boilerplate/domain/usecases/auth/logout/logout_usecase.dart'
    as _i955;
import 'package:flutter_boilerplate/presentation/bloc/auth/auth_bloc.dart'
    as _i40;
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
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => registerModule.flutterSecureStorage);
    gh.lazySingleton<_i1018.LocalStorageService>(
        () => _i1018.LocalStorageService(gh<_i558.FlutterSecureStorage>()));
    gh.factory<_i878.LoginUseCase>(
        () => _i878.LoginUseCase(gh<_i1018.LocalStorageService>()));
    gh.factory<_i955.LogoutUseCase>(
        () => _i955.LogoutUseCase(gh<_i1018.LocalStorageService>()));
    gh.factory<_i40.AuthBloc>(() => _i40.AuthBloc(
          gh<_i878.LoginUseCase>(),
          gh<_i955.LogoutUseCase>(),
          gh<_i1018.LocalStorageService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i917.RegisterModule {}
