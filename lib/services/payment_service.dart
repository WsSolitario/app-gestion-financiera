import '../models/payment.dart';
import 'api_client.dart';

class PaymentService {
  final ApiClient _client;
  PaymentService(this._client);

  Future<List<Payment>> getPayments(String groupId) async {
    final res = await _client.get('/groups/$groupId/payments');
    final data = res.data as List;
    return data.map((p) => Payment.fromJson(p)).toList();
  }

  Future<Payment> getPayment(String groupId, String id) async {
    final res = await _client.get('/groups/$groupId/payments/$id');
    return Payment.fromJson(res.data);
  }

  Future<Payment> createPayment(String groupId, Payment payment) async {
    final res = await _client.post('/groups/$groupId/payments',
        data: payment.toJson());
    return Payment.fromJson(res.data);
  }

  Future<Payment> updatePayment(String groupId, Payment payment) async {
    final res = await _client.put(
        '/groups/$groupId/payments/${payment.id}',
        data: payment.toJson());
    return Payment.fromJson(res.data);
  }

  Future<void> deletePayment(String groupId, String id) =>
      _client.delete('/groups/$groupId/payments/$id');
}

