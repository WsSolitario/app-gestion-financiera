import "package:dio/dio.dart";

import "../config/env.dart";
import "../config/locator.dart";
import "../repositories/auth_repository.dart";

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options.baseUrl = Env.apiBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    _dio.options.validateStatus =
        (status) => status != null && status >= 200 && status < 300;

    // Agregar logging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await locator<AuthRepository>().getToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            await locator<AuthRepository>().logout();
          }
          final message = _mapError(e);
          return handler.reject(e.copyWith(message: message));
        },
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) => _dio.get(path, queryParameters: query);

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  }) => _dio.post(path, data: data, queryParameters: query);

  Future<Response<T>> put<T>(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  Future<Response<T>> delete<T>(String path) => _dio.delete(path);

  static String _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return "Tiempo de conexión agotado. Intenta nuevamente.";
    }

    if (e.type == DioExceptionType.connectionError) {
      return "Error de conexión. Verifica tu red.";
    }

    switch (e.response?.statusCode) {
      case 400:
        return "Solicitud inválida.";
      case 401:
        return "Sesión expirada. Inicia sesión nuevamente.";
      case 403:
        return "No autorizado.";
      case 404:
        return "Recurso no encontrado.";
      case 500:
        return "Error interno del servidor.";
      default:
        return "Ocurrió un error inesperado.";
    }
  }
}
