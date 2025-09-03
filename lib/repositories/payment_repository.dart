import "../models/payment.dart";
import "../services/payment_service.dart";

class PaymentRepository {
  final PaymentService _service;
  PaymentRepository(this._service);

  Future<List<Payment>> fetchPayments(String groupId) =>
      _service.getPayments(groupId: groupId);

  Future<Payment> createPayment(
    String groupId,
    String fromUserId,
    String toUserId,
    double amount, {
    String? description,
  }) =>
      _service.createPayment(
        groupId: groupId,
        fromUserId: fromUserId,
        toUserId: toUserId,
        amount: amount,
        note: description,
      );

  Future<Payment> approvePayment(String id) => _service.approvePayment(id);

  Future<Payment> rejectPayment(String id) => _service.rejectPayment(id);

  Future<void> deletePayment(String id) => _service.deletePayment(id);
}
