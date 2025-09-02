import '../models/payment.dart';
import '../services/payment_service.dart';

class PaymentRepository {
  final PaymentService _service;
  PaymentRepository(this._service);

  Future<List<Payment>> getPayments(String groupId) =>
      _service.getPayments(groupId);

  Future<Payment> getPayment(String groupId, String id) =>
      _service.getPayment(groupId, id);

  Future<Payment> createPayment(String groupId, Payment payment) =>
      _service.createPayment(groupId, payment);

  Future<Payment> updatePayment(String groupId, Payment payment) =>
      _service.updatePayment(groupId, payment);

  Future<void> deletePayment(String groupId, String id) =>
      _service.deletePayment(groupId, id);
}

