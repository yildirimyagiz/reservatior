import '../../features/shared/services/queue_configuration_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for QueueConfiguration

class GetQueueConfigurationByIdUseCase {
  final QueueConfigurationService _service;
  
  GetQueueConfigurationByIdUseCase(this._service);
  
  Future<QueueConfiguration> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetQueueConfigurationsUseCase {
  final QueueConfigurationService _service;
  
  GetQueueConfigurationsUseCase(this._service);
  
  Future<List<QueueConfiguration>> execute({
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

class CreateQueueConfigurationUseCase {
  final QueueConfigurationService _service;
  
  CreateQueueConfigurationUseCase(this._service);
  
  Future<QueueConfiguration> execute(QueueConfiguration queueConfiguration) async {
    // Add validation logic here
    return await _service.create(queueConfiguration);
  }
}

class UpdateQueueConfigurationUseCase {
  final QueueConfigurationService _service;
  
  UpdateQueueConfigurationUseCase(this._service);
  
  Future<QueueConfiguration> execute(String id, QueueConfiguration queueConfiguration) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, queueConfiguration);
  }
}

class DeleteQueueConfigurationUseCase {
  final QueueConfigurationService _service;
  
  DeleteQueueConfigurationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// QueueConfiguration Use Case Container
class QueueConfigurationUseCases {
  final GetQueueConfigurationByIdUseCase getById;
  final GetQueueConfigurationsUseCase getAll;
  final CreateQueueConfigurationUseCase create;
  final UpdateQueueConfigurationUseCase update;
  final DeleteQueueConfigurationUseCase delete;
  
  QueueConfigurationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory QueueConfigurationUseCases.create(QueueConfigurationService service) {
    return QueueConfigurationUseCases(
      getById: GetQueueConfigurationByIdUseCase(service),
      getAll: GetQueueConfigurationsUseCase(service),
      create: CreateQueueConfigurationUseCase(service),
      update: UpdateQueueConfigurationUseCase(service),
      delete: DeleteQueueConfigurationUseCase(service),
    );
  }
}
