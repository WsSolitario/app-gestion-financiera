import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/locator.dart';
import '../../models/payment.dart';
import '../../repositories/payment_repository.dart';
import 'payment_state.dart';

final paymentNotifierProvider =
    StateNotifierProvider<PaymentNotifier, PaymentState>((ref) {
  return PaymentNotifier(locator<PaymentRepository>());
});

class PaymentNotifier extends StateNotifier<PaymentState> {
  final PaymentRepository _repo;

  PaymentNotifier(this._repo) : super(PaymentState.initial());

  Future<void> fetchPayments({
    String? groupId,
    String? status,
    String? direction,
    String? startDate,
    String? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final payments = await _repo.getPayments(
        groupId: groupId,
        status: status,
        direction: direction,
        startDate: startDate,
        endDate: endDate,
      );
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

  Future<void> addPayment({
    required String groupId,
    required String fromUserId,
    required String toUserId,
    required double amount,
    String? note,
    String? evidenceUrl,
    String? paymentMethod,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final payment = await _repo.createPayment(
        groupId: groupId,
        fromUserId: fromUserId,
        toUserId: toUserId,
        amount: amount,
        note: note,
        evidenceUrl: evidenceUrl,
        paymentMethod: paymentMethod,
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

  Future<void> approvePayment(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updated = await _repo.approvePayment(id);
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

  Future<void> rejectPayment(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updated = await _repo.rejectPayment(id);
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

  Payment? getById(String id) {
    try {
      return state.payments.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

