import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/router/app_route_observer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRouteObserver', () {
    late AppRouteObserver observer;

    setUp(() {
      observer = AppRouteObserver();
    });

    test('should be a NavigatorObserver', () {
      expect(observer, isA<NavigatorObserver>());
    });

    test('didPush should not throw when called with routes', () {
      final route = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/test'),
      );
      final previousRoute = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/previous'),
      );

      expect(() => observer.didPush(route, previousRoute), returnsNormally);
    });

    test('didPush should not throw when called with null previousRoute', () {
      final route = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/test'),
      );

      expect(() => observer.didPush(route, null), returnsNormally);
    });

    test('didPop should not throw when called with routes', () {
      final route = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/test'),
      );
      final previousRoute = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/previous'),
      );

      expect(() => observer.didPop(route, previousRoute), returnsNormally);
    });

    test('didPop should not throw when called with null previousRoute', () {
      final route = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/test'),
      );

      expect(() => observer.didPop(route, null), returnsNormally);
    });

    test('didReplace should not throw when called', () {
      final newRoute = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/new'),
      );
      final oldRoute = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/old'),
      );

      expect(
        () => observer.didReplace(newRoute: newRoute, oldRoute: oldRoute),
        returnsNormally,
      );
    });

    test('didReplace should not throw when called with null routes', () {
      expect(
        () => observer.didReplace(newRoute: null, oldRoute: null),
        returnsNormally,
      );
    });

    test('didRemove should not throw when called with routes', () {
      final route = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/test'),
      );
      final previousRoute = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/previous'),
      );

      expect(() => observer.didRemove(route, previousRoute), returnsNormally);
    });

    test('didRemove should not throw when called with null previousRoute', () {
      final route = MaterialPageRoute(
        builder: (context) => Container(),
        settings: const RouteSettings(name: '/test'),
      );

      expect(() => observer.didRemove(route, null), returnsNormally);
    });
  });
}
