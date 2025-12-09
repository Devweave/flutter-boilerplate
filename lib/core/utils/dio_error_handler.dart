import 'package:dio/dio.dart';
import '../error/failures.dart';

/// Utility class for handling Dio exceptions and converting them to Failures
class DioErrorHandler {
  /// Converts a DioException to an appropriate Failure
  static Failure handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      case DioExceptionType.badResponse:
        return ServerFailure('Server error: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');
      case DioExceptionType.badCertificate:
        return const NetworkFailure('Bad certificate');
      default:
        return ServerFailure(e.message ?? 'Unknown error');
    }
  }
}
