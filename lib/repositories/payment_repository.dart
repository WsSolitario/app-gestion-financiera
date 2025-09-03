import '../models/payment.dart';
import '../services/payment_service.dart';

class PaymentRepository {
  final PaymentService _service;
  PaymentRepository(this._service);

  Future<List<Payment>> getPayments({
    String? groupId,
    String? status,
    String? direction,
    String? startDate,
    String? endDate,
  }) =>
      _service.getPayments(
        groupId: groupId,
        status: status,
        direction: direction,
        startDate: startDate,
        endDate: endDate,
      );

  Future<Payment> createPayment({
    required String groupId,
    required String fromUserId,
    required String toUserId,
    required double amount,
    String? note,
    String? evidenceUrl,
    String? paymentMethod,
  }) =>
      _service.createPayment(
        groupId: groupId,
        fromUserId: fromUserId,
        toUserId: toUserId,
        amount: amount,
        note: note,
        evidenceUrl: evidenceUrl,
        paymentMethod: paymentMethod,
      );

  Future<Payment> approvePayment(String id) => _service.approvePayment(id);

  Future<Payment> rejectPayment(String id) => _service.rejectPayment(id);

  Future<List<Payment>> getDuePayments({String? groupId}) =>
      _service.getDuePayments(groupId: groupId);

  Future<void> deletePayment(String id) => _service.deletePayment(id);
}
