import 'package:url_shortener/app/core/service/either/either.dart';
import 'package:url_shortener/app/core/service/http_service/http_exception.dart';
import 'package:url_shortener/app/modules/home/interactor/models/shortened_url_model.dart';

abstract interface class ShortenerService {
  Future<Either<HttpException, ShortenedUrlModel>> shortUrl(String url);
  Future<Either<HttpException, String>> readShortenedUrl(String alias);
}