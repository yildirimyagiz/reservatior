import 'package:reservatior/shared/repositories/notification_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetNotificationByIdUseCase {
  final NotificationRepository _repository;
  GetNotificationByIdUseCase(this._repository);
  Future<Notification> execute(String id) => _repository.getById(id);
}

class GetNotificationsUseCase {
  final NotificationRepository _repository;
  GetNotificationsUseCase(this._repository);
  Future<List<Notification>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateNotificationUseCase {
  final NotificationRepository _repository;
  CreateNotificationUseCase(this._repository);
  Future<Notification> execute(Notification item) => _repository.create(item);
}

class UpdateNotificationUseCase {
  final NotificationRepository _repository;
  UpdateNotificationUseCase(this._repository);
  Future<Notification> execute(String id, Notification item) => _repository.update(id, item);
}

class DeleteNotificationUseCase {
  final NotificationRepository _repository;
  DeleteNotificationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
