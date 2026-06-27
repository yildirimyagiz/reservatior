import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/system_metrics_service.dart';

abstract class SystemMetricsRepository {
  Future<SystemMetrics> getById(String id);
  Future<List<SystemMetrics>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<SystemMetrics> create(SystemMetrics item);
  Future<SystemMetrics> update(String id, SystemMetrics item);
  Future<void> delete(String id);
}

class SystemMetricsRepositoryImpl implements SystemMetricsRepository {
  final SystemMetricsService _service;
  SystemMetricsRepositoryImpl(this._service);

  @override
  Future<SystemMetrics> getById(String id) => _service.getSystemMetricsById(id);

  @override
  Future<List<SystemMetrics>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSystemMetricses(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<SystemMetrics> create(SystemMetrics item) => _service.createSystemMetrics(item);

  @override
  Future<SystemMetrics> update(String id, SystemMetrics item) => _service.updateSystemMetrics(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSystemMetrics(id);
}
