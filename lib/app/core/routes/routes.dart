import 'package:flutter/material.dart';

class Routes {

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final name = settings.name;

    switch (name) {
      // case splashRoute:
      //   return MaterialPageRoute(
      //     builder: (_) => SplashPage(
      //       localStorage: getIt.get<LocalStorageService>(),
      //       appVersionService: getIt.get<AppVersionService>(),
      //       remoteConfigService: getIt.get<RemoteConfigService>(),
      //     ),
      //   );
      // case homeRoute:
      //   return HomeModule.routes(settings);
      default:
        return null;
    }
  }
}
