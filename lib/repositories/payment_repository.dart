// lib/services/payment_service.dart
// ignore: unused_import
import 'package:ssds_app/services/payment_service.dart';

import '../services/api_client.dart';
import '../models/payment.dart';

class PaymentService {
  final ApiClient _api;
  PaymentService(this._api);

  Map<String, dynamic> _clean(Map<String, dynamic> m) =>
      Map.fromEntries(m.entries.where((e) => e.value != null));

  // GET /api/payments  (query usa camelCase: groupId, startDate, endDate)
  Future<List<Payment>> getPayments({
    String? groupId,
    String? status,
    String? direction,
    String? startDate,
    String? endDate,
  }) async {
    final query = _clean({
      'groupId': groupId, // ← camelCase según docs
      'status': status,
      'direction': direction,
      'startDate': startDate,
      'endDate': endDate,
    });
    final res = await _api.get('/api/payments', queryParameters: query);
    final list = (res.data as List);
    return list.map((j) => Payment.fromJson(j)).toList();
  }

  // POST /api/payments  (body en snake_case)
  Future<Payment> createPayment({
    required String groupId,
    required String fromUserId,
    required String toUserId,
    required double amount,
    String? note,
    String? evidenceUrl,
    String? paymentMethod,
  }) async {
    final body = _clean({
      'group_id': groupId, // ← snake_case en body
      'from_user_id': fromUserId,
      'to_user_id': toUserId,
      'amount': amount,
      'note': note,
      'evidence_url': evidenceUrl,
      'payment_method': paymentMethod,
    });
    final res = await _api.post('/api/payments', data: body);
    return Payment.fromJson(res.data);
  }

  // PUT /api/payments/{id}  (body en snake_case)
  Future<Payment> updatePayment(
    String id, {
    String? paymentMethod,
    String? evidenceUrl,
    String? signature,
  }) async {
    final body = _clean({
      'payment_method': paymentMethod,
      'evidence_url': evidenceUrl,
      'signature': signature,
    });
    final res = await _api.put('/api/payments/$id', data: body);
    return Payment.fromJson(res.data);
  }

  // POST /api/payments/{id}/approve
  Future<Payment> approvePayment(String id) async {
    final res = await _api.post('/api/payments/$id/approve');
    return Payment.fromJson(res.data);
  }

  // POST /api/payments/{id}/reject
  Future<Payment> rejectPayment(String id) async {
    final res = await _api.post('/api/payments/$id/reject');
    return Payment.fromJson(res.data);
  }

  // GET /api/payments/due  (query usa group_id en snake_case)
  Future<List<Payment>> getDuePayments({String? groupId}) async {
    final query = _clean({'group_id': groupId}); // ← excepción
    final res = await _api.get('/api/payments/due', queryParameters: query);
    final list = (res.data as List);
    return list.map((j) => Payment.fromJson(j)).toList();
  }

  // DELETE /api/payments/{id}
  Future<void> deletePayment(String id) async {
    await _api.delete('/api/payments/$id');
  }
}

class PaymentRepository {
  PaymentRepository(PaymentService paymentService);

  Future getPayments({
    String? groupId,
    String? status,
    String? direction,
    String? startDate,
    String? endDate,
  }) async {}

  Future createPayment({
    required String groupId,
    required String fromUserId,
    required String toUserId,
    required double amount,
    String? note,
    String? evidenceUrl,
    String? paymentMethod,
  }) async {}

  Future approvePayment(String id) async {}

  Future rejectPayment(String id) async {}
}
