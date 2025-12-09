# Code Generation

Using build_runner for code generation.

## What Gets Generated

- **Freezed**: Immutable classes with copyWith, equality
- **JSON Serialization**: fromJson/toJson methods
- **Injectable**: Dependency injection configuration
- **GoRouter**: Route generation

## Commands

```bash
# One-time generation
make gen

# Watch mode (auto-regenerate on changes)
make watch

# Clean and regenerate
make clean
make gen
```

## Generated Files

- `*.freezed.dart` - Freezed code
- `*.g.dart` - JSON serialization
- `injectable.config.dart` - DI configuration

**Never edit generated files manually!**

## Troubleshooting

### Conflicts

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

### Slow Generation

Use watch mode during development:
```bash
make watch
```

See [Testing](testing.md) for test-specific generation.
