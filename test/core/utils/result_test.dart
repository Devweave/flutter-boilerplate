import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';

void main() {
  group('Result', () {
    group('Success', () {
      test('should create success result with data', () {
        // arrange
        const data = 'test data';

        // act
        const result = Success(data);

        // assert
        expect(result, isA<Success<String>>());
        expect(result.data, data);
      });

      test('should handle null data in success', () {
        // act
        const result = Success<String?>(null);

        // assert
        expect(result, isA<Success<String?>>());
        expect(result.data, isNull);
      });

      test('should handle different data types', () {
        // arrange & act
        const stringResult = Success('hello');
        const intResult = Success(42);
        const boolResult = Success(true);

        // assert
        expect(stringResult.data, 'hello');
        expect(intResult.data, 42);
        expect(boolResult.data, true);
      });
    });

    group('Error', () {
      test('should create error result with failure', () {
        // arrange
        const failure = ServerFailure('Server error');

        // act
        const result = Error<String>(failure);

        // assert
        expect(result, isA<Error<String>>());
        expect(result.failure, failure);
      });

      test('should handle different failure types', () {
        // arrange
        const networkFailure = NetworkFailure('Network error');
        const cacheFailure = CacheFailure('Cache error');
        const serverFailure = ServerFailure('Server error');

        // act
        const networkResult = Error<String>(networkFailure);
        const cacheResult = Error<String>(cacheFailure);
        const serverResult = Error<String>(serverFailure);

        // assert
        expect(networkResult.failure, isA<NetworkFailure>());
        expect(cacheResult.failure, isA<CacheFailure>());
        expect(serverResult.failure, isA<ServerFailure>());
      });
    });

    group('Type checking', () {
      test('should distinguish between Success and Error', () {
        // arrange
        const success = Success('data');
        const error = Error<String>(ServerFailure('error'));

        // assert
        expect(success, isA<Success<String>>());
        expect(success, isNot(isA<Error<String>>()));
        expect(error, isA<Error<String>>());
        expect(error, isNot(isA<Success<String>>()));
      });

      test('should handle pattern matching', () {
        // arrange
        const successResult = Success('success data');
        const errorResult = Error<String>(NetworkFailure('network error'));

        // act & assert - success case
        switch (successResult) {
          case Success(data: final data):
            expect(data, 'success data');
        }

        // act & assert - error case
        switch (errorResult) {
          case Error(failure: final failure):
            expect(failure, isA<NetworkFailure>());
        }
      });
    });

    group('Generic types', () {
      test('should work with custom types', () {
        // arrange
        final customData = {'key': 'value'};

        // act
        final result = Success(customData);

        // assert
        expect(result.data, customData);
        expect(result.data['key'], 'value');
      });

      test('should work with lists', () {
        // arrange
        const listData = [1, 2, 3];

        // act
        const result = Success(listData);

        // assert
        expect(result.data, listData);
        expect(result.data.length, 3);
      });
    });
  });
}
