import "package:dio/dio.dart";

import "../services/api_client.dart";

class NotificationService {
  final ApiClient _client;
  NotificationService(this._client);

  Future<void> registerDevice(String deviceToken, String deviceType) async {
    try {
      await _client.post("/notifications/register-device", data: {
        "device_token": deviceToken,
        "device_type": deviceType,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<List<dynamic>> getNotifications() async {
    try {
      final res = await _client.get("/notifications");
      return List<dynamic>.from(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _client.post("/notifications/$id/read");
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await _client.delete("/notifications/$id");
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
