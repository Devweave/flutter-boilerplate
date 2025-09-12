import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_boilerplate/core/utils/base_usecase.dart';
import 'package:flutter_boilerplate/features/auth/domain/usecases/logout_usecase.dart';

import '../../../../helpers/test_mocks.mocks.dart';

void main() {
  late LogoutUseCase logoutUseCase;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    logoutUseCase = LogoutUseCase(mockLocalStorageService);
  });

  group('LogoutUseCase', () {
    test('should successfully logout and clear user data', () async {
      // Arrange
      when(mockLocalStorageService.clearUserData())
          .thenAnswer((_) async => true);

      // Act
      final result = await logoutUseCase(const NoParams());

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, true);
      verify(mockLocalStorageService.clearUserData()).called(1);
    });

    test('should return error when clearing user data fails', () async {
      // Arrange
      when(mockLocalStorageService.clearUserData())
          .thenAnswer((_) async => false);

      // Act
      final result = await logoutUseCase(const NoParams());

      // Assert
      expect(result.isError, true);
      expect(result.error, contains('Gagal logout'));
      verify(mockLocalStorageService.clearUserData()).called(1);
    });

    test('should handle exceptions during logout', () async {
      // Arrange
      when(mockLocalStorageService.clearUserData())
          .thenThrow(Exception('Storage error'));

      // Act
      final result = await logoutUseCase(const NoParams());

      // Assert
      expect(result.isError, true);
      expect(result.error, contains('Gagal logout'));
      verify(mockLocalStorageService.clearUserData()).called(1);
    });
  });
}
