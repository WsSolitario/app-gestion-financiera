import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/groups/group_provider.dart';
import '../../../models/group.dart';

class GroupDetailScreen extends HookConsumerWidget {
  final String id;
  const GroupDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupNotifierProvider);
    Group? group;
    try {
      group = state.groups.firstWhere((g) => g.id == id);
    } catch (_) {}

    useEffect(() {
      if (state.groups.isEmpty) {
        ref.read(groupNotifierProvider.notifier).fetchGroups();
      }
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(title: Text(group?.name ?? 'Grupo')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : group == null
                  ? const Center(child: Text('Grupo no encontrado'))
                  : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('ID: ${group!.id}'),
                          Text('Nombre: ${group.name}'),
                          if (group.description != null)
                            Text('Descripción: ${group.description}'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () =>
                                context.push('/groups/${group!.id}/expenses'),
                            child: const Text('Ver gastos'),
                          ),
                          const SizedBox(height: 8),

                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () =>
                                context.push('/groups/${group!.id}/members'),
                            child: const Text('Gestionar miembros'),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () =>
                                context.push('/groups/${group!.id}/balances'),
                            child: const Text('Ver balances'),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () =>
                                context.push('/groups/${group!.id}/payments'),
                            child: const Text('Ver pagos'),

                          ),
                        ],
                      ),
                    ),
    );
  }
}
