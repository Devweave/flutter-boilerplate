import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/network/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_mocks.mocks.dart';
import '../../helpers/test_setup.dart';

void main() {
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    setupTestDummies();
  });

  group('ApiClient', () {
    group('GET requests', () {
      test('should make GET request with correct parameters', () async {
        // Arrange
        const path = '/test';
        final queryParameters = {'key': 'value'};
        final options = Options();
        final cancelToken = CancelToken();
        final response = Response<String>(
          requestOptions: RequestOptions(path: path),
          statusCode: 200,
          data: 'test response',
        );

        when(
          mockApiClient.get<String>(
            path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await mockApiClient.get<String>(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );

        // Assert
        expect(result, equals(response));
        verify(
          mockApiClient.get<String>(
            path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          ),
        ).called(1);
      });

      test('should make GET request without optional parameters', () async {
        // Arrange
        const path = '/test';
        final response = Response<String>(
          requestOptions: RequestOptions(path: path),
          statusCode: 200,
          data: 'test response',
        );

        when(
          mockApiClient.get<String>(
            path,
            queryParameters: null,
            options: null,
            cancelToken: null,
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await mockApiClient.get<String>(path);

        // Assert
        expect(result, equals(response));
        verify(
          mockApiClient.get<String>(
            path,
            queryParameters: null,
            options: null,
            cancelToken: null,
          ),
        ).called(1);
      });
    });

    group('POST requests', () {
      test('should make POST request with correct parameters', () async {
        // Arrange
        const path = '/test';
        final data = {'key': 'value'};
        final queryParameters = {'query': 'test'};
        final options = Options();
        final cancelToken = CancelToken();
        final response = Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: path),
          statusCode: 201,
          data: {'result': 'success'},
        );

        when(
          mockApiClient.post<Map<String, dynamic>>(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await mockApiClient.post<Map<String, dynamic>>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );

        // Assert
        expect(result, equals(response));
        verify(
          mockApiClient.post<Map<String, dynamic>>(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          ),
        ).called(1);
      });
    });

    group('PUT requests', () {
      test('should make PUT request with correct parameters', () async {
        // Arrange
        const path = '/test/1';
        final data = {'name': 'updated'};
        final response = Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: path),
          statusCode: 200,
          data: {'result': 'updated'},
        );

        when(
          mockApiClient.put<Map<String, dynamic>>(
            path,
            data: data,
            queryParameters: null,
            options: null,
            cancelToken: null,
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await mockApiClient.put<Map<String, dynamic>>(
          path,
          data: data,
        );

        // Assert
        expect(result, equals(response));
        verify(
          mockApiClient.put<Map<String, dynamic>>(
            path,
            data: data,
            queryParameters: null,
            options: null,
            cancelToken: null,
          ),
        ).called(1);
      });
    });

    group('DELETE requests', () {
      test('should make DELETE request with correct parameters', () async {
        // Arrange
        const path = '/test/1';
        final response = Response<void>(
          requestOptions: RequestOptions(path: path),
          statusCode: 204,
        );

        when(
          mockApiClient.delete<void>(
            path,
            data: null,
            queryParameters: null,
            options: null,
            cancelToken: null,
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await mockApiClient.delete<void>(path);

        // Assert
        expect(result, equals(response));
        verify(
          mockApiClient.delete<void>(
            path,
            data: null,
            queryParameters: null,
            options: null,
            cancelToken: null,
          ),
        ).called(1);
      });
    });
  });

  group('HeaderInterceptor', () {
    late HeaderInterceptor interceptor;
    late RequestOptions requestOptions;

    setUp(() {
      interceptor = HeaderInterceptor();
      requestOptions = RequestOptions(path: '/test');
    });

    test('should add Content-Type and Accept headers', () {
      // Act
      interceptor.onRequest(requestOptions, MockRequestInterceptorHandler());

      // Assert
      expect(
        requestOptions.headers['Content-Type'],
        equals('application/json'),
      );
      expect(requestOptions.headers['Accept'], equals('application/json'));
    });
  });
}

class MockRequestInterceptorHandler extends RequestInterceptorHandler {
  @override
  void next(RequestOptions requestOptions) {}
}
