import '../../types/type.dart';
import 'http_response.dart';

abstract class HttpClientService {
  Future<HttpResponse> get(String url, {Json? headers, Json? queryParams});

  Future<HttpResponse> post(
    String url, {
    Json? headers,
    Json? queryParams,
    dynamic body,
  });

  Future<HttpResponse> delete(
    String url, {
    Json? headers,
    Json? queryParams,
    Json? body,
  });

  Future<HttpResponse> put(
    String url, {
    Json? headers,
    Json? queryParams,
    Json? body,
  });
}
