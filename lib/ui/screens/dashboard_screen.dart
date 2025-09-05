import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../routes.dart';
import '../../models/expense.dart';
import '../../models/payment.dart';
import '../../models/notification.dart';
import '../../state/dashboard/dashboard_provider.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/section_header.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Nuevo gasto'),
              onTap: () {
                Navigator.of(context).pop();
                context.push(AppRoutes.groups); // Navigate to select group/expense
              },
            ),
            ListTile(
              leading: const Icon(Icons.payments),
              title: const Text('Nuevo pago'),
              onTap: () {
                Navigator.of(context).pop();
                context.push(AppRoutes.groups); // Navigate to select group/payment
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddOptions(context),
          ),
          IconButton(
            onPressed: () => context.push(AppRoutes.profile),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),
      body: dashboardAsync.when(
        data: (data) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SectionHeader('Gastos Recientes'),
            if (data.expenses.isEmpty)
              const ListTile(title: Text('No hay gastos recientes'))
            else
              ...data.expenses.map(_expenseTile),
            const SectionHeader('Deudas Pendientes'),
            if (data.payments.isEmpty)
              const ListTile(title: Text('No hay deudas pendientes'))
            else
              ...data.payments.map(_paymentTile),
            const SectionHeader('Actividad de Grupo'),
            if (data.notifications.isEmpty)
              const ListTile(title: Text('Sin actividad'))
            else
              ...data.notifications.map(_notificationTile),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: \$e')),
      ),
    );
  }

  Widget _expenseTile(Expense e) {
    final date = e.expenseDate != null
        ? DateFormat.yMd().format(e.expenseDate!)
        : '';
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(e.description),
      subtitle: Text(date),
      trailing: Text('\$${e.totalAmount.toStringAsFixed(2)}'),
    );
  }

  Widget _paymentTile(Payment p) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(p.toUserId),
      subtitle: Text(p.note ?? ''),
      trailing: Text(
        '\$${p.amount.toStringAsFixed(2)}',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _notificationTile(AppNotification n) {
    final date = n.createdAt != null
        ? DateFormat.Hm().format(n.createdAt!)
        : '';
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(n.title),
      subtitle: Text(n.body),
      trailing: Text(date, style: const TextStyle(fontSize: 12)),
    );
  }
}

