import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/groups/group_provider.dart';

class GroupFormScreen extends HookConsumerWidget {
  const GroupFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final state = ref.watch(groupNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Grupo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
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
                      await ref
                          .read(groupNotifierProvider.notifier)
                          .addGroup(nameController.text,
                              description: descriptionController.text);
                      final error = ref.read(groupNotifierProvider).error;
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
