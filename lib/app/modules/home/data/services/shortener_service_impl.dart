import 'package:url_shortener/app/core/service/either/either.dart';
import 'package:url_shortener/app/core/service/http_service/http_client_service.dart';
import 'package:url_shortener/app/core/service/http_service/http_exception.dart';
import 'package:url_shortener/app/modules/home/interactor/services/shortener_service.dart';

class ShortenerServiceImpl implements ShortenerService {
  final HttpClientService _httpClientService;

  ShortenerServiceImpl({required HttpClientService httpClientService})
    : _httpClientService = httpClientService;

  @override
  Future<Either<HttpException, bool>> shortUrl(String url) async {
    try {
      await _httpClientService.post('/api/alias', body: {'url': url});
      return Right(true);
    } on HttpException catch (e) {
      return Left(e);
    }
  }
}
