import 'package:flutter_boilerplate/core/utils/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Resource', () {
    group('Factory constructors', () {
      test('should create initial resource', () {
        final resource = Resource<String>.initial();

        expect(resource.isInitial, isTrue);
        expect(resource.isLoading, isFalse);
        expect(resource.isSuccess, isFalse);
        expect(resource.isError, isFalse);
        expect(resource.data, isNull);
        expect(resource.error, isNull);
      });

      test('should create loading resource', () {
        final resource = Resource<String>.loading();

        expect(resource.isInitial, isFalse);
        expect(resource.isLoading, isTrue);
        expect(resource.isSuccess, isFalse);
        expect(resource.isError, isFalse);
        expect(resource.data, isNull);
        expect(resource.error, isNull);
      });

      test('should create success resource with data', () {
        const testData = 'test data';
        final resource = Resource<String>.success(testData);

        expect(resource.isInitial, isFalse);
        expect(resource.isLoading, isFalse);
        expect(resource.isSuccess, isTrue);
        expect(resource.isError, isFalse);
        expect(resource.data, equals(testData));
        expect(resource.error, isNull);
      });

      test('should create error resource with message', () {
        const errorMessage = 'Something went wrong';
        final resource = Resource<String>.error(errorMessage);

        expect(resource.isInitial, isFalse);
        expect(resource.isLoading, isFalse);
        expect(resource.isSuccess, isFalse);
        expect(resource.isError, isTrue);
        expect(resource.data, isNull);
        expect(resource.error, equals(errorMessage));
      });
    });

    group('when method', () {
      test('should call initial callback for initial resource', () {
        final resource = Resource<String>.initial();
        bool initialCalled = false;

        resource.when(
          initial: () {
            initialCalled = true;
            return 'initial';
          },
          loading: () => 'loading',
          success: (data) => 'success: $data',
          error: (message) => 'error: $message',
        );

        expect(initialCalled, isTrue);
      });

      test('should call loading callback for loading resource', () {
        final resource = Resource<String>.loading();
        bool loadingCalled = false;

        resource.when(
          initial: () => 'initial',
          loading: () {
            loadingCalled = true;
            return 'loading';
          },
          success: (data) => 'success: $data',
          error: (message) => 'error: $message',
        );

        expect(loadingCalled, isTrue);
      });

      test('should call success callback for success resource', () {
        const testData = 'test data';
        final resource = Resource<String>.success(testData);
        String? receivedData;

        final result = resource.when(
          initial: () => 'initial',
          loading: () => 'loading',
          success: (data) {
            receivedData = data;
            return 'success: $data';
          },
          error: (message) => 'error: $message',
        );

        expect(receivedData, equals(testData));
        expect(result, equals('success: $testData'));
      });

      test('should call error callback for error resource', () {
        const errorMessage = 'Something went wrong';
        final resource = Resource<String>.error(errorMessage);
        String? receivedMessage;

        final result = resource.when(
          initial: () => 'initial',
          loading: () => 'loading',
          success: (data) => 'success: $data',
          error: (message) {
            receivedMessage = message;
            return 'error: $message';
          },
        );

        expect(receivedMessage, equals(errorMessage));
        expect(result, equals('error: $errorMessage'));
      });
    });

    group('with different types', () {
      test('should work with int type', () {
        const testValue = 42;
        final resource = Resource<int>.success(testValue);

        expect(resource.isSuccess, isTrue);
        expect(resource.data, equals(testValue));
      });

      test('should work with custom object type', () {
        final testList = ['item1', 'item2'];
        final resource = Resource<List<String>>.success(testList);

        expect(resource.isSuccess, isTrue);
        expect(resource.data, equals(testList));
      });
    });
  });
}
