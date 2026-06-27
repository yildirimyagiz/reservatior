import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/role_permission_service.dart';

abstract class RolePermissionRepository {
  Future<RolePermission> getById(String id);
  Future<List<RolePermission>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<RolePermission> create(RolePermission item);
  Future<RolePermission> update(String id, RolePermission item);
  Future<void> delete(String id);
}

class RolePermissionRepositoryImpl implements RolePermissionRepository {
  final RolePermissionService _service;
  RolePermissionRepositoryImpl(this._service);

  @override
  Future<RolePermission> getById(String id) => _service.getRolePermissionById(id);

  @override
  Future<List<RolePermission>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getRolePermissions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<RolePermission> create(RolePermission item) => _service.createRolePermission(item);

  @override
  Future<RolePermission> update(String id, RolePermission item) => _service.updateRolePermission(id, item);

  @override
  Future<void> delete(String id) => _service.deleteRolePermission(id);
}
