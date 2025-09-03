import '../../models/recurring_payment.dart';

class RecurringPaymentState {
  final List<RecurringPayment> payments;
  final bool isLoading;
  final String? error;

  const RecurringPaymentState({
    this.payments = const [],
    this.isLoading = false,
    this.error,
  });

  RecurringPaymentState copyWith({
    List<RecurringPayment>? payments,
    bool? isLoading,
    String? error,
  }) {
    return RecurringPaymentState(
      payments: payments ?? this.payments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory RecurringPaymentState.initial() => const RecurringPaymentState();
}
