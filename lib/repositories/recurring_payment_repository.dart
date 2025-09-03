import '../models/recurring_payment.dart';
import '../services/recurring_payment_service.dart';

class RecurringPaymentRepository {
  final RecurringPaymentService _service;
  RecurringPaymentRepository(this._service);

  Future<List<RecurringPayment>> getRecurringPayments({String? groupId}) =>
      _service.getRecurringPayments(groupId: groupId);

  Future<RecurringPayment> createRecurringPayment({
    required String groupId,
    required String description,
    required double amount,
    required String frequency,
  }) =>
      _service.createRecurringPayment(
        groupId: groupId,
        description: description,
        amount: amount,
        frequency: frequency,
      );

  Future<RecurringPayment> updateRecurringPayment(String id,
          {String? description,
          double? amount,
          String? frequency,
          DateTime? nextDate}) =>
      _service.updateRecurringPayment(
        id,
        description: description,
        amount: amount,
        frequency: frequency,
        nextDate: nextDate,
      );

  Future<void> deleteRecurringPayment(String id) =>
      _service.deleteRecurringPayment(id);
}
