# flutter_boilerplate

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Folder Structure
``` 
├── l10n.yaml
├── lib
│   ├── app.dart
│   ├── core
│   │   ├── exceptions
│   │   ├── l10n
│   │   │   └── arb
│   │   │       └── app_id.arb
│   │   ├── locator
│   │   │   ├── injectable.config.dart
│   │   │   └── injectable.dart
│   │   └── utils
│   │       ├── resource.dart
│   ├── domain
│   │   ├── entities
│   │   │   └── user
│   │   │       ├── user.dart
│   │   │       ├── user.freezed.dart
│   │   │       └── user.g.dart
│   │   └── usecases
│   │       ├── auth
│   │       │   ├── login_with_google
│   │       │   │   └── login_with_google.dart
│   │       └── base_usecase.dart
│   ├── main.dart
│   └── presentation
│       ├── bloc
│       │   ├── providers.dart
│       │   └── auth
│       │       ├── auth_bloc.dart
│       │       ├── auth_bloc.freezed.dart
│       │       └── auth_state.dart
│       │       └── auth_event.dart
│       ├── pages
│       │   ├── login
│       │   │   ├── bloc
│       │   │   │   ├── login_bloc.dart
│       │   │   │   ├── login_bloc.freezed.dart
│       │   │   │   └── login_state.dart
│       │   │   │   └── login_event.dart
│       │   │   ├── login_screen.dart
│       │   └── pages.dart
│       ├── router
│       │   ├── app_route_observer.dart
│       │   ├── app_router.dart
│       │   ├── app_routes.dart
│       │   └── app_routes.g.dart
│       ├── theme
│       │   ├── app_colors.dart
│       │   └── app_theme.dart
│       ├── utils
│       │   ├── app_bloc_observer.dart
│       │   └── semantic_label_constant.dart
│       └── widgets
├── pubspec.yaml
└── test 
    ├── domain
    │   └── usecases
    │       └── auth
    │           └── login_with_google_test.dart
    └── presentation
        └── pages
            └── login
                ├── login_cubit_test.dart
                └── login_page_test.dart
```

