import "package:dio/dio.dart";

import "../models/payment.dart";
import "../services/api_client.dart";

class PaymentService {
  final ApiClient _client;
  PaymentService(this._client);

  Future<List<Payment>> getPayments(String expenseId) async {
    try {
      final res = await _client.get("/expenses/$expenseId/payments");
      final data = res.data as List;
      return data.map((e) => Payment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  Future<Payment> createPayment(
      String expenseId, double amount, String payerId) async {
    try {
      final res = await _client.post("/payments", data: {
        "expenseId": expenseId,
        "amount": amount,
        "payerId": payerId,
      });
      return Payment.fromJson(res.data);
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
