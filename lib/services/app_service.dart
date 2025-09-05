import "package:dio/dio.dart";

import "../services/api_client.dart";

class AppService {
  final ApiClient _client;
  AppService(this._client);

  Future<String> getAppMode() async {
    try {
      final res = await _client.get("/app-mode", queryParameters: {});
      return res.data["mode"] as String;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
