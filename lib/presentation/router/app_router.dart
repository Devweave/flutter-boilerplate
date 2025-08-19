import 'package:flutter_boilerplate/presentation/router/app_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: $appRoutes,
    redirect: (context, state) {
      // Add authentication redirect logic here if needed
      return null;
    },
  );
}
