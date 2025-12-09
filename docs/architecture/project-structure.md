# Project Structure

Understanding the Flutter Boilerplate project structure.

## Directory Overview

```
flutter_boilerplate/
├── android/                    # Android platform code
├── ios/                        # iOS platform code
├── lib/                        # Main application code
│   ├── core/                   # Core utilities and shared code
│   │   ├── error/             # Error handling
│   │   ├── l10n/              # Localization
│   │   ├── locator/           # Dependency injection
│   │   ├── network/           # API client
│   │   ├── router/            # App routing
│   │   ├── services/          # Core services
│   │   ├── theme/             # App theming
│   │   └── utils/             # Utilities
│   ├── features/              # Feature modules
│   │   ├── auth/              # Authentication
│   │   ├── todos/             # Todo management
│   │   └── app/               # App-wide features
│   ├── app.dart               # App configuration
│   └── main.dart              # Entry point
├── test/                       # Test files (mirrors lib/)
├── assets/                     # Static assets
├── docs/                       # Documentation
├── Makefile                    # Development commands
└── pubspec.yaml               # Dependencies
```

## Core Directory

### `/lib/core/error/`

Error handling and failure types:

```
error/
├── exceptions.dart            # Custom exceptions
└── failures.dart              # Failure types
```

### `/lib/core/l10n/`

Internationalization:

```
l10n/
├── arb/
│   ├── app_en.arb            # English translations
│   └── app_id.arb            # Indonesian translations
└── l10n.dart                  # Generated localization
```

### `/lib/core/locator/`

Dependency injection setup:

```
locator/
├── injectable.dart            # Injectable configuration
├── injectable.config.dart     # Generated DI config
└── register_module.dart       # Module registration
```

### `/lib/core/network/`

Network layer:

```
network/
├── api_client.dart            # Dio-based API client
├── interceptors/              # HTTP interceptors
└── network_module.dart        # Network DI module
```

### `/lib/core/router/`

Navigation and routing:

```
router/
├── app_router.dart            # GoRouter configuration
└── app_route_observer.dart    # Route observer
```

### `/lib/core/utils/`

Utility classes:

```
utils/
├── app_logger.dart            # Logging utility
├── base_usecase.dart          # Base use case interface
├── constants.dart             # App constants
├── dio_error_handler.dart     # Error handling utility
├── result.dart                # Result type
└── extensions.dart            # Dart extensions
```

## Feature Structure

Each feature follows Clean Architecture:

```
features/your_feature/
├── data/
│   ├── models/
│   │   └── your_model.dart           # JSON serialization
│   └── repositories/
│       └── your_repository_impl.dart # Repository implementation
├── domain/
│   ├── entities/
│   │   └── your_entity.dart          # Business object
│   ├── repositories/
│   │   └── your_repository.dart      # Repository interface
│   └── usecases/
│       ├── get_items.dart            # Use case
│       └── create_item.dart          # Use case
└── presentation/
    ├── bloc/
    │   ├── your_bloc.dart            # BLoC
    │   ├── your_event.dart           # Events
    │   └── your_state.dart           # States
    ├── pages/
    │   └── your_page.dart            # Full screen view
    └── widgets/
        └── your_widget.dart          # Reusable component
```

## Test Structure

Tests mirror the `lib/` structure:

```
test/
├── core/
│   ├── error/
│   ├── network/
│   └── utils/
├── features/
│   └── todos/
│       ├── data/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   └── usecases/
│       └── presentation/
│           └── bloc/
└── helpers/
    ├── test_mocks.dart           # Mock definitions
    └── test_setup.dart           # Test utilities
```

## Assets Structure

```
assets/
├── fonts/                     # Custom fonts
├── icons/                     # App icons
├── images/                    # Images
└── translations/              # Translation files
```

## Configuration Files

### Root Level

- **`pubspec.yaml`**: Dependencies and assets
- **`Makefile`**: Development commands
- **`analysis_options.yaml`**: Linter rules
- **`.fvmrc`**: Flutter version
- **`api-keys.example.json`**: API keys template

### Platform Specific

- **`android/app/build.gradle`**: Android configuration
- **`ios/Runner/Info.plist`**: iOS configuration
- **`web/index.html`**: Web configuration

## Generated Files

These files are auto-generated (don't edit manually):

```
lib/
├── **/*.freezed.dart          # Freezed code generation
├── **/*.g.dart                # JSON serialization
├── **/*.gr.dart               # Router generation
└── core/locator/injectable.config.dart
```

## File Naming Conventions

- **Dart files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables**: `camelCase`
- **Constants**: `SCREAMING_SNAKE_CASE`
- **Private members**: `_leadingUnderscore`

## Import Organization

```dart
// 1. Dart imports
import 'dart:async';

// 2. Flutter imports
import 'package:flutter/material.dart';

// 3. Package imports
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// 4. Project imports
import 'package:flutter_boilerplate/core/error/failures.dart';
import 'package:flutter_boilerplate/features/todos/domain/entities/todo.dart';

// 5. Relative imports (avoid when possible)
import '../models/todo_model.dart';
```

## Best Practices

1. **Feature Organization**: Keep related code together
2. **Separation of Concerns**: Follow Clean Architecture layers
3. **Test Coverage**: Mirror lib/ structure in test/
4. **Generated Code**: Don't commit conflicts, regenerate
5. **Assets**: Organize by type and feature

## Learn More

- [Clean Architecture](clean-architecture.md)
- [Data Flow](data-flow.md)
- [Adding a Feature](../guides/adding-feature.md)
