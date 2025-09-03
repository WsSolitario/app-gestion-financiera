import "package:dio/dio.dart";

import "../models/payment.dart";
import "../services/api_client.dart";

class PaymentService {
  final ApiClient _client;
  PaymentService(this._client);

  /// GET /api/payments[?status][&direction][&groupId][&startDate][&endDate]
  Future<List<Payment>> getPayments({
    String? groupId,
    String? status,     // "approved" | "pending" | "rejected"
    String? direction,  // "sent" | "received" (según tu implementación)
    String? startDate,  // YYYY-MM-DD
    String? endDate,    // YYYY-MM-DD
  }) async {
    try {
      final res = await _client.get("/payments", query: {
        if (groupId != null) "groupId": groupId,
        if (status != null) "status": status,
        if (direction != null) "direction": direction,
        if (startDate != null) "startDate": startDate,
        if (endDate != null) "endDate": endDate,
      });
      final data = res.data as List;
      return data.map((e) => Payment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  /// POST /api/payments
  /// Body: { groupId, fromUserId, toUserId, amount, note?, evidenceUrl?, paymentMethod? }
  Future<Payment> createPayment({
    required String groupId,
    required String fromUserId,
    required String toUserId,
    required double amount,
    String? note,
    String? evidenceUrl,
    String? paymentMethod, // "cash" | "transfer"
  }) async {
    try {
      final res = await _client.post("/payments", data: {
        "groupId": groupId,
        "fromUserId": fromUserId,
        "toUserId": toUserId,
        "amount": amount,
        if (note != null) "note": note,
        if (evidenceUrl != null) "evidenceUrl": evidenceUrl,
        if (paymentMethod != null) "paymentMethod": paymentMethod,
      });
      return Payment.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  /// DELETE /api/payments/{id}
  Future<void> deletePayment(String id) async {
    try {
      await _client.delete("/payments/$id");
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  /// POST /api/payments/{id}/approve
  Future<Payment> approvePayment(String id) async {
    try {
      final res = await _client.post("/payments/$id/approve");
      return Payment.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  /// POST /api/payments/{id}/reject
  Future<Payment> rejectPayment(String id) async {
    try {
      final res = await _client.post("/payments/$id/reject");
      return Payment.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  /// GET /api/payments/due[?groupId]
  Future<List<Payment>> getDuePayments({String? groupId}) async {
    try {
      final res = await _client.get(
        "/payments/due",
        query: {
          if (groupId != null) "groupId": groupId,
        },
      );
      final data = res.data as List;
      return data.map((e) => Payment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
