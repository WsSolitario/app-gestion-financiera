import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/notifications/notification_provider.dart';

class NotificationsScreen extends HookConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationNotifierProvider);

    useEffect(() {
      ref.read(notificationNotifierProvider.notifier).fetchNotifications();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (_, index) {
                    final n = state.notifications[index];
                    return ListTile(
                      title: Text(n.title),
                      subtitle: Text(n.body),
                      trailing:
                          n.isRead ? null : const Icon(Icons.mark_email_unread),
                      onTap: () => ref
                          .read(notificationNotifierProvider.notifier)
                          .markAsRead(n.id),
                      onLongPress: () => ref
                          .read(notificationNotifierProvider.notifier)
                          .delete(n.id),
                    );
                  },
                ),
    );
  }
}
