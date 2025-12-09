# Dependencies

Key dependencies used in Flutter Boilerplate.

## Core Dependencies

### State Management
- **flutter_bloc** (^8.1.3): BLoC pattern implementation
- **freezed** (^2.4.5): Immutable classes

### Dependency Injection
- **injectable** (^2.3.2): Code generation for GetIt
- **get_it** (^7.6.4): Service locator

### Networking
- **dio** (^5.4.0): HTTP client
- **retrofit** (optional): Type-safe REST client

### Routing
- **go_router** (^13.0.0): Declarative routing

### Storage
- **shared_preferences** (^2.2.2): Local storage

### Code Generation
- **build_runner** (^2.4.7): Code generation runner
- **freezed_annotation** (^2.4.1): Freezed annotations
- **json_serializable** (^6.7.1): JSON serialization

## Development Dependencies

### Testing
- **mockito** (^5.4.4): Mocking framework
- **bloc_test** (^9.1.5): BLoC testing utilities

### Code Quality
- **flutter_lints** (^3.0.1): Linting rules

## Updating Dependencies

```bash
# Check outdated
fvm flutter pub outdated

# Update
fvm flutter pub upgrade

# Get dependencies
fvm flutter pub get
```

See `pubspec.yaml` for complete list.
