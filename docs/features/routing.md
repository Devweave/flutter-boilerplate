# Routing

Navigation and routing using GoRouter.

## Overview

Flutter Boilerplate uses GoRouter for declarative routing with deep linking support.

## Route Configuration

Routes are defined in `lib/core/router/app_router.dart`:

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/todos',
      builder: (context, state) => const TodosPage(),
    ),
  ],
);
```

## Navigation

```dart
// Navigate to route
context.go('/todos');

// Navigate with parameters
context.go('/todos/${todo.id}');

// Go back
context.pop();
```

## Learn More

- [GoRouter Documentation](https://pub.dev/packages/go_router)
