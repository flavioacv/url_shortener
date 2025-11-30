import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_shortener/app/core/injection/injection.dart';
import 'package:url_shortener/app/core/routes/routes.dart';
import 'package:url_shortener/app/modules/home/data/services/shortener_service_impl.dart';
import 'package:url_shortener/app/modules/home/interactor/controllers/shortener_controller.dart';
import 'package:url_shortener/app/modules/home/interactor/services/shortener_service.dart';
import 'package:url_shortener/app/modules/home/ui/pages/home_page.dart';

class HomeModule {
  static Future<void> binds(GetIt i) async {
    i.registerLazySingleton<ShortenerService>(
      () => ShortenerServiceImpl(httpClientService: i()),
    );
    i.registerLazySingleton<ShortenerController>(
      () => ShortenerController(shortenerService: i()),
    );
  }

  static Route<dynamic> routes(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case Routes.homeRoute:
        // final args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) =>
              HomePage(controller: getIt.get<ShortenerController>()),
        );

      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
