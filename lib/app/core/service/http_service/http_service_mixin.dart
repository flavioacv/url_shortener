import '../internet_connection/internet_connection_service.dart';
import 'http_exception.dart';

mixin HttpServiceMixin {
  Future<void> throwErrorIfNotConnectionWithInternet(
    InternetConnectionService service,
  ) async {
    final hasConnection = await service.checkConnection();

    if (!hasConnection) {
      throw const HttpException(
        'Ops! Algo deu errado. Por favor, verifique sua conexão com a internet e tente novamente.',
        code: 500,
      );
    }
  }
}
