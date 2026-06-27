import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_tenant_screening_service.dart';

abstract class AiTenantScreeningRepository {
  Future<AiTenantScreening> getById(String id);
  Future<List<AiTenantScreening>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiTenantScreening> create(AiTenantScreening item);
  Future<AiTenantScreening> update(String id, AiTenantScreening item);
  Future<void> delete(String id);
}

class AiTenantScreeningRepositoryImpl implements AiTenantScreeningRepository {
  final AiTenantScreeningService _service;
  AiTenantScreeningRepositoryImpl(this._service);

  @override
  Future<AiTenantScreening> getById(String id) => _service.getAiTenantScreeningById(id);

  @override
  Future<List<AiTenantScreening>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiTenantScreenings(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiTenantScreening> create(AiTenantScreening item) => _service.createAiTenantScreening(item);

  @override
  Future<AiTenantScreening> update(String id, AiTenantScreening item) => _service.updateAiTenantScreening(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiTenantScreening(id);
}
