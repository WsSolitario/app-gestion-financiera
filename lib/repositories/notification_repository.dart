import '../models/notification.dart';
import "../services/notification_service.dart";

class NotificationRepository {
  final NotificationService _service;
  NotificationRepository(this._service);

  Future<void> registerDevice(String deviceToken, String deviceType) =>
      _service.registerDevice(deviceToken, deviceType);

  Future<List<AppNotification>> fetchNotifications() =>
      _service.getNotifications();

  Future<void> markAsRead(String id) => _service.markAsRead(id);

  Future<void> deleteNotification(String id) =>
      _service.deleteNotification(id);
}
