# Flutter Boilerplate

![Coverage](coverage_badge.svg) [![Build Status](https://github.com/Devweave/flutter-boilerplate/actions/workflows/ci.yml/badge.svg)](https://github.com/Devweave/flutter-boilerplate/actions)

A production-ready Flutter boilerplate project implementing Clean Architecture with comprehensive testing, modern development practices, and developer-friendly tooling.

## 🚀 Features

- **Clean Architecture** - Separation of concerns with domain, data, and presentation layers
- **State Management** - BLoC pattern with flutter_bloc
- **Dependency Injection** - get_it with injectable for automatic DI setup
- **Code Generation** - Freezed for immutable classes and JSON serialization
- **Routing** - go_router for declarative navigation
- **Testing** - Comprehensive test suite with 31.8% code coverage
- **Internationalization** - Multi-language support with flutter_localizations
- **Network Layer** - Dio for HTTP requests with interceptors
- **Local Storage** - Secure storage with flutter_secure_storage
- **Development Tools** - Makefile automation, FVM for Flutter version management
- **Code Quality** - Analysis options, formatting, and linting rules

## 🏗️ Architecture

This project follows **Clean Architecture** principles:

```
lib/
├── core/                          # Core utilities and shared code
│   ├── error/                     # Error handling and custom exceptions
│   ├── l10n/                      # Localization files
│   ├── locator/                   # Dependency injection setup
│   ├── network/                   # API client and network configuration
│   ├── services/                  # Core services (storage, etc.)
│   └── utils/                     # Utility classes and helpers
├── features/                      # Feature modules
│   ├── auth/                      # Authentication feature
│   │   ├── data/                  # Data layer (models, repositories, data sources)
│   │   ├── domain/                # Domain layer (entities, use cases, repositories)
│   │   └── presentation/          # Presentation layer (pages, widgets, BLoC)
│   ├── todos/                     # Todo management feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── app/                       # App-wide presentation (theme, routing)
│       └── presentation/
├── app.dart                       # App configuration and setup
└── main.dart                      # Application entry point
```

## 📋 Prerequisites

- **Flutter SDK**: 3.32.4 (managed with FVM)
- **Dart SDK**: >=3.3.3 <4.0.0
- **FVM**: For Flutter version management
- **Make**: For build automation (optional but recommended)

## 🛠️ Getting Started

> **📌 Quick Start:** After cloning, **ALWAYS run `make bootstrap`** to set up git hooks and project dependencies.

### 1. Clone the repository
```bash
git clone https://github.com/Devweave/flutter-boilerplate.git
cd flutter-boilerplate
```

### 2. Setup Flutter version (with FVM)
```bash
fvm install 3.32.4
fvm use 3.32.4
```

### 3. Bootstrap the project ⚠️ **REQUIRED**
```bash
make bootstrap
```

**⚠️ IMPORTANT:** This step is **required** for all new clones. It will:
- Install dependencies
- Generate code
- **Setup git pre-commit hooks** (runs `make format && make analyze`)
- Configure the development environment

**Without running this command, git hooks won't work and code quality checks will be skipped.**

### 4. Setup API keys
```bash
cp api-keys.example.json api-keys.json
# Edit api-keys.json with your actual API keys
```

### 5. Run the application
```bash
make run
```

## 🔧 Development Tools

### Makefile Commands

| Command | Description |
|---------|-------------|
| `make help` | Show all available commands |
| `make bootstrap` | Complete project setup (deps, gen, git hooks) |
| `make deps` | Get dependencies |
| `make gen` | Generate code (build_runner) |
| `make clean` | Clean project and cache |
| `make test` | Run tests with coverage |
| `make analyze` | Analyze code |
| `make format` | Format code |
| `make run` | Run the application |
| `make build` | Build APK |
| `make coverage` | Generate HTML coverage report |
| `make check` | Run format, analyze, and test |
| `make rename` | Rename app and bundle ID |
| `make setup-git-hooks` | Setup git pre-commit hooks |

### Without Make

If you prefer not to use Make:

```bash
# Get dependencies
fvm flutter pub get

# Generate code
fvm dart run build_runner build --delete-conflicting-outputs

# Run tests
fvm flutter test --coverage

# Analyze code
fvm flutter analyze

# Format code
fvm dart format lib/ test/ --set-exit-if-changed

# Run app
fvm flutter run --dart-define-from-file=api-keys.json
```

## 🧪 Testing

The project includes comprehensive tests across all architectural layers:

- **Unit Tests**: Core utilities, entities, models, repositories, use cases
- **Integration Tests**: Repository implementations, data sources
- **Widget Tests**: UI components and pages
- **Test Helpers**: Shared mocks and test utilities

### Running Tests

```bash
# Run all tests with coverage
make test

# Generate coverage report
make coverage

# Run specific test files
fvm flutter test test/unit/features/auth/
```

### Test Structure

```
test/
├── helpers/                       # Shared test utilities
│   ├── test_mocks.dart           # Mock definitions
│   ├── test_mocks.mocks.dart     # Generated mocks
│   └── test_setup.dart           # Test setup utilities
├── unit/                         # Unit tests
│   ├── core/                     # Core layer tests
│   └── features/                 # Feature tests by layer
├── widget_test.dart              # Widget tests
└── integration/                  # Integration tests (future)
```

## 📱 Project Structure

<details>
<summary>Detailed Folder Structure</summary>

```
├── android/                      # Android platform files
├── ios/                          # iOS platform files
├── linux/                       # Linux platform files
├── macos/                        # macOS platform files
├── web/                          # Web platform files
├── windows/                      # Windows platform files
├── lib/
│   ├── core/
│   │   ├── error/
│   │   │   └── failures.dart
│   │   ├── l10n/                 # Localization
│   │   │   ├── arb/
│   │   │   └── app_localizations.dart
│   │   ├── locator/              # Dependency injection
│   │   │   ├── injectable.dart
│   │   │   ├── injectable.config.dart
│   │   │   └── register_module.dart
│   │   ├── network/              # Network layer
│   │   │   ├── api_client.dart
│   │   │   └── network_module.dart
│   │   ├── services/             # Core services
│   │   │   └── local_storage_service.dart
│   │   └── utils/                # Utilities
│   │       ├── base_usecase.dart
│   │       ├── constants.dart
│   │       ├── enum.dart
│   │       ├── extensions.dart
│   │       ├── resources.dart
│   │       └── result.dart
│   ├── features/
│   │   ├── app/                  # App-wide features
│   │   │   └── presentation/
│   │   │       ├── pages/home/
│   │   │       ├── router/
│   │   │       ├── theme/
│   │   │       └── utils/
│   │   ├── auth/                 # Authentication feature
│   │   │   ├── data/
│   │   │   │   └── models/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   └── usecases/
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       └── pages/
│   │   └── todos/                # Todo feature
│   │       ├── data/
│   │       │   ├── datasources/
│   │       │   ├── models/
│   │       │   └── repositories/
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   ├── repositories/
│   │       │   └── usecases/
│   │       └── presentation/
│   │           ├── bloc/
│   │           ├── pages/
│   │           └── widgets/
│   ├── app.dart
│   └── main.dart
├── test/                         # Test files
├── coverage/                     # Coverage reports
├── hooks/                        # Git hooks (version controlled)
│   ├── pre-commit               # Pre-commit hook script
│   ├── pre-push                 # Pre-push hook script
│   └── README.md                # Hooks documentation
├── analysis_options.yaml         # Analysis configuration
├── api-keys.json                # API keys (gitignored)
├── api-keys.example.json        # API keys template
├── l10n.yaml                    # Localization configuration
├── Makefile                     # Build automation
├── pubspec.yaml                 # Dependencies
└── README.md                    # This file
```

</details>

## 📦 Key Dependencies

### Core Dependencies
- **flutter_bloc**: ^9.1.1 - State management
- **get_it**: ^7.7.0 - Dependency injection
- **injectable**: ^2.5.1 - DI code generation
- **go_router**: ^16.2.0 - Declarative routing
- **dio**: ^5.9.0 - HTTP client
- **flutter_secure_storage**: ^9.2.4 - Secure local storage

### Code Generation
- **freezed_annotation**: ^3.1.0 - Immutable classes
- **json_annotation**: ^4.9.0 - JSON serialization
- **build_runner**: For code generation

### Development Dependencies
- **bloc_test**: ^10.0.7 - BLoC testing utilities
- **mockito**: ^5.4.4 - Mocking framework
- **freezed**: ^2.6.0 - Code generation
- **json_serializable**: ^6.8.1 - JSON serialization

## 🌍 Internationalization

The project supports multiple languages:

- **English** (en) - Default
- **Indonesian** (id)

Add new languages by:
1. Creating new `.arb` files in `lib/core/l10n/arb/`
2. Running `make gen` to generate translation classes
3. Adding the locale to `supportedLocales` in `app.dart`

## 🎨 Theming

The app uses Material 3 design with custom theming:

- **Colors**: Defined in `lib/core/theme/app_colors.dart`
- **Theme**: Configured in `lib/core/theme/app_theme.dart`
- **Dark/Light Mode**: Automatically adapts to system preferences

## 🔄 State Management

The project uses **BLoC pattern** for state management:

- **Events**: User actions and external triggers
- **States**: UI state representations
- **BLoCs**: Business logic and state transitions

Example BLoC structure:
```dart
// events/auth_event.dart
abstract class AuthEvent {}

// states/auth_state.dart  
abstract class AuthState {}

// bloc/auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Implementation
}
```

## 🌐 API Integration

API calls are handled through:

- **ApiClient**: Dio-based HTTP client with interceptors
- **Data Sources**: Feature-specific API interfaces
- **Repository Pattern**: Abstract data access layer
- **Error Handling**: Standardized failure classes

## 🔒 Security

- **Secure Storage**: Sensitive data stored with flutter_secure_storage
- **API Keys**: External configuration via api-keys.json
- **Network Security**: Certificate pinning ready (implement in network_module.dart)

## 🚀 Deployment

### Android
```bash
make build
# or
fvm flutter build apk --dart-define-from-file=api-keys.json
```

### iOS
```bash
fvm flutter build ios --dart-define-from-file=api-keys.json
```

### Web
```bash
fvm flutter build web --dart-define-from-file=api-keys.json
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes following the project conventions
4. Run tests: `make check`
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

### Development Guidelines

- Follow Clean Architecture principles
- Write tests for new features
- Use conventional commit messages
- Ensure code coverage doesn't decrease
- Run `make check` before committing

### Git Hooks

The project includes version-controlled git hooks in the `hooks/` directory:

**Pre-commit Hook:**
- **Automatically runs** on every `git commit`
- **Formats code** using `dart format`
- **Analyzes code** using `flutter analyze`
- **Prevents commits** if formatting or analysis fails

**Pre-push Hook:**
- **Automatically runs** on every `git push`
- **Runs all tests** using `make test`
- **Prevents pushes** if tests fail

**⚠️ SETUP REQUIRED:** The hooks are automatically installed when you run **`make bootstrap`** or manually with `make setup-git-hooks`. Since the hooks are stored in the `hooks/` directory, they're version-controlled and shared across all team members, but **each developer must run the setup command after cloning**.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:

- Create an [Issue](https://github.com/Devweave/flutter-boilerplate/issues)
- Check the [Wiki](https://github.com/Devweave/flutter-boilerplate/wiki)
- Review existing [Discussions](https://github.com/Devweave/flutter-boilerplate/discussions)

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - The framework
- [BLoC Library](https://bloclibrary.dev/) - State management
- [Injectable](https://pub.dev/packages/injectable) - Dependency injection
- [Freezed](https://pub.dev/packages/freezed) - Code generation
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) - Architecture inspiration
