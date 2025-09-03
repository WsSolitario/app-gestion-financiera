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
}
