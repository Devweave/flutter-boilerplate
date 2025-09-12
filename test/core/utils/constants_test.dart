import 'package:flutter_boilerplate/core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Constants', () {
    test('should have correct app name', () {
      expect(Constants.kAppName, 'Flutter Boilerplate');
    });

    test('should define base URL from environment', () {
      // This tests that the constant is defined, actual value depends on environment
      expect(Constants.kBaseUrl, isA<String>());
    });

    test('should define enable chucker flag from environment', () {
      // This tests that the constant is defined, actual value depends on environment
      expect(Constants.kEnableChucker, isA<bool>());
    });
  });

  group('AppDimens', () {
    group('width constants', () {
      test('should define width constants', () {
        expect(AppDimens.width4, 4.0);
        expect(AppDimens.width8, 8.0);
        expect(AppDimens.width12, 12.0);
        expect(AppDimens.width16, 16.0);
        expect(AppDimens.width20, 20.0);
        expect(AppDimens.width24, 24.0);
        expect(AppDimens.width32, 32.0);
        expect(AppDimens.width48, 48.0);
      });
    });

    group('height constants', () {
      test('should define height constants', () {
        expect(AppDimens.height4, 4.0);
        expect(AppDimens.height8, 8.0);
        expect(AppDimens.height12, 12.0);
        expect(AppDimens.height16, 16.0);
        expect(AppDimens.height20, 20.0);
      });
    });
  });

  group('LocalStorageKeys', () {
    test('should be defined as a class', () {
      expect(LocalStorageKeys(), isA<LocalStorageKeys>());
    });
  });
}
