import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/services/local_storage_service.dart';
import 'package:flutter_boilerplate/core/utils/base_usecase.dart';
import 'package:flutter_boilerplate/core/utils/resources.dart';
import 'package:flutter_boilerplate/features/auth/domain/entities/user.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/logout_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final LocalStorageService _localStorageService;

  AuthBloc(
    this._loginUseCase,
    this._logoutUseCase,
    this._localStorageService,
  ) : super(AuthState.initial()) {
    on<_CheckAuthStatus>(_onCheckAuthStatus);
    on<_Login>(_onLogin);
    on<_Logout>(_onLogout);
  }

  Future<void> _onCheckAuthStatus(
    _CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authResource: Resource.loading()));

    final isLoggedIn = await _localStorageService.isLoggedIn();
    if (isLoggedIn) {
      final userData = await _localStorageService.getUserData();
      if (userData != null) {
        try {
          final user = User.fromJson(userData);
          emit(
            state.copyWith(
              authResource: Resource.success(user),
            ),
          );
        } catch (e) {
          await _localStorageService.clearUserData();
          emit(
            state.copyWith(
              authResource: Resource.error('Invalid user data'),
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            authResource: Resource.error('No user data found'),
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          authResource: Resource.error('Not logged in'),
        ),
      );
    }
  }

  Future<void> _onLogin(_Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authResource: Resource.loading()));

    await Future.delayed(const Duration(seconds: 5));

    final result = await _loginUseCase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.when(
      initial: () => emit(state.copyWith(authResource: Resource.initial())),
      loading: () => emit(state.copyWith(authResource: Resource.loading())),
      success: (user) => emit(
        state.copyWith(
          authResource: Resource.success(user),
        ),
      ),
      error: (message) => emit(
        state.copyWith(
          authResource: Resource.error(message),
        ),
      ),
    );
  }

  Future<void> _onLogout(_Logout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authResource: Resource.loading()));

    final result = await _logoutUseCase(const NoParams());

    result.when(
      initial: () => emit(state.copyWith(authResource: Resource.initial())),
      loading: () => emit(state.copyWith(authResource: Resource.loading())),
      success: (_) => emit(
        state.copyWith(
          authResource: Resource.initial(),
        ),
      ),
      error: (message) => emit(
        state.copyWith(
          authResource: Resource.error(message),
        ),
      ),
    );
  }
}
