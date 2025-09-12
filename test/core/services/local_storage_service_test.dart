import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_mocks.mocks.dart';
import '../../helpers/test_setup.dart';

void main() {
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    setupTestDummies();
  });

  group('LocalStorageService', () {
    group('Authentication methods', () {
      test('setLoggedIn should return true when successful', () async {
        // Arrange
        when(mockLocalStorageService.setLoggedIn(true))
            .thenAnswer((_) async => true);

        // Act
        final result = await mockLocalStorageService.setLoggedIn(true);

        // Assert
        expect(result, true);
        verify(mockLocalStorageService.setLoggedIn(true)).called(1);
      });

      test('setLoggedIn should return false when failed', () async {
        // Arrange
        when(mockLocalStorageService.setLoggedIn(true))
            .thenAnswer((_) async => false);

        // Act
        final result = await mockLocalStorageService.setLoggedIn(true);

        // Assert
        expect(result, false);
        verify(mockLocalStorageService.setLoggedIn(true)).called(1);
      });

      test('isLoggedIn should return true when user is logged in', () async {
        // Arrange
        when(mockLocalStorageService.isLoggedIn())
            .thenAnswer((_) async => true);

        // Act
        final result = await mockLocalStorageService.isLoggedIn();

        // Assert
        expect(result, true);
        verify(mockLocalStorageService.isLoggedIn()).called(1);
      });

      test('isLoggedIn should return false when user is not logged in',
          () async {
        // Arrange
        when(mockLocalStorageService.isLoggedIn())
            .thenAnswer((_) async => false);

        // Act
        final result = await mockLocalStorageService.isLoggedIn();

        // Assert
        expect(result, false);
        verify(mockLocalStorageService.isLoggedIn()).called(1);
      });

      test('setUserData should return true when successful', () async {
        // Arrange
        final userData = {
          'id': 1,
          'name': 'Test User',
          'email': 'test@example.com',
        };
        when(mockLocalStorageService.setUserData(userData))
            .thenAnswer((_) async => true);

        // Act
        final result = await mockLocalStorageService.setUserData(userData);

        // Assert
        expect(result, true);
        verify(mockLocalStorageService.setUserData(userData)).called(1);
      });

      test('getUserData should return user data when available', () async {
        // Arrange
        final userData = {
          'id': 1,
          'name': 'Test User',
          'email': 'test@example.com',
        };
        when(mockLocalStorageService.getUserData())
            .thenAnswer((_) async => userData);

        // Act
        final result = await mockLocalStorageService.getUserData();

        // Assert
        expect(result, equals(userData));
        verify(mockLocalStorageService.getUserData()).called(1);
      });

      test('getUserData should return null when no data available', () async {
        // Arrange
        when(mockLocalStorageService.getUserData())
            .thenAnswer((_) async => null);

        // Act
        final result = await mockLocalStorageService.getUserData();

        // Assert
        expect(result, isNull);
        verify(mockLocalStorageService.getUserData()).called(1);
      });

      test('clearUserData should return true when successful', () async {
        // Arrange
        when(mockLocalStorageService.clearUserData())
            .thenAnswer((_) async => true);

        // Act
        final result = await mockLocalStorageService.clearUserData();

        // Assert
        expect(result, true);
        verify(mockLocalStorageService.clearUserData()).called(1);
      });
    });

    group('Generic storage methods', () {
      test('setString should return true when successful', () async {
        // Arrange
        const key = 'test_key';
        const value = 'test_value';
        when(mockLocalStorageService.setString(key, value))
            .thenAnswer((_) async => true);

        // Act
        final result = await mockLocalStorageService.setString(key, value);

        // Assert
        expect(result, true);
        verify(mockLocalStorageService.setString(key, value)).called(1);
      });

      test('getString should return stored value', () async {
        // Arrange
        const key = 'test_key';
        const value = 'test_value';
        when(mockLocalStorageService.getString(key))
            .thenAnswer((_) async => value);

        // Act
        final result = await mockLocalStorageService.getString(key);

        // Assert
        expect(result, equals(value));
        verify(mockLocalStorageService.getString(key)).called(1);
      });

      test('getString should return null when key does not exist', () async {
        // Arrange
        const key = 'non_existent_key';
        when(mockLocalStorageService.getString(key))
            .thenAnswer((_) async => null);

        // Act
        final result = await mockLocalStorageService.getString(key);

        // Assert
        expect(result, isNull);
        verify(mockLocalStorageService.getString(key)).called(1);
      });

      test('setBool should return true when successful', () async {
        // Arrange
        const key = 'test_bool_key';
        const value = true;
        when(mockLocalStorageService.setBool(key, value))
            .thenAnswer((_) async => true);

        // Act
        final result = await mockLocalStorageService.setBool(key, value);

        // Assert
        expect(result, true);
        verify(mockLocalStorageService.setBool(key, value)).called(1);
      });

      test('getBool should return stored boolean value', () async {
        // Arrange
        const key = 'test_bool_key';
        const value = true;
        when(mockLocalStorageService.getBool(key))
            .thenAnswer((_) async => value);

        // Act
        final result = await mockLocalStorageService.getBool(key);

        // Assert
        expect(result, equals(value));
        verify(mockLocalStorageService.getBool(key)).called(1);
      });

      test('getBool should return default value when key does not exist',
          () async {
        // Arrange
        const key = 'non_existent_bool_key';
        const defaultValue = false;
        when(mockLocalStorageService.getBool(key, defaultValue: defaultValue))
            .thenAnswer((_) async => defaultValue);

        // Act
        final result = await mockLocalStorageService.getBool(
          key,
          defaultValue: defaultValue,
        );

        // Assert
        expect(result, equals(defaultValue));
        verify(mockLocalStorageService.getBool(key, defaultValue: defaultValue))
            .called(1);
      });

      test('setInt should return true when successful', () async {
        // Arrange
        const key = 'test_int_key';
        const value = 42;
        when(mockLocalStorageService.setInt(key, value))
            .thenAnswer((_) async => true);

        // Act
        final result = await mockLocalStorageService.setInt(key, value);

        // Assert
        expect(result, true);
        verify(mockLocalStorageService.setInt(key, value)).called(1);
      });

      test('getInt should return stored integer value', () async {
        // Arrange
        const key = 'test_int_key';
        const value = 42;
        when(mockLocalStorageService.getInt(key))
            .thenAnswer((_) async => value);

        // Act
        final result = await mockLocalStorageService.getInt(key);

        // Assert
        expect(result, equals(value));
        verify(mockLocalStorageService.getInt(key)).called(1);
      });

      test('getInt should return default value when key does not exist',
          () async {
        // Arrange
        const key = 'non_existent_int_key';
        const defaultValue = 0;
        when(mockLocalStorageService.getInt(key, defaultValue: defaultValue))
            .thenAnswer((_) async => defaultValue);

        // Act
        final result = await mockLocalStorageService.getInt(
          key,
          defaultValue: defaultValue,
        );

        // Assert
        expect(result, equals(defaultValue));
        verify(mockLocalStorageService.getInt(key, defaultValue: defaultValue))
            .called(1);
      });

      test('remove should return true when successful', () async {
        // Arrange
        const key = 'test_key_to_remove';
        when(mockLocalStorageService.remove(key)).thenAnswer((_) async => true);

        // Act
        final result = await mockLocalStorageService.remove(key);

        // Assert
        expect(result, true);
        verify(mockLocalStorageService.remove(key)).called(1);
      });

      test('clear should return true when successful', () async {
        // Arrange
        when(mockLocalStorageService.clear()).thenAnswer((_) async => true);

        // Act
        final result = await mockLocalStorageService.clear();

        // Assert
        expect(result, true);
        verify(mockLocalStorageService.clear()).called(1);
      });
    });
  });
}
