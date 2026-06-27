import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/api_integration_service.dart';

abstract class APIIntegrationRepository {
  Future<APIIntegration> getById(String id);
  Future<List<APIIntegration>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<APIIntegration> create(APIIntegration item);
  Future<APIIntegration> update(String id, APIIntegration item);
  Future<void> delete(String id);
}

class APIIntegrationRepositoryImpl implements APIIntegrationRepository {
  final APIIntegrationService _service;
  APIIntegrationRepositoryImpl(this._service);

  @override
  Future<APIIntegration> getById(String id) => _service.getAPIIntegrationById(id);

  @override
  Future<List<APIIntegration>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAPIIntegrations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<APIIntegration> create(APIIntegration item) => _service.createAPIIntegration(item);

  @override
  Future<APIIntegration> update(String id, APIIntegration item) => _service.updateAPIIntegration(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAPIIntegration(id);
}
