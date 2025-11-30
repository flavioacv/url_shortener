import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener/app/core/service/either/either.dart';
import 'package:url_shortener/app/core/service/http_service/http_exception.dart';
import 'package:url_shortener/app/modules/home/interactor/controllers/shortener_controller.dart';
import 'package:url_shortener/app/modules/home/interactor/models/shortened_url_model.dart';
import 'package:url_shortener/app/modules/home/interactor/models/url_links_model.dart';
import 'package:url_shortener/app/modules/home/interactor/services/shortener_service.dart';
import 'package:url_shortener/app/modules/home/interactor/states/shortener_state.dart';

class ShortenerServiceMock extends Mock implements ShortenerService {}

void main() {
  late ShortenerService shortenerService;
  late ShortenerController controller;

  setUp(() {
    shortenerService = ShortenerServiceMock();
    controller = ShortenerController(shortenerService: shortenerService);
  });

  group('ShortenerController', () {
    test('should emit initial state', () {
      expect(controller.value, isA<ShortenerStateInitial>());
    });
    test('should emit loading state', () {
      controller.value = controller.value.loading();
      expect(controller.value, isA<ShortenerStateLoading>());
    });

    test('should emit success state', () {
      controller.value = controller.value.success(history: []);
      expect(controller.value, isA<ShortenerStateSuccess>());
    });

    test('should emit error state', () {
      controller.value = controller.value.error(
        exception: HttpException('error'),
      );
      expect(controller.value, isA<ShortenerStateError>());
    });
    group('shortUrl', () {
      test('should emit loading then success and update history', () async {
        final fakeModel = ShortenedUrlModel(
          alias: 'test-alias',
          links: UrlLinksModel.empty(),
        );
        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Right(fakeModel));

        await controller.shortUrl('https://google.com');
        expect(controller.value, isA<ShortenerStateSuccess>());

        final successState = controller.value as ShortenerStateSuccess;
        expect(successState.history, [fakeModel]);
      });

      test('should emit loading then error on failure', () async {
        final exception = HttpException('Network error');
        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Left(exception));

        await controller.shortUrl('https://google.com');

        expect(controller.value, isA<ShortenerStateError>());

        final errorState = controller.value as ShortenerStateError;
        expect(errorState.exception, exception);
      });

      test('should accumulate history across multiple calls', () async {
        final fakeModel1 = ShortenedUrlModel(
          alias: 'alias-1',
          links: UrlLinksModel.empty(),
        );
        final fakeModel2 = ShortenedUrlModel(
          alias: 'alias-2',
          links: UrlLinksModel.empty(),
        );
        final fakeModel3 = ShortenedUrlModel(
          alias: 'alias-3',
          links: UrlLinksModel.empty(),
        );

        when(
          () => shortenerService.shortUrl('https://google.com'),
        ).thenAnswer((_) async => Right(fakeModel1));
        when(
          () => shortenerService.shortUrl('https://github.com'),
        ).thenAnswer((_) async => Right(fakeModel2));
        when(
          () => shortenerService.shortUrl('https://flutter.dev'),
        ).thenAnswer((_) async => Right(fakeModel3));

        await controller.shortUrl('https://google.com');
        var successState = controller.value as ShortenerStateSuccess;
        expect(successState.history.length, 1);
        expect(successState.history, [fakeModel1]);

        await controller.shortUrl('https://github.com');
        successState = controller.value as ShortenerStateSuccess;
        expect(successState.history.length, 2);
        expect(successState.history, [fakeModel1, fakeModel2]);

        await controller.shortUrl('https://flutter.dev');
        successState = controller.value as ShortenerStateSuccess;
        expect(successState.history.length, 3);
        expect(successState.history, [fakeModel1, fakeModel2, fakeModel3]);
      });
    });
  });
}
