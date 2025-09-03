import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/expenses/expense_provider.dart';
import '../../../models/expense.dart';

class ExpenseDetailScreen extends HookConsumerWidget {
  final String id;
  const ExpenseDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(expenseNotifierProvider);
    Expense? expense;
    try {
      expense = state.expenses.firstWhere((e) => e.id == id);
    } catch (_) {}

    final location = GoRouterState.of(context).uri.toString();
    final segments = Uri.parse(location).pathSegments;
    final groupId = segments.length >= 2 ? segments[1] : '';

    useEffect(() {
      if (expense == null && groupId.isNotEmpty) {
        ref.read(expenseNotifierProvider.notifier).fetchExpenses(groupId);
      }
      return null;
    }, [groupId, expense]);

    return Scaffold(
      appBar: AppBar(title: Text(expense?.description ?? 'Gasto')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : expense == null
                  ? const Center(child: Text('Gasto no encontrado'))
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Descripción: ${expense.description}'),
                          Text('Monto: \$${expense.amount.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
    );
  }
}
