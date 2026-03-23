import '../../features/shared/services/notification_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Notification

class GetNotificationByIdUseCase {
  final NotificationService _service;
  
  GetNotificationByIdUseCase(this._service);
  
  Future<Notification> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetNotificationsUseCase {
  final NotificationService _service;
  
  GetNotificationsUseCase(this._service);
  
  Future<List<Notification>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateNotificationUseCase {
  final NotificationService _service;
  
  CreateNotificationUseCase(this._service);
  
  Future<Notification> execute(Notification notification) async {
    // Add validation logic here
    return await _service.create(notification);
  }
}

class UpdateNotificationUseCase {
  final NotificationService _service;
  
  UpdateNotificationUseCase(this._service);
  
  Future<Notification> execute(String id, Notification notification) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, notification);
  }
}

class DeleteNotificationUseCase {
  final NotificationService _service;
  
  DeleteNotificationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Notification Use Case Container
class NotificationUseCases {
  final GetNotificationByIdUseCase getById;
  final GetNotificationsUseCase getAll;
  final CreateNotificationUseCase create;
  final UpdateNotificationUseCase update;
  final DeleteNotificationUseCase delete;
  
  NotificationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory NotificationUseCases.create(NotificationService service) {
    return NotificationUseCases(
      getById: GetNotificationByIdUseCase(service),
      getAll: GetNotificationsUseCase(service),
      create: CreateNotificationUseCase(service),
      update: UpdateNotificationUseCase(service),
      delete: DeleteNotificationUseCase(service),
    );
  }
}
