// lib/services/payment_service.dart
import 'package:dio/dio.dart';

import '../models/payment.dart';
import '../services/api_client.dart';

class PaymentService {
  final ApiClient _client;
  PaymentService(this._client);

  /// GET /payments[?status][&direction][&group_id][&start_date][&end_date]
  Future<List<Payment>> getPayments({
    String? groupId,
    String? status, // "approved" | "pending" | "rejected"
    String? direction, // "sent" | "received"
    String? startDate, // YYYY-MM-DD
    String? endDate, // YYYY-MM-DD
  }) async {
    try {
      final res = await _client.get(
        '/payments',
        query: {
          if (groupId != null) 'group_id': groupId,
          if (status != null) 'status': status,
          if (direction != null) 'direction': direction,
          if (startDate != null) 'start_date': startDate,
          if (endDate != null) 'end_date': endDate,
        },
      );
      final data = res.data as List;
      return data.map((e) => Payment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// POST /payments
  /// Body: { group_id, from_user_id, to_user_id, amount, note?, evidence_url?, payment_method? }
  Future<Payment> createPayment({
    required String groupId,
    required String fromUserId,
    required String toUserId,
    required double amount,
    String? note,
    String? evidenceUrl,
    String? paymentMethod, // "cash" | "transfer" | ...
  }) async {
    try {
      final res = await _client.post(
        '/payments',
        data: {
          'group_id': groupId,
          'from_user_id': fromUserId,
          'to_user_id': toUserId,
          'amount': amount,
          if (note != null) 'note': note,
          if (evidenceUrl != null) 'evidence_url': evidenceUrl,
          if (paymentMethod != null) 'payment_method': paymentMethod,
        },
      );
      return Payment.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// DELETE /payments/{id}
  Future<void> deletePayment(String id) async {
    try {
      await _client.delete('/payments/$id');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// POST /payments/{id}/approve
  Future<Payment> approvePayment(String id) async {
    try {
      final res = await _client.post('/payments/$id/approve');
      return Payment.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// POST /payments/{id}/reject
  Future<Payment> rejectPayment(String id) async {
    try {
      final res = await _client.post('/payments/$id/reject');
      return Payment.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// GET /payments/due[?group_id]
  Future<List<Payment>> getDuePayments({String? groupId}) async {
    try {
      final res = await _client.get(
        '/payments/due',
        query: {if (groupId != null) 'group_id': groupId},
      );
      final data = res.data as List;
      return data.map((e) => Payment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}
