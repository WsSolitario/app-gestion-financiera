import "package:dio/dio.dart";

import "../services/api_client.dart";

class PaymentService {
  final ApiClient _client;
  PaymentService(this._client);

  Future<List<dynamic>> getPayments(String expenseId) async {
    try {
      final res = await _client.get("/expenses/$expenseId/payments");
      return List<dynamic>.from(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> createPayment(
      String expenseId, double amount, String payerId) async {
    try {
      await _client.post("/payments", data: {
        "expenseId": expenseId,
        "amount": amount,
        "payerId": payerId,
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
