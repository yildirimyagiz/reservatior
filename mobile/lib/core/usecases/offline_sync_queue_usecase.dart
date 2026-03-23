import '../../features/shared/services/offline_sync_queue_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for OfflineSyncQueue

class GetOfflineSyncQueueByIdUseCase {
  final OfflineSyncQueueService _service;
  
  GetOfflineSyncQueueByIdUseCase(this._service);
  
  Future<OfflineSyncQueue> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetOfflineSyncQueuesUseCase {
  final OfflineSyncQueueService _service;
  
  GetOfflineSyncQueuesUseCase(this._service);
  
  Future<List<OfflineSyncQueue>> execute({
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

class CreateOfflineSyncQueueUseCase {
  final OfflineSyncQueueService _service;
  
  CreateOfflineSyncQueueUseCase(this._service);
  
  Future<OfflineSyncQueue> execute(OfflineSyncQueue offlineSyncQueue) async {
    // Add validation logic here
    return await _service.create(offlineSyncQueue);
  }
}

class UpdateOfflineSyncQueueUseCase {
  final OfflineSyncQueueService _service;
  
  UpdateOfflineSyncQueueUseCase(this._service);
  
  Future<OfflineSyncQueue> execute(String id, OfflineSyncQueue offlineSyncQueue) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, offlineSyncQueue);
  }
}

class DeleteOfflineSyncQueueUseCase {
  final OfflineSyncQueueService _service;
  
  DeleteOfflineSyncQueueUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// OfflineSyncQueue Use Case Container
class OfflineSyncQueueUseCases {
  final GetOfflineSyncQueueByIdUseCase getById;
  final GetOfflineSyncQueuesUseCase getAll;
  final CreateOfflineSyncQueueUseCase create;
  final UpdateOfflineSyncQueueUseCase update;
  final DeleteOfflineSyncQueueUseCase delete;
  
  OfflineSyncQueueUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory OfflineSyncQueueUseCases.create(OfflineSyncQueueService service) {
    return OfflineSyncQueueUseCases(
      getById: GetOfflineSyncQueueByIdUseCase(service),
      getAll: GetOfflineSyncQueuesUseCase(service),
      create: CreateOfflineSyncQueueUseCase(service),
      update: UpdateOfflineSyncQueueUseCase(service),
      delete: DeleteOfflineSyncQueueUseCase(service),
    );
  }
}
