import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/tenant_application_service.dart';

abstract class TenantApplicationRepository {
  Future<TenantApplication> getById(String id);
  Future<List<TenantApplication>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<TenantApplication> create(TenantApplication item);
  Future<TenantApplication> update(String id, TenantApplication item);
  Future<void> delete(String id);
}

class TenantApplicationRepositoryImpl implements TenantApplicationRepository {
  final TenantApplicationService _service;
  TenantApplicationRepositoryImpl(this._service);

  @override
  Future<TenantApplication> getById(String id) => _service.getTenantApplicationById(id);

  @override
  Future<List<TenantApplication>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getTenantApplications(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<TenantApplication> create(TenantApplication item) => _service.createTenantApplication(item);

  @override
  Future<TenantApplication> update(String id, TenantApplication item) => _service.updateTenantApplication(id, item);

  @override
  Future<void> delete(String id) => _service.deleteTenantApplication(id);
}
