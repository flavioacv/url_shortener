import '../../exception/app_exception.dart';

class HttpException implements AppException {
  @override
  final String message;
  final int? code;



  const HttpException(
    this.message, {
    this.stackTrace,

    this.code,
  });

  @override
  final StackTrace? stackTrace;
}
