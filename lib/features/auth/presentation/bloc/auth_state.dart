part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  factory AuthState({
    required Resource<User> authResource,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
        authResource: Resource.initial(),
      );
}
