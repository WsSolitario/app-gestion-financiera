import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../config/locator.dart';
import '../../repositories/recurring_payment_repository.dart';
import 'recurring_payment_state.dart';

final recurringPaymentNotifierProvider =
    StateNotifierProvider<RecurringPaymentNotifier, RecurringPaymentState>((ref) {
  return RecurringPaymentNotifier(locator<RecurringPaymentRepository>());
});

class RecurringPaymentNotifier
    extends StateNotifier<RecurringPaymentState> {
  final RecurringPaymentRepository _repo;
  RecurringPaymentNotifier(this._repo)
      : super(RecurringPaymentState.initial());

  Future<void> fetchPayments({String? groupId}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final payments = await _repo.getRecurringPayments(groupId: groupId);
      state = state.copyWith(payments: payments, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createRecurringPayment({
    required String groupId,
    required String description,
    required double amount,
    required String frequency,
    DateTime? nextDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final payment = await _repo.createRecurringPayment(
        groupId: groupId,
        description: description,
        amount: amount,
        frequency: frequency,
        nextDate: nextDate,
      );
      state = state.copyWith(
        payments: [...state.payments, payment],
        isLoading: false,
      );
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateRecurringPayment(
    String id, {
    String? description,
    double? amount,
    String? frequency,
    DateTime? nextDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updated = await _repo.updateRecurringPayment(
        id,
        description: description,
        amount: amount,
        frequency: frequency,
        nextDate: nextDate,
      );
      state = state.copyWith(
        payments:
            state.payments.map((p) => p.id == id ? updated : p).toList(),
        isLoading: false,
      );
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteRecurringPayment(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.deleteRecurringPayment(id);
      state = state.copyWith(
        payments: state.payments.where((p) => p.id != id).toList(),
        isLoading: false,
      );
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
