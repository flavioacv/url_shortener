import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static final EnvConfig _instance = EnvConfig._internal();

  factory EnvConfig() {
    return _instance;
  }

  EnvConfig._internal();

  static Future<void> load() async {
    await dotenv.load();
  }

  String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  String get clientIdUrlGov => dotenv.env['CLIENT_ID_URL_GOV'] ?? '';
  String get redirectUrlGov => dotenv.env['REDIRECT_URL_GOV'] ?? '';
  String get schemeGov => dotenv.env['SCHEME'] ?? '';
  String get hostGov => dotenv.env['HOST'] ?? '';
  String get pathGov => dotenv.env['PATH'] ?? '';
  String get enviroment => dotenv.env['ENVIRONMENT'] ?? '';
}
