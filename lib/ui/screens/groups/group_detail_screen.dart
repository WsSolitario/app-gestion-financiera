import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/groups/group_provider.dart';

class GroupDetailScreen extends ConsumerWidget {
  final String id;
  const GroupDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.read(groupNotifierProvider.notifier).getById(id);

    return Scaffold(
      appBar: AppBar(title: Text(group?.name ?? 'Grupo')),
      body: group == null
          ? const Center(child: Text('Grupo no encontrado'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${group.id}'),
                  Text('Nombre: ${group.name}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () =>
                        context.push('/groups/${group.id}/expenses'),
                    child: const Text('Ver gastos'),
                  ),
                ],
              ),
            ),
    );
  }
}
