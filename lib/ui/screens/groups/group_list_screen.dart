import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/groups/group_provider.dart';

class GroupListScreen extends HookConsumerWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupNotifierProvider);

    useEffect(() {
      ref.read(groupNotifierProvider.notifier).fetchGroups();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Grupos')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: state.groups.length,
              itemBuilder: (_, index) {
                final group = state.groups[index];
                return ListTile(
                  title: Text(group.name),
                  onTap: () => context.push('/groups/${group.id}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/groups/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
