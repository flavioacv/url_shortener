import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:url_shortener/app/core/mixins/emit_mixin.dart';
import 'package:url_shortener/app/modules/home/interactor/models/shortened_url_model.dart';
import 'package:url_shortener/app/modules/home/interactor/models/url_links_model.dart';
import 'package:url_shortener/app/modules/home/interactor/services/shortener_service.dart';
import 'package:url_shortener/app/modules/home/interactor/states/shortener_state.dart';

class ShortenerController extends ValueNotifier<ShortenerState> with EmitMixin {
  final ShortenerService _shortenerService;
  ShortenerController({required ShortenerService shortenerService})
    : _shortenerService = shortenerService,
      super(ShortenerState.initial());

  Future<void> shortUrl(String url) async {
    emit(value.loading());
    final result = await _shortenerService.shortUrl(url);

    result.fold(
      onLeft: (exception) => emit(value.error(exception: exception)),
      onRight: (shortenedUrl) {
        final updatedHistory = [...value.history];
        emit(value.success(history: updatedHistory));
      },
    );
  }

  Future<void> shortUrlTest(String url) async {
    emit(value.loading());
    await Future.delayed(const Duration(seconds: 3));
    final updatedHistory = [
      ...value.history,
      ShortenedUrlModel(
        alias: Random().nextDouble().toString(),
        links: UrlLinksModel(self: url, short: 'test.urlshortener.com/test'),
      ),
    ];
    emit(value.success(history: updatedHistory));
  }

    bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return (uri.scheme == 'http' || uri.scheme == 'https') &&
          uri.host.isNotEmpty &&
          uri.host.contains('.');
    } catch (e) {
      return false;
    }
  }
}
