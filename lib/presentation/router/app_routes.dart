import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/locator/injectable.dart';
import 'package:flutter_boilerplate/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_boilerplate/presentation/pages/home/home_screen.dart';
import 'package:flutter_boilerplate/presentation/pages/login/login_screen.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

@TypedGoRoute<LoginRoute>(
  path: '/login',
)
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: const LoginScreen(),
    );
  }
}

@TypedGoRoute<HomeRoute>(
  path: '/home',
)
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: const HomeScreen(),
    );
  }
}
