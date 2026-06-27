import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/dashboard_configuration_service.dart';

abstract class DashboardConfigurationRepository {
  Future<DashboardConfiguration> getById(String id);
  Future<List<DashboardConfiguration>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<DashboardConfiguration> create(DashboardConfiguration item);
  Future<DashboardConfiguration> update(String id, DashboardConfiguration item);
  Future<void> delete(String id);
}

class DashboardConfigurationRepositoryImpl implements DashboardConfigurationRepository {
  final DashboardConfigurationService _service;
  DashboardConfigurationRepositoryImpl(this._service);

  @override
  Future<DashboardConfiguration> getById(String id) => _service.getDashboardConfigurationById(id);

  @override
  Future<List<DashboardConfiguration>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getDashboardConfigurations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<DashboardConfiguration> create(DashboardConfiguration item) => _service.createDashboardConfiguration(item);

  @override
  Future<DashboardConfiguration> update(String id, DashboardConfiguration item) => _service.updateDashboardConfiguration(id, item);

  @override
  Future<void> delete(String id) => _service.deleteDashboardConfiguration(id);
}
