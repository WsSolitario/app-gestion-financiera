import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../state/expenses/expense_provider.dart';

class ExpenseDetailScreen extends ConsumerWidget {
  final String id;
  const ExpenseDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expense = ref.read(expenseNotifierProvider.notifier).getById(id);

    return Scaffold(
      appBar: AppBar(title: Text(expense?.description ?? 'Gasto')),
      body: expense == null
          ? const Center(child: Text('Gasto no encontrado'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Descripción: ${expense.description}'),
                  Text('Monto: \\$${expense.amount.toStringAsFixed(2)}'),
                ],
              ),
            ),
    );
  }
}
