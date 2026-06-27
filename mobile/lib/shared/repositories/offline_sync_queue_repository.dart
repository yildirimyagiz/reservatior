import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/offline_sync_queue_service.dart';

abstract class OfflineSyncQueueRepository {
  Future<OfflineSyncQueue> getById(String id);
  Future<List<OfflineSyncQueue>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<OfflineSyncQueue> create(OfflineSyncQueue item);
  Future<OfflineSyncQueue> update(String id, OfflineSyncQueue item);
  Future<void> delete(String id);
}

class OfflineSyncQueueRepositoryImpl implements OfflineSyncQueueRepository {
  final OfflineSyncQueueService _service;
  OfflineSyncQueueRepositoryImpl(this._service);

  @override
  Future<OfflineSyncQueue> getById(String id) => _service.getOfflineSyncQueueById(id);

  @override
  Future<List<OfflineSyncQueue>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getOfflineSyncQueues(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<OfflineSyncQueue> create(OfflineSyncQueue item) => _service.createOfflineSyncQueue(item);

  @override
  Future<OfflineSyncQueue> update(String id, OfflineSyncQueue item) => _service.updateOfflineSyncQueue(id, item);

  @override
  Future<void> delete(String id) => _service.deleteOfflineSyncQueue(id);
}
