import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../state/recurring_payments/recurring_payment_provider.dart';
import '../../../utils/formatters.dart';
import '../../widgets/app_bottom_navigation.dart';

class RecurringPaymentsScreen extends HookConsumerWidget {
  const RecurringPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recurringPaymentNotifierProvider);

    useEffect(() {
      ref
          .read(recurringPaymentNotifierProvider.notifier)
          .fetchPayments();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Pagos recurrentes')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    for (final p in state.payments)
                      Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(
                            p.description,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${Formatters.money(p.amount)} · ${p.frequency}'),
                              if (p.nextDate != null)
                                Text(
                                  'Próximo pago: ${DateFormat('dd/MM/yyyy').format(p.nextDate!)}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => ref
                                    .read(recurringPaymentNotifierProvider.notifier)
                                    .updateRecurringPayment(p.id),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                onPressed: () => ref
                                    .read(recurringPaymentNotifierProvider.notifier)
                                    .deleteRecurringPayment(p.id),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Agregar Gasto Recurrente'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: const StadiumBorder(),
                      ),
                    ),
                  ],
                ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),
    );
  }
}
