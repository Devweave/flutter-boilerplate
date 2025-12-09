# Networking

HTTP networking with Dio.

## ApiClient

The `ApiClient` class wraps Dio for API calls:

```dart
@lazySingleton
class ApiClient {
  final Dio _dio;
  
  Future<Response> get(String path) => _dio.get(path);
  Future<Response> post(String path, {dynamic data}) => _dio.post(path, data: data);
}
```

## Error Handling

Use `DioErrorHandler` for consistent error handling:

```dart
try {
  final response = await _apiClient.get('/endpoint');
} on DioException catch (e) {
  return Error(DioErrorHandler.handleDioError(e));
}
```

See [DioErrorHandler](../architecture/overview.md#repository-implementation-example) for details.
