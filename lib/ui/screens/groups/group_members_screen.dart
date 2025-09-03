import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../state/groups/group_provider.dart';

class GroupMembersScreen extends HookConsumerWidget {
  final String groupId;
  const GroupMembersScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupNotifierProvider);
    final userIdController = useTextEditingController();
    final roleController = useTextEditingController();
    final memberIdController = useTextEditingController();
    final updateRoleController = useTextEditingController();
    final deleteMemberController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Miembros')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (state.error != null) ...[
              Text(state.error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
            ],
            const Text('Agregar miembro'),
            TextField(
              controller: userIdController,
              decoration: const InputDecoration(labelText: 'Usuario ID'),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Rol'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(groupNotifierProvider.notifier)
                          .addMember(groupId, userIdController.text,
                              role: roleController.text.isEmpty
                                  ? null
                                  : roleController.text);
                    },
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Agregar'),
            ),
            const Divider(height: 40),
            const Text('Actualizar rol'),
            TextField(
              controller: memberIdController,
              decoration: const InputDecoration(labelText: 'Miembro ID'),
            ),
            TextField(
              controller: updateRoleController,
              decoration: const InputDecoration(labelText: 'Nuevo rol'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(groupNotifierProvider.notifier)
                          .updateMemberRole(groupId, memberIdController.text,
                              updateRoleController.text);
                    },
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Actualizar'),
            ),
            const Divider(height: 40),
            const Text('Eliminar miembro'),
            TextField(
              controller: deleteMemberController,
              decoration: const InputDecoration(labelText: 'Miembro ID'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(groupNotifierProvider.notifier)
                          .deleteMember(groupId, deleteMemberController.text);
                    },
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}
