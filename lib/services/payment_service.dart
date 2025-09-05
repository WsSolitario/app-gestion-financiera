import "package:dio/dio.dart";

import "../models/payment.dart";
import "../services/api_client.dart";

class PaymentService {
  final ApiClient _client;
  PaymentService(this._client);

  /// GET /api/payments[?status][&direction][&group_id][&start_date][&end_date]
  Future<List<Payment>> getPayments({
    String? group_id,
    String? status,     // "approved" | "pending" | "rejected"
    String? direction,  // "sent" | "received" (según tu implementación)
    String? start_date, // YYYY-MM-DD
    String? end_date,   // YYYY-MM-DD
  }) async {
    try {
      final res = await _client.get("/payments", query: {
        if (group_id != null) "group_id": group_id,
        if (status != null) "status": status,
        if (direction != null) "direction": direction,
        if (start_date != null) "start_date": start_date,
        if (end_date != null) "end_date": end_date,
      });
      final data = res.data as List;
      return data.map((e) => Payment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }

  /// POST /api/payments
  /// Body: { group_id, from_user_id, to_user_id, amount, note?, evidence_url?, payment_method? }
  Future<Payment> createPayment({
    required String group_id,
    required String from_user_id,
    required String to_user_id,
    required double amount,
    String? note,
    String? evidence_url,
    String? payment_method, // "cash" | "transfer"
  }) async {
    try {
      final res = await _client.post("/payments", data: {
        "group_id": group_id,
        "from_user_id": from_user_id,
        "to_user_id": to_user_id,
        "amount": amount,
        if (note != null) "note": note,
        if (evidence_url != null) "evidence_url": evidence_url,
        if (payment_method != null) "payment_method": payment_method,
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

  /// GET /api/payments/due[?group_id]
  Future<List<Payment>> getDuePayments({String? group_id}) async {
    try {
      final res = await _client.get(
        "/payments/due",
        query: {
          if (group_id != null) "group_id": group_id,
        },
      );
      final data = res.data as List;
      return data.map((e) => Payment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? e.message);
    }
  }
}
