import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/locator.dart';
import '../../models/dashboard_data.dart';
import '../../services/expense_service.dart';
import '../../services/payment_service.dart';
import '../../services/notification_service.dart';

/// Provides combined data for the dashboard screen.
final dashboardProvider = FutureProvider<DashboardData>((ref) async {
  final expenseService = locator<ExpenseService>();
  final paymentService = locator<PaymentService>();
  final notificationService = locator<NotificationService>();

  // Fetch all data in parallel
  final expensesFuture = expenseService.getExpenses('');
  final paymentsFuture = paymentService.getDuePayments();
  final notificationsFuture = notificationService.getNotifications();

  final expenses = await expensesFuture;
  final payments = await paymentsFuture;
  final notifications = await notificationsFuture;

  return DashboardData(
    expenses: expenses,
    payments: payments,
    notifications: notifications,
  );
});

