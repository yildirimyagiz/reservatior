import 'package:reservatior/shared/repositories/offline_sync_queue_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetOfflineSyncQueueByIdUseCase {
  final OfflineSyncQueueRepository _repository;
  GetOfflineSyncQueueByIdUseCase(this._repository);
  Future<OfflineSyncQueue> execute(String id) => _repository.getById(id);
}

class GetOfflineSyncQueuesUseCase {
  final OfflineSyncQueueRepository _repository;
  GetOfflineSyncQueuesUseCase(this._repository);
  Future<List<OfflineSyncQueue>> execute({
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

class CreateOfflineSyncQueueUseCase {
  final OfflineSyncQueueRepository _repository;
  CreateOfflineSyncQueueUseCase(this._repository);
  Future<OfflineSyncQueue> execute(OfflineSyncQueue item) => _repository.create(item);
}

class UpdateOfflineSyncQueueUseCase {
  final OfflineSyncQueueRepository _repository;
  UpdateOfflineSyncQueueUseCase(this._repository);
  Future<OfflineSyncQueue> execute(String id, OfflineSyncQueue item) => _repository.update(id, item);
}

class DeleteOfflineSyncQueueUseCase {
  final OfflineSyncQueueRepository _repository;
  DeleteOfflineSyncQueueUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
