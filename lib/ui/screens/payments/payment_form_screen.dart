import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state/payments/payment_provider.dart';

class PaymentFormScreen extends HookConsumerWidget {
  final String groupId;
  const PaymentFormScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromController = useTextEditingController();
    final toController = useTextEditingController();
    final amountController = useTextEditingController();
    final noteController = useTextEditingController();
    final state = ref.watch(paymentNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Pago')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: fromController,
              decoration: const InputDecoration(labelText: 'De usuario'),
            ),
            TextField(
              controller: toController,
              decoration: const InputDecoration(labelText: 'A usuario'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Monto'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Nota'),
            ),
            const SizedBox(height: 20),
            if (state.error != null) ...[
              Text(state.error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final amount =
                          double.tryParse(amountController.text) ?? 0;
                      await ref.read(paymentNotifierProvider.notifier).addPayment(
                            groupId: groupId,
                            fromUserId: fromController.text,
                            toUserId: toController.text,
                            amount: amount,
                            note: noteController.text.isEmpty
                                ? null
                                : noteController.text,
                          );
                      final error = ref.read(paymentNotifierProvider).error;
                      if (context.mounted && error == null) {
                        context.pop();
                      }
                    },
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

