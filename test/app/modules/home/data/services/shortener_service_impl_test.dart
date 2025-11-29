import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener/app/core/service/http_service/http_client_service.dart';
import 'package:url_shortener/app/core/service/http_service/http_exception.dart';
import 'package:url_shortener/app/core/service/http_service/http_response.dart';
import 'package:url_shortener/app/modules/home/data/services/shortener_service_impl.dart';
import 'package:url_shortener/app/modules/home/interactor/services/shortener_service.dart';

class HttpClientServiceMock extends Mock implements HttpClientService {}

void main() {
  late HttpClientServiceMock httpClientService;
  late ShortenerService shortenerService;

  setUp(() {
    httpClientService = HttpClientServiceMock();
    shortenerService = ShortenerServiceImpl(
      httpClientService: httpClientService,
    );
  });

  group('ShortenerServiceImpl', () {
    const url = 'https://example.com';

    group('shortUrl', () {
      const endpoint = '/api/alias';
      test(
        'should return Right(true) when URL is successfully shortened',
        () async {
          final mockResponse = HttpResponse(data: {'success': true});

          when(
            () => httpClientService.post(endpoint, body: {'url': url}),
          ).thenAnswer((_) async => mockResponse);

          final result = await shortenerService.shortUrl(url);

          expect(
            result.fold(onLeft: (_) => false, onRight: (value) => value),
            true,
          );

          verify(
            () => httpClientService.post(endpoint, body: {'url': url}),
          ).called(1);
        },
      );

      test(
        'should return Left(HttpException) when HTTP request fails',
        () async {
          const exception = HttpException('Failed to shorten URL', code: 500);

          when(
            () => httpClientService.post(endpoint, body: {'url': url}),
          ).thenThrow(exception);

          final result = await shortenerService.shortUrl(url);

          result.fold(
            onLeft: (error) {
              expect(error, isA<HttpException>());
              expect(error.message, 'Failed to shorten URL');
              expect(error.code, 500);
            },
            onRight: (_) => fail('Should return Left with HttpException'),
          );

          verify(
            () => httpClientService.post(endpoint, body: {'url': url}),
          ).called(1);
        },
      );
    });
  });
}
