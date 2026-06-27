import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/integration_log_service.dart';

abstract class IntegrationLogRepository {
  Future<IntegrationLog> getById(String id);
  Future<List<IntegrationLog>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<IntegrationLog> create(IntegrationLog item);
  Future<IntegrationLog> update(String id, IntegrationLog item);
  Future<void> delete(String id);
}

class IntegrationLogRepositoryImpl implements IntegrationLogRepository {
  final IntegrationLogService _service;
  IntegrationLogRepositoryImpl(this._service);

  @override
  Future<IntegrationLog> getById(String id) => _service.getIntegrationLogById(id);

  @override
  Future<List<IntegrationLog>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getIntegrationLogs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<IntegrationLog> create(IntegrationLog item) => _service.createIntegrationLog(item);

  @override
  Future<IntegrationLog> update(String id, IntegrationLog item) => _service.updateIntegrationLog(id, item);

  @override
  Future<void> delete(String id) => _service.deleteIntegrationLog(id);
}
