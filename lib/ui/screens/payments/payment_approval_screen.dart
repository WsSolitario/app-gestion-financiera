import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/payment.dart';
import '../../../state/payments/payment_provider.dart';

class PaymentApprovalScreen extends HookConsumerWidget {
  final String id;
  const PaymentApprovalScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentNotifierProvider);
    Payment? payment;
    try {
      payment = state.payments.firstWhere((p) => p.id == id);
    } catch (_) {}

    final location = GoRouterState.of(context).uri.toString();
    final segments = Uri.parse(location).pathSegments;
    final groupId = segments.length >= 2 ? segments[1] : '';

    useEffect(() {
      if (payment == null && groupId.isNotEmpty) {
        ref
            .read(paymentNotifierProvider.notifier)
            .fetchPayments(groupId: groupId);
      }
      return null;
    }, [groupId, payment]);

    return Scaffold(
      appBar: AppBar(title: const Text('Pago')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? Center(child: Text(state.error!))
          : payment == null
          ? const Center(child: Text('Pago no encontrado'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Monto: \$${payment.amount.toStringAsFixed(2)}'),
                  if (payment.note != null) Text('Nota: ${payment.note}'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            await ref
                                .read(paymentNotifierProvider.notifier)
                                .rejectPayment(payment!.id, groupId);
                            if (context.mounted) context.pop();
                          },
                          child: const Text('Rechazar'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await ref
                                .read(paymentNotifierProvider.notifier)
                                .approvePayment(payment!.id, groupId);
                            if (context.mounted) context.pop();
                          },
                          child: const Text('Aprobar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
