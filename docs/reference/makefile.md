# Makefile Commands Reference

The Flutter Boilerplate includes a comprehensive Makefile for common development tasks.

## Essential Commands

### `make help`

Display all available commands with descriptions.

```bash
make help
```

### `make bootstrap`

**⚠️ REQUIRED FOR NEW CLONES**

Complete project setup including:
- Installing dependencies
- Generating code
- Setting up git hooks
- Configuring development environment

```bash
make bootstrap
```

!!! warning "First Time Setup"
    Always run this command after cloning the repository!

## Dependency Management

### `make deps`

Install Flutter dependencies.

```bash
make deps
```

Equivalent to:
```bash
fvm flutter pub get
```

### `make clean`

Clean build artifacts and caches.

```bash
make clean
```

Runs:
- `flutter clean`
- `flutter pub cache clean`

## Code Generation

### `make gen`

Generate code using build_runner.

```bash
make gen
```

Equivalent to:
```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

### `make watch`

Watch for changes and regenerate code automatically.

```bash
make watch
```

## Testing

### `make test`

Run all tests with coverage.

```bash
make test
```

Generates:
- Test results
- Coverage report
- Coverage badge

### `make coverage`

Generate HTML coverage report.

```bash
make coverage
```

Opens coverage report in browser.

## Code Quality

### `make analyze`

Analyze code for issues.

```bash
make analyze
```

Equivalent to:
```bash
fvm flutter analyze
```

### `make format`

Format code according to Dart style guide.

```bash
make format
```

Equivalent to:
```bash
fvm dart format lib/ test/ --set-exit-if-changed
```

### `make check`

Run format, analyze, and test in sequence.

```bash
make check
```

Perfect for pre-commit checks!

## Running the App

### `make run`

Run the application in debug mode.

```bash
make run
```

Equivalent to:
```bash
fvm flutter run --dart-define-from-file=api-keys.json
```

### `make run-dev`

Run with development flavor (if configured).

```bash
make run-dev
```

### `make run-prod`

Run with production flavor (if configured).

```bash
make run-prod
```

## Building

### `make build`

Build Android APK.

```bash
make build
```

### `make build-ios`

Build iOS application.

```bash
make build-ios
```

### `make build-web`

Build web application.

```bash
make build-web
```

### `make build-appbundle`

Build Android App Bundle (for Play Store).

```bash
make build-appbundle
```

## Git Hooks

### `make setup-git-hooks`

Install git pre-commit and pre-push hooks.

```bash
make setup-git-hooks
```

Hooks will:
- **Pre-commit**: Format and analyze code
- **Pre-push**: Run tests

## Project Customization

### `make rename`

Rename the app and bundle identifier.

```bash
make rename APP_NAME="My App" BUNDLE_ID="com.example.myapp"
```

Uses the `rename` package to update:
- App name
- Bundle identifier
- Package names

## Advanced Commands

### `make doctor`

Check Flutter environment setup.

```bash
make doctor
```

### `make upgrade`

Upgrade Flutter dependencies.

```bash
make upgrade
```

### `make outdated`

Check for outdated packages.

```bash
make outdated
```

## Chaining Commands

You can chain multiple commands:

```bash
make clean deps gen test
```

## Custom Targets

You can add custom targets to the Makefile for project-specific tasks.

## Without Make

If Make is not available, refer to the Makefile to see the underlying commands and run them directly.

Example:
```bash
# Instead of: make test
fvm flutter test --coverage
fvm flutter pub run test_cov_console
```

## Tips

1. **Use tab completion**: Type `make` and press tab to see available commands
2. **Check the Makefile**: Open `Makefile` to see exact commands being run
3. **Customize**: Add your own targets to the Makefile for project-specific workflows

## Learn More

- [Development Tools](../development/tools.md)
- [Testing Guide](../development/testing.md)
- [Quick Start](../getting-started/quick-start.md)
