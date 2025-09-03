import "package:dio/dio.dart";

import "../services/api_client.dart";

class PaymentService {
  final ApiClient _client;
  PaymentService(this._client);

  Future<List<dynamic>> getPayments(String groupId) async {
    try {
      final res = await _client.get("/groups/$groupId/payments");
      return List<dynamic>.from(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> createPayment(String groupId, String fromUserId, String toUserId,
      double amount,
      {String? description}) async {
    try {
      await _client.post("/payments", data: {
        "group_id": groupId,
        "from_user_id": fromUserId,
        "to_user_id": toUserId,
        "amount": amount,
        if (description != null) "description": description,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> deletePayment(String id) async {
    try {
      await _client.delete("/payments/$id");
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
