import 'package:dio/dio.dart';
import 'package:prosnap/core/global/globals.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d("${options.method} -> ${options.uri}");

    if (options.data != null) {
      logger.d("Request Body: ${options.data}");
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(response.data);

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e("Error: ${err.error ?? err.message}");

    handler.next(err);
  }
}
