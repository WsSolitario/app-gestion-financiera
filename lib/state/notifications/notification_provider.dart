import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../config/locator.dart';
import '../../repositories/notification_repository.dart';
import 'notification_state.dart';

final notificationNotifierProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier(locator<NotificationRepository>());
});

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _repo;
  NotificationNotifier(this._repo) : super(NotificationState.initial());

  Future<void> fetchNotifications() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final notifications = await _repo.fetchNotifications();
      state = state.copyWith(
          notifications: notifications, isLoading: false, error: null);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _repo.markAsRead(id);
      await fetchNotifications();
    } catch (_) {}
  }

  Future<void> delete(String id) async {
    try {
      await _repo.deleteNotification(id);
      state = state.copyWith(
        notifications: state.notifications.where((n) => n.id != id).toList(),
      );
    } catch (_) {}
  }
}
