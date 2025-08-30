import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/presentation/pages/home/home_screen.dart';
import 'package:flutter_boilerplate/presentation/pages/home/main_shell.dart';
import 'package:flutter_boilerplate/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_boilerplate/features/todos/presentation/pages/todo_detail_page.dart';
import 'package:flutter_boilerplate/features/todos/presentation/pages/todos_list_page.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

// Shell Route for Bottom Navigation
@TypedShellRoute<MyShellRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: '/home'),
    TypedGoRoute<ProfileRoute>(path: '/profile'),
  ],
)
class MyShellRouteData extends ShellRouteData {
  const MyShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MainShell(child: navigator);
  }
}

// Login Route (outside shell)
@TypedGoRoute<LoginRoute>(
  path: '/login',
)
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

// Profile Route (inside shell)
class ProfileRoute extends GoRouteData with _$ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}

@TypedGoRoute<TodoListRoute>(
  path: '/todos/list',
)
class TodoListRoute extends GoRouteData with _$TodoListRoute {
  const TodoListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TodosListPage();
  }
}

@TypedGoRoute<TodoDetailRoute>(
  path: '/todos/detail/:todoId',
)
class TodoDetailRoute extends GoRouteData with _$TodoDetailRoute {
  final String todoId;

  const TodoDetailRoute({
    required this.todoId,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TodoDetailPage(todoId: todoId);
  }
}
