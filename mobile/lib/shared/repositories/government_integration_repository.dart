import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/government_integration_service.dart';

abstract class GovernmentIntegrationRepository {
  Future<GovernmentIntegration> getById(String id);
  Future<List<GovernmentIntegration>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<GovernmentIntegration> create(GovernmentIntegration item);
  Future<GovernmentIntegration> update(String id, GovernmentIntegration item);
  Future<void> delete(String id);
}

class GovernmentIntegrationRepositoryImpl implements GovernmentIntegrationRepository {
  final GovernmentIntegrationService _service;
  GovernmentIntegrationRepositoryImpl(this._service);

  @override
  Future<GovernmentIntegration> getById(String id) => _service.getGovernmentIntegrationById(id);

  @override
  Future<List<GovernmentIntegration>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getGovernmentIntegrations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<GovernmentIntegration> create(GovernmentIntegration item) => _service.createGovernmentIntegration(item);

  @override
  Future<GovernmentIntegration> update(String id, GovernmentIntegration item) => _service.updateGovernmentIntegration(id, item);

  @override
  Future<void> delete(String id) => _service.deleteGovernmentIntegration(id);
}
