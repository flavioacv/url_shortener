import 'package:dio/dio.dart';
import 'package:url_shortener/app/core/service/http_service/dio_exception_handler.dart';
import 'package:url_shortener/app/core/service/http_service/interceptor/logger_error_interceptor.dart';
import 'package:url_shortener/app/core/types/type.dart';

import '../../internet_connection/internet_connection_service.dart';
import '../http_client_service.dart';
import '../http_exception.dart';
import '../http_response.dart';
import '../http_service_mixin.dart';

class HttpClientDioServiceImpl extends HttpClientService with HttpServiceMixin {
  final Dio dio;
  final InternetConnectionService internetConnectionService;

  HttpClientDioServiceImpl({
    required this.dio,
    required this.internetConnectionService,
  }) {
    dio.interceptors.add(LoggerErrorInterceptor());
  }

  @override
  Future<HttpResponse> get(
    String url, {
    Json? headers,
    Json? queryParams,
  }) async {
    try {
      await throwErrorIfNotConnectionWithInternet(internetConnectionService);

      final response = await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      final data = response.data;

      // throwErroIfHasInRequest(data);

      return HttpResponse(data: data);
    } on DioException catch (exception) {
      final response = exception.response;
      final defaultMessage = DioExceptionHandler.getDefaultMessage(exception);

      throw HttpException(
        defaultMessage,
        code: response?.statusCode,
        stackTrace: exception.stackTrace,
      );
    }
  }

  @override
  Future<HttpResponse> delete(
    final String url, {
    final Json? headers,
    final Json? queryParams,
    final Json? body,
  }) async {
    try {
      await throwErrorIfNotConnectionWithInternet(internetConnectionService);

      final response = await dio.delete(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
        data: body,
      );

      final data = response.data;

      // throwErroIfHasInRequest(data);

      return HttpResponse(data: data);
    } on DioException catch (exception) {
      final response = exception.response;
      final defaultMessage = DioExceptionHandler.getDefaultMessage(exception);

      throw HttpException(
        defaultMessage,
        code: response?.statusCode,
        stackTrace: exception.stackTrace,
      );
    }
  }

  @override
  Future<HttpResponse> post(
    final String url, {
    final Json? headers,
    final Json? queryParams,
    final dynamic body,
  }) async {
    try {
      await throwErrorIfNotConnectionWithInternet(internetConnectionService);

      final response = await dio.post(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
        data: body,
      );

      final data = response.data;

      // throwErroIfHasInRequest(data);

      return HttpResponse(data: data);
    } on DioException catch (exception) {
      final response = exception.response;
      final defaultMessage = DioExceptionHandler.getDefaultMessage(exception);

      throw HttpException(
        defaultMessage,
        code: response?.statusCode,
        stackTrace: exception.stackTrace,
      );
    }
  }

  @override
  Future<HttpResponse> put(
    final String url, {
    final Json? headers,
    final Json? queryParams,
    final Json? body,
  }) async {
    try {
      await throwErrorIfNotConnectionWithInternet(internetConnectionService);

      final response = await dio.put(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
        data: body,
      );

      final data = response.data;

      // throwErroIfHasInRequest(data);

      return HttpResponse(data: data);
    } on DioException catch (exception) {
      final response = exception.response;
      final defaultMessage = DioExceptionHandler.getDefaultMessage(exception);

      throw HttpException(
        defaultMessage,
        code: response?.statusCode,
        stackTrace: exception.stackTrace,
      );
    }
  }
}
