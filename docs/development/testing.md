# Testing Guide

Comprehensive testing is a core principle of this boilerplate. Learn how to write and run tests effectively.

## Test Structure

```
test/
├── helpers/                    # Shared test utilities
│   ├── test_mocks.dart        # Mock definitions
│   └── test_setup.dart        # Test setup utilities
├── unit/                      # Unit tests
│   ├── core/                  # Core layer tests
│   └── features/              # Feature tests
├── widget/                    # Widget tests
└── integration/               # Integration tests
```

## Running Tests

### All Tests

```bash
make test
```

### Specific Test File

```bash
fvm flutter test test/unit/features/auth/domain/usecases/login_test.dart
```

### With Coverage

```bash
make test
make coverage  # Opens HTML report
```

## Writing Tests

### Unit Tests

Test business logic in isolation:

```dart
void main() {
  late MockAuthRepository mockRepository;
  late LoginUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  test('should return User when login succeeds', () async {
    // Arrange
    when(mockRepository.login(any, any))
        .thenAnswer((_) async => Right(mockUser));

    // Act
    final result = await useCase(LoginParams(
      email: 'test@test.com',
      password: 'password',
    ));

    // Assert
    expect(result, Right(mockUser));
    verify(mockRepository.login('test@test.com', 'password'));
  });
}
```

### BLoC Tests

Use `bloc_test` package:

```dart
blocTest<AuthBloc, AuthState>(
  'emits [loading, authenticated] when login succeeds',
  build: () {
    when(mockLoginUseCase(any))
        .thenAnswer((_) async => Right(mockUser));
    return AuthBloc(loginUseCase: mockLoginUseCase);
  },
  act: (bloc) => bloc.add(
    AuthEvent.loginRequested(
      email: 'test@test.com',
      password: 'password',
    ),
  ),
  expect: () => [
    const AuthState.loading(),
    AuthState.authenticated(mockUser),
  ],
);
```

### Widget Tests

Test UI components:

```dart
testWidgets('LoginPage displays email and password fields', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: LoginPage()),
  );

  expect(find.byType(TextField), findsNWidgets(2));
  expect(find.text('Email'), findsOneWidget);
  expect(find.text('Password'), findsOneWidget);
});
```

## Best Practices

1. **Follow AAA Pattern**: Arrange, Act, Assert
2. **Use Mocks**: Mock dependencies with Mockito
3. **Test Behavior**: Focus on what, not how
4. **Keep Tests Fast**: Unit tests should run in milliseconds
5. **Maintain Coverage**: Aim for >80% coverage

## Learn More

- [Development Tools](tools.md)
- [Adding a Feature](../guides/adding-feature.md)
