import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state/recurring_payments/recurring_payment_provider.dart';
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
              : ListView.builder(
                  itemCount: state.payments.length,
                  itemBuilder: (_, index) {
                    final p = state.payments[index];
                    return ListTile(
                      title: Text(p.description),
                      subtitle:
                          Text('${p.amount.toStringAsFixed(2)} - ${p.frequency}'),
                    );
                  },
                ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),
    );
  }
}
