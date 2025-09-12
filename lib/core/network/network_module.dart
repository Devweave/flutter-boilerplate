import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/utils/constants.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio();
    dio.options.baseUrl = Constants.kBaseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    return dio;
  }
}
