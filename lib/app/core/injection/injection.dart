import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:url_shortener/app/core/env/env.dart';
import 'package:url_shortener/app/core/service/http_service/dio/http_client_dio_service_impl.dart';
import 'package:url_shortener/app/core/service/http_service/http_client_service.dart';
import 'package:url_shortener/app/core/service/internet_connection/internet_connection_service.dart';
import 'package:url_shortener/app/core/service/internet_connection/internet_connection_service_impl.dart';

final getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    await _services();
    // await LoginModule.binds(getIt);
  }

  static Future<void> _services() async {
    getIt.registerSingleton<Dio>(
      Dio(
        BaseOptions(
          baseUrl: EnvConfig().baseUrl,
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          connectTimeout: const Duration(seconds: 60),
        ),
      ),
    );

    getIt.registerSingleton<InternetConnectionService>(
      InternetConnecionServiceImpl(),
    );

    getIt.registerSingleton<HttpClientService>(
      HttpClientDioServiceImpl(
        dio: getIt(),
        internetConnectionService: getIt(),
      ),
    );

    // getIt.registerSingleton<UrlLauncherService>(UrlLauncherServiceImpl());
  }
}
