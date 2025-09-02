import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/expenses/expense_provider.dart';

class ExpenseListScreen extends HookConsumerWidget {
  final String groupId;
  const ExpenseListScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(expenseNotifierProvider);

    useEffect(() {
      ref.read(expenseNotifierProvider.notifier).fetchExpenses(groupId);
      return null;
    }, [groupId]);

    return Scaffold(
      appBar: AppBar(title: const Text('Gastos')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: state.expenses.length,
              itemBuilder: (_, index) {
                final expense = state.expenses[index];
                return ListTile(
                  title: Text(expense.description),
                  subtitle: Text('\\$${expense.amount.toStringAsFixed(2)}'),
                  onTap: () =>
                      context.push('/groups/$groupId/expenses/${expense.id}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/groups/$groupId/expenses/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
