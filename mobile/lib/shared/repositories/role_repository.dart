import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/role_service.dart';

abstract class RoleRepository {
  Future<Role> getById(String id);
  Future<List<Role>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Role> create(Role item);
  Future<Role> update(String id, Role item);
  Future<void> delete(String id);
}

class RoleRepositoryImpl implements RoleRepository {
  final RoleService _service;
  RoleRepositoryImpl(this._service);

  @override
  Future<Role> getById(String id) => _service.getRoleById(id);

  @override
  Future<List<Role>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getRoles(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Role> create(Role item) => _service.createRole(item);

  @override
  Future<Role> update(String id, Role item) => _service.updateRole(id, item);

  @override
  Future<void> delete(String id) => _service.deleteRole(id);
}
