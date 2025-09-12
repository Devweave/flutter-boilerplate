// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $myShellRouteData,
      $loginRoute,
      $todoListRoute,
      $todoDetailRoute,
    ];

RouteBase get $myShellRouteData => ShellRouteData.$route(
      factory: $MyShellRouteDataExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/home',
          factory: _$HomeRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/profile',
          factory: _$ProfileRoute._fromState,
        ),
      ],
    );

extension $MyShellRouteDataExtension on MyShellRouteData {
  static MyShellRouteData _fromState(GoRouterState state) =>
      const MyShellRouteData();
}

mixin _$HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location(
        '/home',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location(
        '/profile',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: _$LoginRoute._fromState,
    );

mixin _$LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location(
        '/login',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $todoListRoute => GoRouteData.$route(
      path: '/todos/list',
      factory: _$TodoListRoute._fromState,
    );

mixin _$TodoListRoute on GoRouteData {
  static TodoListRoute _fromState(GoRouterState state) => const TodoListRoute();

  @override
  String get location => GoRouteData.$location(
        '/todos/list',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $todoDetailRoute => GoRouteData.$route(
      path: '/todos/detail/:todoId',
      factory: _$TodoDetailRoute._fromState,
    );

mixin _$TodoDetailRoute on GoRouteData {
  static TodoDetailRoute _fromState(GoRouterState state) => TodoDetailRoute(
        todoId: state.pathParameters['todoId']!,
      );

  TodoDetailRoute get _self => this as TodoDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/todos/detail/${Uri.encodeComponent(_self.todoId)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
