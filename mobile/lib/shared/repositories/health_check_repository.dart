import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/health_check_service.dart';

abstract class HealthCheckRepository {
  Future<HealthCheck> getById(String id);
  Future<List<HealthCheck>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<HealthCheck> create(HealthCheck item);
  Future<HealthCheck> update(String id, HealthCheck item);
  Future<void> delete(String id);
}

class HealthCheckRepositoryImpl implements HealthCheckRepository {
  final HealthCheckService _service;
  HealthCheckRepositoryImpl(this._service);

  @override
  Future<HealthCheck> getById(String id) => _service.getHealthCheckById(id);

  @override
  Future<List<HealthCheck>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getHealthChecks(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<HealthCheck> create(HealthCheck item) => _service.createHealthCheck(item);

  @override
  Future<HealthCheck> update(String id, HealthCheck item) => _service.updateHealthCheck(id, item);

  @override
  Future<void> delete(String id) => _service.deleteHealthCheck(id);
}
