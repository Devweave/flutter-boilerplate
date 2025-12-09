# Authentication

Authentication feature documentation.

## Overview

The authentication feature handles user login, logout, and session management using JWT tokens.

## Features

- Email/password login
- Token-based authentication
- Automatic token refresh
- Secure token storage
- Logout functionality

## Usage

```dart
// Login
context.read<AuthBloc>().add(
  AuthEvent.login(email: 'user@example.com', password: 'password'),
);

// Logout
context.read<AuthBloc>().add(const AuthEvent.logout());
```

## Implementation

See [Adding a Feature](../guides/adding-feature.md) for detailed implementation patterns.
