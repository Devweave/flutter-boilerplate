# Git Hooks

This directory contains git hooks that are used to maintain code quality and ensure consistent development practices across the project.

## Available Hooks

### pre-commit
- **Purpose**: Runs before each commit to ensure code quality
- **Actions**:
  - Formats code using `dart format`
  - Analyzes code using `flutter analyze`
  - Prevents commit if formatting or analysis fails

### pre-push
- **Purpose**: Runs before pushing to remote repository
- **Actions**:
  - Runs all tests using `make test`
  - Prevents push if tests fail

## Installation

The hooks are automatically installed when you run:

```bash
make bootstrap
```

Or manually with:

```bash
make setup-git-hooks
```

## Customization

You can modify these hooks to add additional checks or customize the behavior for your specific needs. After making changes, run `make setup-git-hooks` to update the installed hooks.

## Bypassing Hooks

In rare cases where you need to bypass the hooks (not recommended for normal development):

```bash
# Skip pre-commit hook
git commit --no-verify -m "your message"

# Skip pre-push hook  
git push --no-verify
```

**Note**: Only use `--no-verify` in exceptional circumstances, as it bypasses important quality checks.
