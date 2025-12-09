# Creating Use Cases

Guide to creating use cases in the domain layer.

## Use Case Structure

```dart
@injectable
class YourUseCase implements UseCase<ReturnType, ParamsType> {
  final YourRepository repository;

  YourUseCase(this.repository);

  @override
  Future<Result<ReturnType>> call(ParamsType params) {
    // Business logic here
    return repository.someMethod(params);
  }
}
```

## No Parameters

Use `NoParams` for use cases without parameters:

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

## With Parameters

Create a params class:

```dart
class CreateTodoParams {
  final String title;
  final bool completed;

  CreateTodoParams({required this.title, this.completed = false});
}

@injectable
class CreateTodo implements UseCase<void, CreateTodoParams> {
  final TodoRepository repository;

  CreateTodo(this.repository);

  @override
  Future<Result<void>> call(CreateTodoParams params) {
    final todo = Todo(
      title: params.title,
      completed: params.completed,
    );
    return repository.createTodo(todo);
  }
}
```

## Best Practices

1. **Single Responsibility**: One use case = one business operation
2. **Pure Business Logic**: No UI or data layer concerns
3. **Testable**: Easy to test in isolation
4. **Reusable**: Can be used by multiple UI components

See [Adding a Feature](adding-feature.md) for complete examples.
