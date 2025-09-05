import 'expense.dart';
import 'payment.dart';
import 'notification.dart';

class DashboardData {
  final List<Expense> expenses;
  final List<Payment> payments;
  final List<AppNotification> notifications;

  const DashboardData({
    this.expenses = const [],
    this.payments = const [],
    this.notifications = const [],
  });
}

