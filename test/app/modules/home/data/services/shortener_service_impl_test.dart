import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener/app/core/service/http_service/http_client_service.dart';
import 'package:url_shortener/app/core/service/http_service/http_exception.dart';
import 'package:url_shortener/app/core/service/http_service/http_response.dart';
import 'package:url_shortener/app/modules/home/data/services/shortener_service_impl.dart';
import 'package:url_shortener/app/modules/home/interactor/models/shortened_url_model.dart';
import 'package:url_shortener/app/modules/home/interactor/models/url_links_model.dart';
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
        'should return Right(ShortenedUrlModel) when URL is successfully shortened',
        () async {
          final mockResponse = HttpResponse(
            data: {
              "alias": "",
              "_links": {"self": "", "short": ""},
            },
          );

          when(
            () => httpClientService.post(endpoint, body: {'url': url}),
          ).thenAnswer((_) async => mockResponse);

          final result = await shortenerService.shortUrl(url);

          expect(
            result.fold(onLeft: (_) => false, onRight: (value) => value),
            ShortenedUrlModel(alias: '', links: UrlLinksModel.empty()),
          );

          verify(
            () => httpClientService.post(endpoint, body: {'url': url}),
          ).called(1);
        },
      );

      test(
        'should return Right(ShortenedUrlModel) when variables are null',
        () async {
          final mockResponse = HttpResponse(
            data: {"alias": null, "_links": null},
          );

          when(
            () => httpClientService.post(endpoint, body: {'url': url}),
          ).thenAnswer((_) async => mockResponse);

          final result = await shortenerService.shortUrl(url);

          expect(
            result.fold(onLeft: (_) => false, onRight: (value) => value),
            ShortenedUrlModel(alias: '', links: UrlLinksModel.empty()),
          );

          verify(
            () => httpClientService.post(endpoint, body: {'url': url}),
          ).called(1);
        },
      );

      test('should return Left(HttpException) when data is null', () async {
        final mockResponse = HttpResponse(data: null);

        when(
          () => httpClientService.post(endpoint, body: {'url': url}),
        ).thenAnswer((_) async => mockResponse);

        final result = await shortenerService.shortUrl(url);

        expect(result.fold(onLeft: (_) => true, onRight: (_) => false), true);

        verify(
          () => httpClientService.post(endpoint, body: {'url': url}),
        ).called(1);
      });

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

    group('readShortenedUrl', () {
      const endpoint = '/api/alias/1';
      test(
        'should return Right(String) when URL is successfully read',
        () async {
          final mockResponse = HttpResponse(data: {"url": ""});

          when(
            () => httpClientService.get(endpoint),
          ).thenAnswer((_) async => mockResponse);

          final result = await shortenerService.readShortenedUrl('1');

          expect(
            result.fold(onLeft: (_) => false, onRight: (value) => value),
            '',
          );

          verify(() => httpClientService.get(endpoint)).called(1);
        },
      );

      test(
        'should return Left(HttpException) when HTTP request fails',
        () async {
          const exception = HttpException('Failed to read URL', code: 500);

          when(() => httpClientService.get(endpoint)).thenThrow(exception);

          final result = await shortenerService.readShortenedUrl('1');

          result.fold(
            onLeft: (error) {
              expect(error, isA<HttpException>());
              expect(error.message, 'Failed to read URL');
              expect(error.code, 500);
            },
            onRight: (_) => fail('Should return Left with HttpException'),
          );

          verify(() => httpClientService.get(endpoint)).called(1);
        },
      );

      test(
        'should return Left(HttpException) when status code is not 404',
        () async {
          const exception = HttpException('404 when not found', code: 404);

          when(() => httpClientService.get(endpoint)).thenThrow(exception);

          final result = await shortenerService.readShortenedUrl('1');

          result.fold(
            onLeft: (error) {
              expect(error, isA<HttpException>());
              expect(error.message, '404 when not found');
              expect(error.code, 404);
            },
            onRight: (_) => fail('Should return Left with HttpException'),
          );

          verify(() => httpClientService.get(endpoint)).called(1);
        },
      );

      test('should return Left(HttpException) when URL is not found', () async {
        const exception = HttpException('URL not found', code: 404);

        when(() => httpClientService.get(endpoint)).thenThrow(exception);

        final result = await shortenerService.readShortenedUrl('1');

        result.fold(
          onLeft: (error) {
            expect(error, isA<HttpException>());
            expect(error.message, 'URL not found');
            expect(error.code, 404);
          },
          onRight: (_) => fail('Should return Left with HttpException'),
        );

        verify(() => httpClientService.get(endpoint)).called(1);
      });
    });
  });
}
