import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/groups/group_provider.dart';
import '../../../state/expenses/expense_provider.dart';
import '../../../models/group.dart';
import '../../widgets/circle_avatar_group.dart';

class GroupDetailScreen extends HookConsumerWidget {
  final String id;
  const GroupDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupState = ref.watch(groupNotifierProvider);
    final expenseState = ref.watch(expenseNotifierProvider);
    Group? group;
    try {
      group = groupState.groups.firstWhere((g) => g.id == id);
    } catch (_) {}

    useEffect(() {
      Future(() async {
        if (groupState.groups.isEmpty) {
          await ref.read(groupNotifierProvider.notifier).fetchGroups();
        }
        await ref.read(groupNotifierProvider.notifier).getMembers(id);
        await ref.read(groupNotifierProvider.notifier).getBalances(id);
        await ref.read(expenseNotifierProvider.notifier).fetchExpenses(id);
      });
      return null;
    }, [id]);

    final members = groupState.members[id] ?? [];
    final balances = groupState.balances[id] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(group?.name ?? 'Grupo')),
      body: groupState.error != null
          ? Center(child: Text(groupState.error!))
          : group == null
              ? const Center(child: Text('Grupo no encontrado'))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text('Gastos recientes',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (expenseState.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      ...expenseState.expenses
                          .take(3)
                          .map((e) => ListTile(
                                title: Text(e.description),
                                trailing: Text('\$${e.totalAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              )),
                    const SizedBox(height: 24),
                    const Text('Miembros del grupo',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (groupState.isLoading && members.isEmpty)
                      const Center(child: CircularProgressIndicator())
                    else
                      CircleAvatarGroup(
                          users: members,
                          extraCount:
                              members.length > 3 ? members.length - 3 : 0),
                    const SizedBox(height: 24),
                    const Text('Resumen de balances',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (groupState.isLoading && balances.isEmpty)
                      const Center(child: CircularProgressIndicator())
                    else
                      ...balances.take(3).map((b) => ListTile(
                            title: Text(b.toString()),
                          )),
                  ],
                ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.push('/groups/$id/expenses'),
                child: const Text('Añadir gasto'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.push('/groups/$id/balances'),
                child: const Text('Ver detalles'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
