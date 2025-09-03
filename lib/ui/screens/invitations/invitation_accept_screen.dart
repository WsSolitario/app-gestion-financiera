import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state/invitations/invitation_provider.dart';

class InvitationAcceptScreen extends HookConsumerWidget {
  const InvitationAcceptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenController = useTextEditingController();
    final state = ref.watch(invitationNotifierProvider);

    Future<void> handleAccept() async {
      await ref
          .read(invitationNotifierProvider.notifier)
          .acceptInvitation(tokenController.text);
      final currentState = ref.read(invitationNotifierProvider);
      if (currentState.error == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invitación aceptada')),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Aceptar invitación')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: tokenController,
              decoration: const InputDecoration(labelText: 'Token'),
            ),
            const SizedBox(height: 16),
            state.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: handleAccept,
                    child: const Text('Aceptar'),
                  ),
            if (state.error != null) ...[
              const SizedBox(height: 16),
              Text(state.error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
