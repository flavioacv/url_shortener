import 'package:flutter/cupertino.dart';
import 'package:url_shortener/app/core/mixins/emit_mixin.dart';
import 'package:url_shortener/app/modules/home/interactor/services/shortener_service.dart';
import 'package:url_shortener/app/modules/home/interactor/states/shortener_state.dart';

class ShortenerController extends ValueNotifier<ShortenerState> with EmitMixin {
  final ShortenerService shortenerService;
  ShortenerController({required this.shortenerService})
    : super(ShortenerState.initial());

  Future<void> shortUrl(String url) async {
    emit(ShortenerState.loading());
    final result = await shortenerService.shortUrl(url);
    result.fold(
      onLeft: (exception) => emit(ShortenerState.error(exception: exception)),
      onRight: (shortenedUrl){
        final history = value.history;
        history.add(shortenedUrl);
        emit(ShortenerState.success(shortenedUrl: shortenedUrl, history: history));
      }
    );
  }
}
