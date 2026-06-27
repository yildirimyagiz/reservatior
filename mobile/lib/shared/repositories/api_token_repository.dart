import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/api_token_service.dart';

abstract class ApiTokenRepository {
  Future<ApiToken> getById(String id);
  Future<List<ApiToken>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ApiToken> create(ApiToken item);
  Future<ApiToken> update(String id, ApiToken item);
  Future<void> delete(String id);
}

class ApiTokenRepositoryImpl implements ApiTokenRepository {
  final ApiTokenService _service;
  ApiTokenRepositoryImpl(this._service);

  @override
  Future<ApiToken> getById(String id) => _service.getApiTokenById(id);

  @override
  Future<List<ApiToken>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getApiTokens(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ApiToken> create(ApiToken item) => _service.createApiToken(item);

  @override
  Future<ApiToken> update(String id, ApiToken item) => _service.updateApiToken(id, item);

  @override
  Future<void> delete(String id) => _service.deleteApiToken(id);
}
