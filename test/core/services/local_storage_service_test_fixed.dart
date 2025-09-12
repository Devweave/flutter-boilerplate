import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_boilerplate/core/services/local_storage_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late LocalStorageService localStorageService;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    localStorageService = LocalStorageService(mockSecureStorage);
  });

  group('LocalStorageService', () {
    group('Authentication methods', () {
      group('setLoggedIn', () {
        test('should return true when successfully setting login status',
            () async {
          // arrange
          when(mockSecureStorage.write(key: 'is_logged_in', value: 'true'))
              .thenAnswer((_) async {});

          // act
          final result = await localStorageService.setLoggedIn(true);

          // assert
          expect(result, true);
          verify(mockSecureStorage.write(key: 'is_logged_in', value: 'true'))
              .called(1);
        });

        test('should return false when storage throws exception', () async {
          // arrange
          when(mockSecureStorage.write(key: 'is_logged_in', value: 'false'))
              .thenThrow(Exception('Storage error'));

          // act
          final result = await localStorageService.setLoggedIn(false);

          // assert
          expect(result, false);
        });
      });

      group('isLoggedIn', () {
        test('should return true when stored value is "true"', () async {
          // arrange
          when(mockSecureStorage.read(key: 'is_logged_in'))
              .thenAnswer((_) async => 'true');

          // act
          final result = await localStorageService.isLoggedIn();

          // assert
          expect(result, true);
        });

        test('should return false when stored value is not "true"', () async {
          // arrange
          when(mockSecureStorage.read(key: 'is_logged_in'))
              .thenAnswer((_) async => 'false');

          // act
          final result = await localStorageService.isLoggedIn();

          // assert
          expect(result, false);
        });

        test('should return false when stored value is null', () async {
          // arrange
          when(mockSecureStorage.read(key: 'is_logged_in'))
              .thenAnswer((_) async => null);

          // act
          final result = await localStorageService.isLoggedIn();

          // assert
          expect(result, false);
        });
      });

      group('setUserData', () {
        test('should return true when successfully storing user data',
            () async {
          // arrange
          final userData = {
            'id': '1',
            'name': 'John Doe',
            'email': 'john@example.com',
          };
          when(
            mockSecureStorage.write(
              key: 'user_data',
              value: json.encode(userData),
            ),
          ).thenAnswer((_) async {});

          // act
          final result = await localStorageService.setUserData(userData);

          // assert
          expect(result, true);
          verify(
            mockSecureStorage.write(
              key: 'user_data',
              value: json.encode(userData),
            ),
          ).called(1);
        });

        test('should return false when storage throws exception', () async {
          // arrange
          final userData = {'id': '1', 'name': 'John Doe'};
          when(
            mockSecureStorage.write(
              key: 'user_data',
              value: json.encode(userData),
            ),
          ).thenThrow(Exception('Storage error'));

          // act
          final result = await localStorageService.setUserData(userData);

          // assert
          expect(result, false);
        });
      });

      group('getUserData', () {
        test('should return parsed user data when data exists', () async {
          // arrange
          const storedData =
              '{"id":"1","name":"John Doe","email":"john@example.com"}';
          final expectedData = {
            'id': '1',
            'name': 'John Doe',
            'email': 'john@example.com',
          };
          when(mockSecureStorage.read(key: 'user_data'))
              .thenAnswer((_) async => storedData);

          // act
          final result = await localStorageService.getUserData();

          // assert
          expect(result, expectedData);
        });

        test('should return null when no data exists', () async {
          // arrange
          when(mockSecureStorage.read(key: 'user_data'))
              .thenAnswer((_) async => null);

          // act
          final result = await localStorageService.getUserData();

          // assert
          expect(result, isNull);
        });
      });

      group('clearUserData', () {
        test('should return true when successfully clearing data', () async {
          // arrange
          when(mockSecureStorage.delete(key: 'user_data'))
              .thenAnswer((_) async {});
          when(mockSecureStorage.delete(key: 'is_logged_in'))
              .thenAnswer((_) async {});

          // act
          final result = await localStorageService.clearUserData();

          // assert
          expect(result, true);
          verify(mockSecureStorage.delete(key: 'user_data')).called(1);
          verify(mockSecureStorage.delete(key: 'is_logged_in')).called(1);
        });

        test('should return false when storage throws exception', () async {
          // arrange
          when(mockSecureStorage.delete(key: 'user_data'))
              .thenThrow(Exception('Delete error'));

          // act
          final result = await localStorageService.clearUserData();

          // assert
          expect(result, false);
        });
      });
    });

    group('Generic storage methods', () {
      group('String methods', () {
        test('setString should return true on success', () async {
          // arrange
          when(mockSecureStorage.write(key: 'test_key', value: 'test_value'))
              .thenAnswer((_) async {});

          // act
          final result =
              await localStorageService.setString('test_key', 'test_value');

          // assert
          expect(result, true);
        });

        test('getString should return stored value', () async {
          // arrange
          when(mockSecureStorage.read(key: 'test_key'))
              .thenAnswer((_) async => 'test_value');

          // act
          final result = await localStorageService.getString('test_key');

          // assert
          expect(result, 'test_value');
        });
      });

      group('Boolean methods', () {
        test('setBool should store boolean as string', () async {
          // arrange
          when(mockSecureStorage.write(key: 'test_bool', value: 'true'))
              .thenAnswer((_) async {});

          // act
          final result = await localStorageService.setBool('test_bool', true);

          // assert
          expect(result, true);
        });

        test('getBool should return true for "true" value', () async {
          // arrange
          when(mockSecureStorage.read(key: 'test_bool'))
              .thenAnswer((_) async => 'true');

          // act
          final result = await localStorageService.getBool('test_bool');

          // assert
          expect(result, true);
        });

        test('getBool should return false for "false" value', () async {
          // arrange
          when(mockSecureStorage.read(key: 'test_bool'))
              .thenAnswer((_) async => 'false');

          // act
          final result = await localStorageService.getBool('test_bool');

          // assert
          expect(result, false);
        });

        test('getBool should return default value for null', () async {
          // arrange
          when(mockSecureStorage.read(key: 'test_bool'))
              .thenAnswer((_) async => null);

          // act
          final result = await localStorageService.getBool(
            'test_bool',
            defaultValue: true,
          );

          // assert
          expect(result, true);
        });
      });

      group('Integer methods', () {
        test('setInt should store integer as string', () async {
          // arrange
          when(mockSecureStorage.write(key: 'test_int', value: '42'))
              .thenAnswer((_) async {});

          // act
          final result = await localStorageService.setInt('test_int', 42);

          // assert
          expect(result, true);
        });

        test('getInt should return parsed integer', () async {
          // arrange
          when(mockSecureStorage.read(key: 'test_int'))
              .thenAnswer((_) async => '42');

          // act
          final result = await localStorageService.getInt('test_int');

          // assert
          expect(result, 42);
        });

        test('getInt should return default value for invalid data', () async {
          // arrange
          when(mockSecureStorage.read(key: 'test_int'))
              .thenAnswer((_) async => 'invalid');

          // act
          final result =
              await localStorageService.getInt('test_int', defaultValue: 0);

          // assert
          expect(result, 0);
        });
      });

      group('Management methods', () {
        test('remove should delete key successfully', () async {
          // arrange
          when(mockSecureStorage.delete(key: 'test_key'))
              .thenAnswer((_) async {});

          // act
          final result = await localStorageService.remove('test_key');

          // assert
          expect(result, true);
        });

        test('clear should delete all data successfully', () async {
          // arrange
          when(mockSecureStorage.deleteAll()).thenAnswer((_) async {});

          // act
          final result = await localStorageService.clear();

          // assert
          expect(result, true);
        });
      });
    });
  });
}
