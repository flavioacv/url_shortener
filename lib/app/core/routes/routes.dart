import 'package:flutter/material.dart';
import 'package:url_shortener/app/modules/home/ui/pages/home_page.dart';
import 'package:url_shortener/app/modules/splash/pages/splash_page.dart';

class Routes {
  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final name = settings.name;

    switch (name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return null;
    }
  }
}
