# Development Tools

Tools and utilities for development.

## Makefile Commands

See [Makefile Reference](../reference/makefile.md) for all available commands.

## Code Generation

```bash
make gen          # Generate code
make watch        # Watch mode
```

## Testing

```bash
make test         # Run all tests
make test-unit    # Unit tests only
make test-widget  # Widget tests only
```

## Code Quality

```bash
make analyze      # Static analysis
make format       # Format code
make lint         # Lint code
```

## Git Hooks

Pre-commit hooks run automatically:
- Code formatting
- Linting
- Tests

Setup: `make setup-git-hooks`

## VS Code Extensions

Recommended:
- Dart
- Flutter
- Error Lens
- GitLens
