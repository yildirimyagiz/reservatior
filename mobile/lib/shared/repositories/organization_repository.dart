import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/organization_service.dart';

abstract class OrganizationRepository {
  Future<Organization> getById(String id);
  Future<List<Organization>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Organization> create(Organization item);
  Future<Organization> update(String id, Organization item);
  Future<void> delete(String id);
}

class OrganizationRepositoryImpl implements OrganizationRepository {
  final OrganizationService _service;
  OrganizationRepositoryImpl(this._service);

  @override
  Future<Organization> getById(String id) => _service.getOrganizationById(id);

  @override
  Future<List<Organization>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getOrganizations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Organization> create(Organization item) => _service.createOrganization(item);

  @override
  Future<Organization> update(String id, Organization item) => _service.updateOrganization(id, item);

  @override
  Future<void> delete(String id) => _service.deleteOrganization(id);
}
