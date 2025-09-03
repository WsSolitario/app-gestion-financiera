import "../services/payment_service.dart";

class PaymentRepository {
  final PaymentService _service;
  PaymentRepository(this._service);

  Future<List<dynamic>> fetchPayments(String groupId) =>
      _service.getPayments(groupId);

  Future<void> createPayment(String groupId, String fromUserId,
          String toUserId, double amount,
          {String? description}) =>
      _service.createPayment(groupId, fromUserId, toUserId, amount,
          description: description);

  Future<void> deletePayment(String id) => _service.deletePayment(id);
}
