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
    final createdByController = useTextEditingController();
    final state = ref.watch(expenseNotifierProvider);

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
            TextField(
              controller: createdByController,
              decoration: const InputDecoration(labelText: 'Creado por'),
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
                      await ref
                          .read(expenseNotifierProvider.notifier)
                          .addExpense(
                            groupId,
                            descController.text,
                            amount,
                            expenseDate: DateTime.now(),
                            createdBy: createdByController.text,
                            participants: const [],
                          );
                      final error = ref.read(expenseNotifierProvider).error;
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
