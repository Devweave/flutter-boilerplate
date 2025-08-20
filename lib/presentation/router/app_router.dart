import 'package:flutter_boilerplate/presentation/router/app_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: $appRoutes,
    redirect: (context, state) {
      return null;
    },
  );
}
