import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/analytics_service.dart';

abstract class AnalyticsRepository {
  Future<Analytics> getById(String id);
  Future<List<Analytics>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Analytics> create(Analytics item);
  Future<Analytics> update(String id, Analytics item);
  Future<void> delete(String id);
  Future<DashboardStats> getDashboardStats(String id);
}

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final AnalyticsService _service;
  AnalyticsRepositoryImpl(this._service);

  @override
  Future<Analytics> getById(String id) => _service.getAnalyticsById(id);

  @override
  Future<List<Analytics>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAnalyticses(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Analytics> create(Analytics item) => _service.createAnalytics(item);

  @override
  Future<Analytics> update(String id, Analytics item) => _service.updateAnalytics(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAnalytics(id);

  @override
  Future<DashboardStats> getDashboardStats(String id) => _service.getDashboardStats(id);
}
