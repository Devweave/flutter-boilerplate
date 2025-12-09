# Architecture Overview

Flutter Boilerplate is built on **Clean Architecture** principles, ensuring separation of concerns, testability, and maintainability.

## Clean Architecture Layers

```mermaid
graph TB
    subgraph Presentation Layer
        UI[UI/Widgets]
        BLoC[BLoC/State Management]
    end
    
    subgraph Domain Layer
        UC[Use Cases]
        E[Entities]
        R[Repository Interfaces]
    end
    
    subgraph Data Layer
        RI[Repository Implementations]
        M[Models]
        API[ApiClient]
    end
    
    subgraph External
        Remote[Remote API]
        Local[Local Storage]
    end
    
    UI --> BLoC
    BLoC --> UC
    UC --> R
    R --> RI
    RI --> API
    API --> Remote
    API --> Local
    M -.implements.-> E
```

## Layer Responsibilities

### 🎨 Presentation Layer

**Location**: `lib/features/*/presentation/`

Handles UI and user interactions. Contains:

- **Pages**: Full-screen views
- **Widgets**: Reusable UI components
- **BLoC**: State management and business logic coordination

**Key Principle**: The presentation layer should only handle UI logic, delegating business logic to use cases.

### 🎯 Domain Layer

**Location**: `lib/features/*/domain/`

The core business logic layer. Contains:

- **Entities**: Business objects (pure Dart classes)
- **Use Cases**: Single-responsibility business operations
- **Repository Interfaces**: Abstract data access contracts

**Key Principle**: This layer has NO dependencies on other layers and contains pure business logic.

### 📦 Data Layer

**Location**: `lib/features/*/data/`

Handles data operations and external communications. Contains:

- **Models**: Data transfer objects with JSON serialization
- **Repository Implementations**: Concrete implementations that use `ApiClient` directly
- **ApiClient**: Dio-based HTTP client for network calls

**Key Principle**: This layer implements the interfaces defined in the domain layer. Repositories directly use `ApiClient` for network operations, keeping the architecture simple and pragmatic.

## Dependency Rule

Dependencies flow **inward** only:

```
Presentation → Domain ← Data
```

- Presentation depends on Domain
- Data depends on Domain
- Domain depends on nothing (pure Dart)

## Example: Todo Feature

```
lib/features/todos/
├── data/
│   ├── models/
│   │   └── todo_model.dart          # JSON serialization
│   └── repositories/
│       └── todo_repository_impl.dart # API calls + error handling
├── domain/
│   ├── entities/
│   │   └── todo.dart                 # Business object
│   ├── repositories/
│   │   └── todo_repository.dart      # Abstract interface
│   └── usecases/
│       ├── get_todos.dart
│       ├── create_todo.dart
│       └── delete_todo.dart
└── presentation/
    ├── bloc/
    │   ├── todo_bloc.dart
    │   ├── todo_event.dart
    │   └── todo_state.dart
    ├── pages/
    │   └── todos_page.dart
    └── widgets/
        └── todo_item.dart
```

## Repository Implementation Example

Repositories directly use `ApiClient` for simplicity and `DioErrorHandler` for consistent error handling:

```dart
@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final ApiClient _apiClient;

  TodoRepositoryImpl(this._apiClient);

  @override
  Future<Result<List<Todo>>> getTodos() async {
    try {
      final response = await _apiClient.get('/todos');
      final List<dynamic> jsonList = response.data as List<dynamic>;
      final todos = jsonList
          .map((json) => TodoModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList();
      return Success(todos);
    } on DioException catch (e) {
      return Error(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }
}
```

**Key Utilities:**
- **`DioErrorHandler`**: Converts `DioException` to appropriate `Failure` types
- **`Result<T>`**: Type-safe success/error handling
- **`ApiClient`**: Dio-based HTTP client

## Benefits

✅ **Testability**: Each layer can be tested independently  
✅ **Maintainability**: Clear separation of concerns  
✅ **Scalability**: Easy to add new features  
✅ **Flexibility**: Easy to swap implementations  
✅ **Independence**: Business logic independent of frameworks  
✅ **Simplicity**: No unnecessary abstraction layers

## Learn More

- [Clean Architecture Details](clean-architecture.md)
- [Project Structure](project-structure.md)
- [Data Flow](data-flow.md)
