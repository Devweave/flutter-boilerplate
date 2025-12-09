# Quick Start

Get up and running with Flutter Boilerplate in just a few minutes!

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: 3.32.4 (we use FVM for version management)
- **Dart SDK**: >=3.3.3 <4.0.0
- **FVM**: [Install FVM](https://fvm.app/docs/getting_started/installation)
- **Make**: For build automation (optional but recommended)

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/Devweave/flutter-boilerplate.git
cd flutter-boilerplate
```

### 2. Setup Flutter Version with FVM

```bash
fvm install 3.32.4
fvm use 3.32.4
```

### 3. Bootstrap the Project ⚠️ **REQUIRED**

This is the most important step! Run:

```bash
make bootstrap
```

!!! warning "Critical Step"
    **DO NOT SKIP THIS!** The bootstrap command:
    
    - Installs all dependencies
    - Generates required code
    - **Sets up git pre-commit hooks** (runs format & analyze)
    - Configures the development environment
    
    Without this, git hooks won't work and code quality checks will be skipped!

### 4. Configure API Keys

```bash
cp api-keys.example.json api-keys.json
# Edit api-keys.json with your actual API keys
```

### 5. Run the Application

```bash
make run
```

Or without Make:

```bash
fvm flutter run --dart-define-from-file=api-keys.json
```

## What's Next?

- 📖 Learn about the [Architecture](../architecture/overview.md)
- 🎨 Customize the [Theme](../guides/theming.md)
- ✨ [Add a New Feature](../guides/adding-feature.md)
- 🧪 Explore [Testing](../development/testing.md)

## Common Issues

### Git Hooks Not Working

If git hooks aren't running, manually set them up:

```bash
make setup-git-hooks
```

### Build Runner Errors

If you encounter code generation errors:

```bash
make clean
make gen
```

### FVM Command Not Found

Install FVM globally:

```bash
dart pub global activate fvm
```
