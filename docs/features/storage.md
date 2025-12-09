# Storage

Local data persistence.

## LocalStorageService

Wrapper around SharedPreferences:

```dart
@lazySingleton
class LocalStorageService {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> remove(String key);
  Future<void> clear();
}
```

## Usage

```dart
// Save data
await localStorageService.saveString('token', 'jwt-token');

// Retrieve data
final token = await localStorageService.getString('token');

// Remove data
await localStorageService.remove('token');
```

## Secure Storage

For sensitive data, consider using `flutter_secure_storage` package.
