# Best Practices

Coding standards and best practices.

## Clean Architecture

1. **Dependency Rule**: Dependencies point inward only
2. **Pure Domain**: No framework dependencies in domain layer
3. **Single Responsibility**: One class, one responsibility
4. **Interface Segregation**: Small, focused interfaces

## Code Style

### Naming Conventions
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables: `camelCase`
- Constants: `SCREAMING_SNAKE_CASE`
- Private: `_leadingUnderscore`

### Imports
```dart
// 1. Dart
import 'dart:async';

// 2. Flutter
import 'package:flutter/material.dart';

// 3. Packages
import 'package:dio/dio.dart';

// 4. Project
import 'package:flutter_boilerplate/core/error/failures.dart';
```

## State Management

1. **Use BLoC**: For complex state
2. **Immutable State**: Use Freezed
3. **Single Source of Truth**: BLoC holds state
4. **Event-Driven**: UI sends events, BLoC emits states

## Error Handling

1. **Use Result<T>**: Type-safe error handling
2. **DioErrorHandler**: Consistent error conversion
3. **User-Friendly Messages**: Show meaningful errors
4. **Log Errors**: Use AppLogger

## Testing

1. **Test Each Layer**: Unit tests for all layers
2. **Mock Dependencies**: Use Mockito
3. **Test Coverage**: Aim for >80%
4. **Integration Tests**: Test critical flows

## Performance

1. **Lazy Loading**: Use `@lazySingleton` for heavy objects
2. **Const Widgets**: Use `const` where possible
3. **ListView.builder**: For long lists
4. **Image Optimization**: Compress images

## Security

1. **Never Commit Secrets**: Use `api-keys.json` (gitignored)
2. **Validate Input**: Always validate user input
3. **HTTPS Only**: Use secure connections
4. **Secure Storage**: Use flutter_secure_storage for sensitive data

## Git

1. **Meaningful Commits**: Descriptive commit messages
2. **Small Commits**: One logical change per commit
3. **Branch Naming**: `feature/`, `bugfix/`, `hotfix/`
4. **Pull Requests**: Code review before merge

See [Clean Architecture](../architecture/clean-architecture.md) for more details.
