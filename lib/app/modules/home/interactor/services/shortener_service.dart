import 'package:url_shortener/app/core/service/either/either.dart';
import 'package:url_shortener/app/core/service/http_service/http_exception.dart';

abstract interface class ShortenerService {
  Future<Either<HttpException, bool>> shortUrl(String url);
}