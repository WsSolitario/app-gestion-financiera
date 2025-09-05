// lib/services/recurring_payment_service.dart
import 'package:dio/dio.dart';
import '../models/recurring_payment.dart';
import '../services/api_client.dart';

class RecurringPaymentService {
  final ApiClient _client;
  RecurringPaymentService(this._client);

  Future<List<RecurringPayment>> getRecurringPayments({String? groupId}) async {
    try {
      final res = await _client.get('/recurring-payments', query: {
        if (groupId != null) 'group_id': groupId,
      });
      final data = res.data as List;
      return data.map((e) => RecurringPayment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  Future<RecurringPayment> createRecurringPayment({
    required String groupId,
    required String description,
    required double amount,
    required String frequency,
    DateTime? nextDate,
  }) async {
    try {
      final res = await _client.post('/recurring-payments', data: {
        'group_id': groupId,
        'description': description,
        'amount': amount,
        'frequency': frequency,
        if (nextDate != null) 'next_date': nextDate.toIso8601String(),
      });
      return RecurringPayment.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  Future<RecurringPayment> updateRecurringPayment(
    String id, {
    String? description,
    double? amount,
    String? frequency,
    DateTime? nextDate,
  }) async {
    try {
      final res = await _client.put('/recurring-payments/$id', data: {
        if (description != null) 'description': description,
        if (amount != null) 'amount': amount,
        if (frequency != null) 'frequency': frequency,
        if (nextDate != null) 'next_date': nextDate.toIso8601String(),
      });
      return RecurringPayment.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  Future<void> deleteRecurringPayment(String id) async {
    try {
      await _client.delete('/recurring-payments/$id');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}
