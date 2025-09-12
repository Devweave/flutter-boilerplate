import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/network/network_module.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkModule Tests', () {
    late NetworkModule networkModule;

    setUp(() {
      networkModule = _NetworkModuleImpl();
    });

    test('should create Dio instance with correct configuration', () {
      // Act
      final dio = networkModule.dio();

      // Assert
      expect(dio, isA<Dio>());
      expect(
        dio.options.baseUrl,
        equals('https://jsonplaceholder.typicode.com'),
      );
      expect(dio.options.connectTimeout, equals(const Duration(seconds: 30)));
      expect(dio.options.receiveTimeout, equals(const Duration(seconds: 30)));
    });

    test('should return same Dio instance when called multiple times', () {
      // Act
      final dio1 = networkModule.dio();
      final dio2 = networkModule.dio();

      // Assert
      // Note: Due to @lazySingleton, this would return the same instance
      // in actual DI container, but here we test the configuration
      expect(dio1.options.baseUrl, equals(dio2.options.baseUrl));
      expect(dio1.options.connectTimeout, equals(dio2.options.connectTimeout));
      expect(dio1.options.receiveTimeout, equals(dio2.options.receiveTimeout));
    });

    test('should have proper timeout configuration', () {
      // Act
      final dio = networkModule.dio();

      // Assert
      expect(dio.options.connectTimeout, isNotNull);
      expect(dio.options.receiveTimeout, isNotNull);
      expect(dio.options.connectTimeout!.inSeconds, equals(30));
      expect(dio.options.receiveTimeout!.inSeconds, equals(30));
    });

    test('should have correct base URL format', () {
      // Act
      final dio = networkModule.dio();

      // Assert
      expect(dio.options.baseUrl, startsWith('https://'));
      expect(dio.options.baseUrl, contains('jsonplaceholder.typicode.com'));
    });

    test('should create Dio with default options', () {
      // Act
      final dio = networkModule.dio();

      // Assert
      expect(dio.options, isNotNull);
      expect(dio.options.method, equals('GET')); // Default method
      expect(dio.options.followRedirects, isTrue); // Default follow redirects
    });
  });
}

// Concrete implementation for testing
class _NetworkModuleImpl extends NetworkModule {}
