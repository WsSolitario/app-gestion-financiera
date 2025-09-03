import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state/payments/payment_provider.dart';

class PaymentListScreen extends HookConsumerWidget {
  final String groupId;
  const PaymentListScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentNotifierProvider);

    useEffect(() {
      ref.read(paymentNotifierProvider.notifier).fetchPayments(groupId: groupId);
      return null;
    }, [groupId]);

    return Scaffold(
      appBar: AppBar(title: const Text('Pagos')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : ListView.builder(
                  itemCount: state.payments.length,
                  itemBuilder: (_, index) {
                    final payment = state.payments[index];
                    return ListTile(
                      title: Text('\\$${payment.amount.toStringAsFixed(2)}'),
                      subtitle: Text(payment.note ?? ''),
                      trailing: Text(payment.status.name),
                      onTap: () => context.push(
                          '/groups/$groupId/payments/${payment.id}'),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/groups/$groupId/payments/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

