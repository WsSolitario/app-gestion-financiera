import "package:dio/dio.dart";

import "../services/api_client.dart";

class AppService {
  final ApiClient _client;
  AppService(this._client);

  Future<String> getAppMode() async {
    try {
      print("Intentando obtener app-mode...");

      // Prueba directa con HTTP
      try {
        final uri = Uri.parse("http://10.10.10.203/api/app-mode");
        print("Probando HTTP directo a: $uri");
        final httpResponse = await Dio().get(uri.toString());
        print("Respuesta HTTP directa: ${httpResponse.data}");
      } catch (e) {
        print("Error en HTTP directo: $e");
      }

      final res = await _client.get("/app-mode");
      print("Respuesta recibida: ${res.data}");
      return res.data["mode_app"] as String;
    } on DioException catch (e) {
      print("Error tipo: ${e.type}");
      print("Error mensaje: ${e.message}");
      print("Error response: ${e.response}");
      if (e.response != null) {
        print("Error status code: ${e.response?.statusCode}");
        print("Error data: ${e.response?.data}");
      }
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
