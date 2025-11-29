import 'package:url_shortener/app/core/service/either/either.dart';
import 'package:url_shortener/app/core/service/http_service/http_client_service.dart';
import 'package:url_shortener/app/core/service/http_service/http_exception.dart';
import 'package:url_shortener/app/modules/home/interactor/models/shortened_url_model.dart';
import 'package:url_shortener/app/modules/home/interactor/services/shortener_service.dart';

class ShortenerServiceImpl implements ShortenerService {
  final HttpClientService _httpClientService;

  ShortenerServiceImpl({required HttpClientService httpClientService})
    : _httpClientService = httpClientService;

  @override
  Future<Either<HttpException, ShortenedUrlModel>> shortUrl(String url) async {
    try {
      final response = await _httpClientService.post(
        '/api/alias',
        body: {'url': url},
      );

      if (response.data == null) {
        return Left(HttpException('Failed to shorten URL'));
      }
      final shortenedUrl = ShortenedUrlModel.fromJson(response.data);
      return Right(shortenedUrl);
    } on HttpException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<HttpException, String>> readShortenedUrl(String alias) async {
    try {
      final response = await _httpClientService.get('/api/alias/$alias');

      if (response.data == null) {
        return Left(HttpException('Failed to read shortened URL'));
      }
      if (response.data['url'] == null) {
        return Left(HttpException('URL not found'));
      }
      return Right(response.data['url']);
    } on HttpException catch (e) {
      return Left(e);
    }
  }
}
