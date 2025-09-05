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
        group_id: groupId,
        status: status,
        direction: direction,
        start_date: startDate,
        end_date: endDate,
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
        group_id: groupId,
        from_user_id: fromUserId,
        to_user_id: toUserId,
        amount: amount,
        note: note,
        evidence_url: evidenceUrl,
        payment_method: paymentMethod,
      );

  Future<Payment> approvePayment(String id) => _service.approvePayment(id);

  Future<Payment> rejectPayment(String id) => _service.rejectPayment(id);

  Future<List<Payment>> getDuePayments({String? groupId}) =>
      _service.getDuePayments(group_id: groupId);

  Future<void> deletePayment(String id) => _service.deletePayment(id);
}
