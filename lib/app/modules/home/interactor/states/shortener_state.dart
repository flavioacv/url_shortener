import 'package:url_shortener/app/core/service/http_service/http_exception.dart';
import 'package:url_shortener/app/modules/home/interactor/models/shortened_url_model.dart';

abstract class ShortenerState {
  final ShortenedUrlModel? shortenedUrl;
  final List<ShortenedUrlModel> history;
  final HttpException? exception;

  ShortenerState({this.shortenedUrl, this.exception, this.history = const []});

  factory ShortenerState.initial() {
    return ShortenerStateInitial();
  }

  factory ShortenerState.loading() {
    return ShortenerStateLoading();
  }

  factory ShortenerState.success({
    required ShortenedUrlModel shortenedUrl,
    required List<ShortenedUrlModel> history,
  }) {
    return ShortenerStateSuccess(shortenedUrl: shortenedUrl, history: history);
  }

  factory ShortenerState.error({required HttpException exception}) {
    return ShortenerStateError(exception: exception);
  }
}

class ShortenerStateInitial extends ShortenerState {
  ShortenerStateInitial() : super();
}

class ShortenerStateLoading extends ShortenerState {
  ShortenerStateLoading() : super();
} 

class ShortenerStateSuccess extends ShortenerState {
  ShortenerStateSuccess({
    required ShortenedUrlModel super.shortenedUrl,
    required super.history,
  });
}

class ShortenerStateError extends ShortenerState {
  ShortenerStateError({required super.exception}) : super();
}
