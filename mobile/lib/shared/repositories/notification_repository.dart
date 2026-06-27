import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/notification_service.dart';

abstract class NotificationRepository {
  Future<Notification> getById(String id);
  Future<List<Notification>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Notification> create(Notification item);
  Future<Notification> update(String id, Notification item);
  Future<void> delete(String id);
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _service;
  NotificationRepositoryImpl(this._service);

  @override
  Future<Notification> getById(String id) => _service.getNotificationById(id);

  @override
  Future<List<Notification>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getNotifications(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Notification> create(Notification item) => _service.createNotification(item);

  @override
  Future<Notification> update(String id, Notification item) => _service.updateNotification(id, item);

  @override
  Future<void> delete(String id) => _service.deleteNotification(id);
}
