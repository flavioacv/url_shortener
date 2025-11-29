class EnvConfig {
  static final EnvConfig _instance = EnvConfig._internal();
  factory EnvConfig() {
    return _instance;
  }
  EnvConfig._internal();

  
  String get baseUrl => 'https://url-shortener-server.onrender.com';
}
