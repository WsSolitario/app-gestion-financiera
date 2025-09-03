import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../config/locator.dart';
import '../../repositories/payment_repository.dart';
import '../../models/payment.dart';
import 'payment_state.dart';

final paymentNotifierProvider =
    StateNotifierProvider<PaymentNotifier, PaymentState>((ref) {
  return PaymentNotifier(locator<PaymentRepository>());
});

class PaymentNotifier extends StateNotifier<PaymentState> {
  final PaymentRepository _repo;
  PaymentNotifier(this._repo) : super(PaymentState.initial());

  Future<void> fetchPayments(String groupId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final payments = await _repo.fetchPayments(groupId);
      state = state.copyWith(payments: payments, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createPayment(
    String groupId,
    String fromUserId,
    String toUserId,
    double amount, {
    String? description,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.createPayment(
        groupId,
        fromUserId,
        toUserId,
        amount,
        description: description,
      );
      final payments = await _repo.fetchPayments(groupId);
      state = state.copyWith(payments: payments, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> approvePayment(String id, String groupId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.approvePayment(id);
      final payments = await _repo.fetchPayments(groupId);
      state = state.copyWith(payments: payments, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> rejectPayment(String id, String groupId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repo.rejectPayment(id);
      final payments = await _repo.fetchPayments(groupId);
      state = state.copyWith(payments: payments, isLoading: false);
    } on DioException catch (e) {
      state = state.copyWith(
          isLoading: false, error: e.response?.data['message'] ?? e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
