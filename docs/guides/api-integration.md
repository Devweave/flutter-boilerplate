# API Integration

Integrating with REST APIs.

## Configure Base URL

Set in `api-keys.json`:

```json
{
  "API_BASE_URL": "https://api.example.com"
}
```

## Create Repository

```dart
@Injectable(as: YourRepository)
class YourRepositoryImpl implements YourRepository {
  final ApiClient _apiClient;

  YourRepositoryImpl(this._apiClient);

  @override
  Future<Result<Data>> getData() async {
    try {
      final response = await _apiClient.get('/endpoint');
      final data = DataModel.fromJson(response.data);
      return Success(data.toEntity());
    } on DioException catch (e) {
      return Error(DioErrorHandler.handleDioError(e));
    }
  }
}
```

## HTTP Methods

```dart
// GET
await _apiClient.get('/users');

// POST
await _apiClient.post('/users', data: {'name': 'John'});

// PUT
await _apiClient.put('/users/1', data: {'name': 'Jane'});

// DELETE
await _apiClient.delete('/users/1');
```

## Headers

Add custom headers in `ApiClient`:

```dart
_dio.options.headers['Authorization'] = 'Bearer $token';
```

## Interceptors

Add interceptors for logging, auth, etc. in `lib/core/network/api_client.dart`.

See [Networking](../features/networking.md) for more details.
