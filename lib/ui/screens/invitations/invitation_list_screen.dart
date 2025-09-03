import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state/invitations/invitation_provider.dart';

class InvitationListScreen extends HookConsumerWidget {
  const InvitationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(invitationNotifierProvider);

    useEffect(() {
      ref.read(invitationNotifierProvider.notifier).fetchInvitations();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Invitaciones')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : ListView.builder(
                  itemCount: state.invitations.length,
                  itemBuilder: (_, index) {
                    final invitation = state.invitations[index];
                    return ListTile(
                      title: Text(invitation.email),
                      subtitle: Text(invitation.status),
                    );
                  },
                ),
    );
  }
}
