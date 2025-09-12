import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';

void main() {
  group('Failures', () {
    group('ServerFailure', () {
      test('should create server failure with message', () {
        // arrange
        const message = 'Server error occurred';

        // act
        const failure = ServerFailure(message);

        // assert
        expect(failure, isA<ServerFailure>());
        expect(failure.message, message);
        expect(failure.toString(), contains(message));
      });

      test('should extend Failure', () {
        // arrange
        const failure = ServerFailure('error');

        // assert
        expect(failure, isA<Failure>());
      });

      test('should support equality', () {
        // arrange
        const failure1 = ServerFailure('same error');
        const failure2 = ServerFailure('same error');
        const failure3 = ServerFailure('different error');

        // assert
        expect(failure1, equals(failure2));
        expect(failure1, isNot(equals(failure3)));
      });
    });

    group('NetworkFailure', () {
      test('should create network failure with message', () {
        // arrange
        const message = 'Network connection failed';

        // act
        const failure = NetworkFailure(message);

        // assert
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, message);
        expect(failure.toString(), contains(message));
      });

      test('should extend Failure', () {
        // arrange
        const failure = NetworkFailure('error');

        // assert
        expect(failure, isA<Failure>());
      });

      test('should support equality', () {
        // arrange
        const failure1 = NetworkFailure('connection timeout');
        const failure2 = NetworkFailure('connection timeout');
        const failure3 = NetworkFailure('connection refused');

        // assert
        expect(failure1, equals(failure2));
        expect(failure1, isNot(equals(failure3)));
      });
    });

    group('CacheFailure', () {
      test('should create cache failure with message', () {
        // arrange
        const message = 'Cache read failed';

        // act
        const failure = CacheFailure(message);

        // assert
        expect(failure, isA<CacheFailure>());
        expect(failure.message, message);
        expect(failure.toString(), contains(message));
      });

      test('should extend Failure', () {
        // arrange
        const failure = CacheFailure('error');

        // assert
        expect(failure, isA<Failure>());
      });

      test('should support equality', () {
        // arrange
        const failure1 = CacheFailure('cache miss');
        const failure2 = CacheFailure('cache miss');
        const failure3 = CacheFailure('cache corrupted');

        // assert
        expect(failure1, equals(failure2));
        expect(failure1, isNot(equals(failure3)));
      });
    });

    group('Different failure types', () {
      test('should be distinguishable', () {
        // arrange
        const serverFailure = ServerFailure('server error');
        const networkFailure = NetworkFailure('network error');
        const cacheFailure = CacheFailure('cache error');

        // assert
        expect(serverFailure, isNot(equals(networkFailure)));
        expect(networkFailure, isNot(equals(cacheFailure)));
        expect(cacheFailure, isNot(equals(serverFailure)));
      });

      test('should have proper type hierarchy', () {
        // arrange
        const serverFailure = ServerFailure('error');
        const networkFailure = NetworkFailure('error');
        const cacheFailure = CacheFailure('error');

        // assert
        expect(serverFailure, isA<Failure>());
        expect(networkFailure, isA<Failure>());
        expect(cacheFailure, isA<Failure>());

        expect(serverFailure, isA<ServerFailure>());
        expect(networkFailure, isA<NetworkFailure>());
        expect(cacheFailure, isA<CacheFailure>());
      });
    });
  });
}
