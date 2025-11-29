import 'package:flutter/material.dart';
import 'package:url_shortener/app/core/routes/routes.dart';
import 'package:url_shortener/app/core/themes/theme_data.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Url Shortener',
      theme: themeData,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
