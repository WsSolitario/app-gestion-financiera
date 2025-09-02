import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/expenses/expense_provider.dart';

class ExpenseFormScreen extends HookConsumerWidget {
  final String groupId;
  const ExpenseFormScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final descController = useTextEditingController();
    final amountController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Gasto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Monto'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final amount = double.tryParse(amountController.text) ?? 0;
                await ref
                    .read(expenseNotifierProvider.notifier)
                    .addExpense(groupId, descController.text, amount);
                if (context.mounted) {
                  context.pop();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
