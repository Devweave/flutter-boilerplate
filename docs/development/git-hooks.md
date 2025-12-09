# Git Hooks

Automated quality checks on commit.

## Pre-commit Hooks

Automatically runs before each commit:

1. **Format**: Formats all Dart files
2. **Analyze**: Runs static analysis
3. **Test**: Runs all tests

## Setup

```bash
make setup-git-hooks
```

This creates `.git/hooks/pre-commit` script.

## Bypass Hooks

For emergencies only:
```bash
git commit --no-verify
```

## Manual Run

Test hooks without committing:
```bash
make pre-commit
```

## Customization

Edit `.git/hooks/pre-commit` to customize checks.

See [Development Tools](tools.md) for more commands.
