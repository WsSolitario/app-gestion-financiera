import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../state/groups/group_provider.dart';

class GroupBalancesScreen extends HookConsumerWidget {
  final String groupId;
  const GroupBalancesScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupNotifierProvider);
    final balances = useState<List<dynamic>>([]);

    useEffect(() {
      Future(() async {
        final res =
            await ref.read(groupNotifierProvider.notifier).getBalances(groupId);
        balances.value = res;
      });
      return null;
    }, [groupId]);

    return Scaffold(
      appBar: AppBar(title: const Text('Balances')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : ListView.builder(
                  itemCount: balances.value.length,
                  itemBuilder: (_, index) {
                    final balance = balances.value[index];
                    return ListTile(
                      title: Text(balance.toString()),
                    );
                  },
                ),
    );
  }
}
