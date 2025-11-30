import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String getDefaultMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';

      case DioExceptionType.sendTimeout:
        return 'Timeout while sending data to the server.';

      case DioExceptionType.receiveTimeout:
        return 'Timeout while receiving data from the server.';

      case DioExceptionType.badCertificate:
        return 'Invalid SSL certificate.';

      case DioExceptionType.badResponse:
        return _getMessageByStatusCode(exception.response?.statusCode);

      case DioExceptionType.cancel:
        return 'Request cancelled.';

      case DioExceptionType.connectionError:
        return 'Connection error. Please check your network.';

      case DioExceptionType.unknown:
        return 'Unexpected error. Check your connection or try again later.';
    }
  }

  static String _getMessageByStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check the data sent.';

      case 401:
        return 'Unauthorized access. Please login again.';

      case 403:
        return 'You do not have permission to access this resource.';

      case 404:
        return 'Resource not found. Please check the URL.';

      case 500:
        return 'Internal server error. Please try again later.';

      default:
        return 'Unknown error in server response.';
    }
  }
}
