import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/api_key_service.dart';

abstract class ApiKeyRepository {
  Future<ApiKey> getById(String id);
  Future<List<ApiKey>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ApiKey> create(ApiKey item);
  Future<ApiKey> update(String id, ApiKey item);
  Future<void> delete(String id);
}

class ApiKeyRepositoryImpl implements ApiKeyRepository {
  final ApiKeyService _service;
  ApiKeyRepositoryImpl(this._service);

  @override
  Future<ApiKey> getById(String id) => _service.getApiKeyById(id);

  @override
  Future<List<ApiKey>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getApiKeys(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ApiKey> create(ApiKey item) => _service.createApiKey(item);

  @override
  Future<ApiKey> update(String id, ApiKey item) => _service.updateApiKey(id, item);

  @override
  Future<void> delete(String id) => _service.deleteApiKey(id);
}
