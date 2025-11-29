import 'package:flutter/material.dart';
import 'package:url_shortener/app/app_widget.dart';
import 'package:url_shortener/app/core/injection/injection.dart';

void main() async {
  await Injection.init();
  runApp(const AppWidget());
}
