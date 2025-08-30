import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/login_usecase.dart';

import '../../../../helpers/test_mocks.mocks.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    loginUseCase = LoginUseCase(mockLocalStorageService);
  });

  group('LoginUseCase', () {
    test('should return error when email is empty', () async {
      // Arrange
      const params = LoginParams(email: '', password: 'password123');

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result.isError, true);
      expect(result.error, 'Email dan password tidak boleh kosong');
      verifyNever(mockLocalStorageService.setLoggedIn(any));
    });

    test('should return error when password is empty', () async {
      // Arrange
      const params = LoginParams(email: 'test@example.com', password: '');

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result.isError, true);
      expect(result.error, 'Email dan password tidak boleh kosong');
      verifyNever(mockLocalStorageService.setLoggedIn(any));
    });

    test('should return error when email is invalid', () async {
      // Arrange
      const params =
          LoginParams(email: 'invalid-email', password: 'password123');

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result.isError, true);
      expect(result.error, 'Email atau password tidak valid');
      verifyNever(mockLocalStorageService.setLoggedIn(any));
    });

    test('should return error when password is too short', () async {
      // Arrange
      const params = LoginParams(email: 'test@example.com', password: '123');

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result.isError, true);
      expect(result.error, 'Email atau password tidak valid');
      verifyNever(mockLocalStorageService.setLoggedIn(any));
    });

    test('should return success when credentials are valid', () async {
      // Arrange
      const params =
          LoginParams(email: 'test@example.com', password: 'password123');
      when(mockLocalStorageService.setLoggedIn(true))
          .thenAnswer((_) async => true);
      when(mockLocalStorageService.setUserData(any))
          .thenAnswer((_) async => true);

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result.isSuccess, true);
      expect(result.data?.email, 'test@example.com');
      expect(result.data?.name, 'test');
      expect(result.data?.isActive, true);
      verify(mockLocalStorageService.setLoggedIn(true)).called(1);
      verify(mockLocalStorageService.setUserData(any)).called(1);
    });

    test('should handle local storage exceptions', () async {
      // Arrange
      const params =
          LoginParams(email: 'test@example.com', password: 'password123');
      when(mockLocalStorageService.setLoggedIn(true))
          .thenThrow(Exception('Storage error'));

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result.isError, true);
      expect(result.error, contains('Terjadi kesalahan'));
    });
  });
}
