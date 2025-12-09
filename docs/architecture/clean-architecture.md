# Clean Architecture

Deep dive into Clean Architecture principles and implementation in Flutter Boilerplate.

## What is Clean Architecture?

Clean Architecture is a software design philosophy that separates concerns into distinct layers, making the codebase:

- **Independent of Frameworks**: Business logic doesn't depend on Flutter
- **Testable**: Business logic can be tested without UI, database, or external services
- **Independent of UI**: UI can change without affecting business logic
- **Independent of Database**: Can swap data sources easily
- **Independent of External Services**: Business logic doesn't know about external APIs

## The Dependency Rule

**Dependencies point inward only**. Source code dependencies must point only toward higher-level policies.

```
Presentation → Domain ← Data
```

- **Presentation** depends on **Domain**
- **Data** depends on **Domain**
- **Domain** depends on nothing (pure Dart)

## Layer Details

### 🎨 Presentation Layer

**Responsibility**: Handle UI and user interactions

**Contains**:
- **Pages**: Full-screen views
- **Widgets**: Reusable UI components  
- **BLoC**: State management and UI logic

**Rules**:
- Can depend on Domain layer
- Cannot depend on Data layer
- Should only handle UI logic
- Delegates business logic to Use Cases

**Example**:
```dart
class TodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TodosBloc>()..add(LoadTodos()),
      child: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          // Build UI based on state
        },
      ),
    );
  }
}
```

### 🎯 Domain Layer

**Responsibility**: Contains business logic and rules

**Contains**:
- **Entities**: Business objects (pure Dart classes)
- **Use Cases**: Single-responsibility business operations
- **Repository Interfaces**: Abstract contracts for data access

**Rules**:
- Pure Dart code (no Flutter dependencies)
- No dependencies on other layers
- Defines interfaces that outer layers implement
- Contains core business logic

**Example Entity**:
```dart
@freezed
class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String title,
    required bool completed,
  }) = _Todo;
}
```

**Example Use Case**:
```dart
@injectable
class GetTodos implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;

  GetTodos(this.repository);

  @override
  Future<Result<List<Todo>>> call(NoParams params) {
    return repository.getTodos();
  }
}
```

**Example Repository Interface**:
```dart
abstract class TodoRepository {
  Future<Result<List<Todo>>> getTodos();
  Future<Result<Todo>> getTodoById(int id);
  Future<Result<void>> createTodo(Todo todo);
}
```

### 📦 Data Layer

**Responsibility**: Implement data operations

**Contains**:
- **Models**: Data transfer objects with JSON serialization
- **Repository Implementations**: Concrete implementations of domain repositories
- **ApiClient**: Network communication

**Rules**:
- Implements Domain layer interfaces
- Handles data transformation (Model ↔ Entity)
- Manages external data sources
- Handles errors and converts to Failures

**Example Model**:
```dart
@freezed
class TodoModel with _$TodoModel {
  const TodoModel._();
  
  const factory TodoModel({
    required int id,
    required String title,
    required bool completed,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Todo toEntity() => Todo(
        id: id,
        title: title,
        completed: completed,
      );
}
```

**Example Repository Implementation**:
```dart
@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final ApiClient _apiClient;

  TodoRepositoryImpl(this._apiClient);

  @override
  Future<Result<List<Todo>>> getTodos() async {
    try {
      final response = await _apiClient.get('/todos');
      final todos = (response.data as List)
          .map((json) => TodoModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList();
      return Success(todos);
    } on DioException catch (e) {
      return Error(DioErrorHandler.handleDioError(e));
    }
  }
}
```

## Data Flow

### Reading Data (Query)

```
UI → BLoC → Use Case → Repository Interface → Repository Impl → ApiClient → API
                                                                      ↓
UI ← BLoC ← Use Case ← Repository Interface ← Repository Impl ← Response
```

### Writing Data (Command)

```
UI → BLoC → Use Case → Repository Interface → Repository Impl → ApiClient → API
      ↓
    State Update
```

## Benefits

### ✅ Testability

Each layer can be tested independently:

```dart
// Test Use Case without UI or Data layer
test('GetTodos returns list of todos', () async {
  when(mockRepository.getTodos())
      .thenAnswer((_) async => Success([mockTodo]));
  
  final result = await getTodos(NoParams());
  
  expect(result, isA<Success<List<Todo>>>());
});
```

### ✅ Maintainability

Clear separation makes code easier to understand and modify:
- UI changes don't affect business logic
- Business logic changes don't affect UI
- Data source changes don't affect business logic

### ✅ Scalability

Easy to add new features following the same pattern:
- Add new entity in Domain
- Add use cases for business operations
- Implement repository in Data layer
- Create UI in Presentation layer

### ✅ Flexibility

Easy to swap implementations:
- Switch from REST API to GraphQL
- Add caching layer
- Change state management solution
- Replace UI framework

## Common Patterns

### Error Handling

Use `Result<T>` type for type-safe error handling:

```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}
```

### Dependency Injection

Use `injectable` and `get_it`:

```dart
@injectable
class MyClass {
  final Dependency dependency;
  MyClass(this.dependency);
}

// Access anywhere
final instance = getIt<MyClass>();
```

## Best Practices

1. **Keep Domain Pure**: No Flutter or external dependencies
2. **Single Responsibility**: Each class has one reason to change
3. **Dependency Inversion**: Depend on abstractions, not concretions
4. **Interface Segregation**: Small, focused interfaces
5. **Test Each Layer**: Unit tests for each layer independently

## Learn More

- [Project Structure](project-structure.md)
- [Data Flow](data-flow.md)
- [Adding a Feature](../guides/adding-feature.md)
