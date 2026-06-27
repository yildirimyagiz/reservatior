import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/performance_alert_service.dart';

abstract class PerformanceAlertRepository {
  Future<PerformanceAlert> getById(String id);
  Future<List<PerformanceAlert>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PerformanceAlert> create(PerformanceAlert item);
  Future<PerformanceAlert> update(String id, PerformanceAlert item);
  Future<void> delete(String id);
}

class PerformanceAlertRepositoryImpl implements PerformanceAlertRepository {
  final PerformanceAlertService _service;
  PerformanceAlertRepositoryImpl(this._service);

  @override
  Future<PerformanceAlert> getById(String id) => _service.getPerformanceAlertById(id);

  @override
  Future<List<PerformanceAlert>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPerformanceAlerts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PerformanceAlert> create(PerformanceAlert item) => _service.createPerformanceAlert(item);

  @override
  Future<PerformanceAlert> update(String id, PerformanceAlert item) => _service.updatePerformanceAlert(id, item);

  @override
  Future<void> delete(String id) => _service.deletePerformanceAlert(id);
}
