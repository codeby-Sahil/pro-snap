import 'package:dio/dio.dart';
import 'package:prosnap/core/network/auth_interceptor.dart';
import 'package:prosnap/core/network/logger_intercepter.dart';
import 'error_interceptor.dart';

class ApiClient {
  late final Dio dio;
  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.1.16:4000/api/v1",
        connectTimeout: const Duration(seconds: 200),
        receiveTimeout: const Duration(seconds: 200),
        headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.addAll([
      LoggerInterceptor(),
      AuthInterceptor(),
      ErrorInterceptor(),
      LoggerInterceptor(),
    ]);
  }
}
