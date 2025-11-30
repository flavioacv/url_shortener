import 'package:url_shortener/app/core/service/http_service/http_exception.dart';
import 'package:url_shortener/app/modules/home/interactor/models/shortened_url_model.dart';

abstract class ShortenerState {
  final List<ShortenedUrlModel> history;
  final HttpException? exception;

  ShortenerState({this.exception, this.history = const []});

  factory ShortenerState.initial() {
    return ShortenerStateInitial();
  }

  ShortenerState loading() {
    return ShortenerStateLoading(history: history);
  }

  ShortenerState success({required List<ShortenedUrlModel> history}) {
    return ShortenerStateSuccess(history: history);
  }

  ShortenerState error({required HttpException exception}) {
    return ShortenerStateError(exception: exception, history: history);
  }
}

class ShortenerStateInitial extends ShortenerState {
  ShortenerStateInitial() : super();
}

class ShortenerStateLoading extends ShortenerState {
  ShortenerStateLoading({required super.history});
}

class ShortenerStateSuccess extends ShortenerState {
  ShortenerStateSuccess({required super.history});
}

class ShortenerStateError extends ShortenerState {
  ShortenerStateError({required super.exception, required super.history});
}
