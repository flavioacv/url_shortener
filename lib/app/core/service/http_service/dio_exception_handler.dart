import 'package:dio/dio.dart';

/// Utilitário para mapear exceções do Dio em mensagens amigáveis ao usuário
class DioExceptionHandler {
  /// Retorna uma mensagem amigável baseada no tipo de exceção e status code
  static String getDefaultMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tempo de conexão esgotado. Verifique sua internet.';

      case DioExceptionType.sendTimeout:
        return 'Tempo esgotado ao enviar dados para o servidor.';

      case DioExceptionType.receiveTimeout:
        return 'Tempo esgotado ao receber dados do servidor.';

      case DioExceptionType.badCertificate:
        return 'Certificado SSL inválido.';

      case DioExceptionType.badResponse:
        return _getMessageByStatusCode(exception.response?.statusCode);

      case DioExceptionType.cancel:
        return 'Requisição cancelada.';

      case DioExceptionType.connectionError:
        return 'Erro de conexão. Verifique sua rede.';

      case DioExceptionType.unknown:
        return 'Erro inesperado. Verifique sua conexão ou tente novamente mais tarde.';
    }
  }

  /// Retorna mensagem específica baseada no status code HTTP
  static String _getMessageByStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Requisição inválida. Verifique os dados enviados.';

      case 401:
        return 'Acesso não autorizado. Faça login novamente.';

      case 403:
        return 'Você não tem permissão para acessar este recurso.';

      case 404:
        return 'Recurso não encontrado. Verifique a URL.';

      case 500:
        return 'Erro interno do servidor. Tente novamente mais tarde.';

      default:
        return 'Erro desconhecido na resposta do servidor.';
    }
  }
}
