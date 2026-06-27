import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/tenant_service.dart';

abstract class TenantRepository {
  Future<Tenant> getById(String id);
  Future<List<Tenant>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Tenant> create(Tenant item);
  Future<Tenant> update(String id, Tenant item);
  Future<void> delete(String id);
}

class TenantRepositoryImpl implements TenantRepository {
  final TenantService _service;
  TenantRepositoryImpl(this._service);

  @override
  Future<Tenant> getById(String id) => _service.getTenantById(id);

  @override
  Future<List<Tenant>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getTenants(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Tenant> create(Tenant item) => _service.createTenant(item);

  @override
  Future<Tenant> update(String id, Tenant item) => _service.updateTenant(id, item);

  @override
  Future<void> delete(String id) => _service.deleteTenant(id);
}
