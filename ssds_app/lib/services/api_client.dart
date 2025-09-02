import "package:dio/dio.dart";
import "../config/env.dart";
import "../repositories/auth_repository.dart";
import "../config/locator.dart";

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options.baseUrl = Env.apiBaseUrl;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await locator<AuthRepository>().getToken();
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onError: (e, handler) {
        // Puedes centralizar manejo de 401/500 aquí
        return handler.next(e);
      },
    ));
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) =>
      _dio.get(path, queryParameters: query);

  Future<Response<T>> post<T>(String path, {dynamic data, Map<String, dynamic>? query}) =>
      _dio.post(path, data: data, queryParameters: query);

  Future<Response<T>> put<T>(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  Future<Response<T>> delete<T>(String path) =>
      _dio.delete(path);
}
