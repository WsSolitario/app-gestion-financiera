import "package:dio/dio.dart";

import "../models/notification.dart";
import "../services/api_client.dart";

class NotificationService {
  final ApiClient _client;
  NotificationService(this._client);

  Future<void> registerDevice(String deviceToken, String deviceType) async {
    try {
      await _client.post(
        "/notifications/register-device",
        data: {"device_token": deviceToken, "device_type": deviceType},
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<List<AppNotification>> getNotifications() async {
    try {
      final res = await _client.get(
        "/notifications",
        queryParameters: <String, dynamic>{},
      );
      final data = res.data as List;
      return data.map((e) => AppNotification.fromJson(e)).toList();
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
