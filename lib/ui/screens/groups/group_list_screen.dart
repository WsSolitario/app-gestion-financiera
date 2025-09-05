import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/groups/group_provider.dart';

const lightGray = Color(0xFFF5F5F5);
const blueishGray = Color(0xFF7C8B9A);

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
      appBar: AppBar(
        title: const Text('Stitch AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/groups/new'),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.groups.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, index) {
                    final group = state.groups[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      tileColor: lightGray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          group.imageUrl ?? '',
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        group.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          '${group.memberCount} miembros, ${group.expenseCount} gastos'),
                      trailing:
                          const Icon(Icons.chevron_right, color: blueishGray),
                      onTap: () => context.push('/groups/${group.id}'),
                    );
                  },
                ),
    );
  }
}
