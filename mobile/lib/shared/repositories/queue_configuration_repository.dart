import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/queue_configuration_service.dart';

abstract class QueueConfigurationRepository {
  Future<QueueConfiguration> getById(String id);
  Future<List<QueueConfiguration>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<QueueConfiguration> create(QueueConfiguration item);
  Future<QueueConfiguration> update(String id, QueueConfiguration item);
  Future<void> delete(String id);
}

class QueueConfigurationRepositoryImpl implements QueueConfigurationRepository {
  final QueueConfigurationService _service;
  QueueConfigurationRepositoryImpl(this._service);

  @override
  Future<QueueConfiguration> getById(String id) => _service.getQueueConfigurationById(id);

  @override
  Future<List<QueueConfiguration>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getQueueConfigurations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<QueueConfiguration> create(QueueConfiguration item) => _service.createQueueConfiguration(item);

  @override
  Future<QueueConfiguration> update(String id, QueueConfiguration item) => _service.updateQueueConfiguration(id, item);

  @override
  Future<void> delete(String id) => _service.deleteQueueConfiguration(id);
}
