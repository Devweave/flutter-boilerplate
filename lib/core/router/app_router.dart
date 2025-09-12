import 'app_route_observer.dart';
import 'app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: $appRoutes,
    redirect: (context, state) {
      Logger().i(
        'State: ${state.name}\n Route: ${state.uri}',
      );
      final uri = state.uri;

      // If scheme present, drop it and keep only the path
      if (uri.hasScheme) {
        return uri.path + (uri.hasQuery ? '?${uri.query}' : '');
      }

      return null;
    },
    observers: [AppRouteObserver()],
  );
}
