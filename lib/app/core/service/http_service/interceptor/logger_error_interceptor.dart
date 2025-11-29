import 'dart:developer';

import 'package:dio/dio.dart';

class LoggerErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('\x1B[31m Method: ${err.requestOptions.method}');
    log('\x1B[31m Path: ${err.requestOptions.path}');
    log('\x1B[31m Error: ${err.error}');
    log('\x1B[31m Data da request: ${err.requestOptions.data}');
    log('\x1B[31m Data da response:${err.response?.data}');
    log('\x1B[31m Type: ${err.type}');

    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Method: ${options.method}');
    log('Path: ${options.path}');
    log('Full path ${options.baseUrl + options.path}');
    log('Data da request: ${options.data}');
    log('Type: ${options.responseType}');
    super.onRequest(options, handler);
  }
}
