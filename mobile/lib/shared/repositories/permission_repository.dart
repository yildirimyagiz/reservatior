import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/permission_service.dart';

abstract class PermissionRepository {
  Future<Permission> getById(String id);
  Future<List<Permission>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Permission> create(Permission item);
  Future<Permission> update(String id, Permission item);
  Future<void> delete(String id);
}

class PermissionRepositoryImpl implements PermissionRepository {
  final PermissionService _service;
  PermissionRepositoryImpl(this._service);

  @override
  Future<Permission> getById(String id) => _service.getPermissionById(id);

  @override
  Future<List<Permission>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPermissions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Permission> create(Permission item) => _service.createPermission(item);

  @override
  Future<Permission> update(String id, Permission item) => _service.updatePermission(id, item);

  @override
  Future<void> delete(String id) => _service.deletePermission(id);
}
