import 'package:reservatior/shared/repositories/role_permission_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetRolePermissionByIdUseCase {
  final RolePermissionRepository _repository;
  GetRolePermissionByIdUseCase(this._repository);
  Future<RolePermission> execute(String id) => _repository.getById(id);
}

class GetRolePermissionsUseCase {
  final RolePermissionRepository _repository;
  GetRolePermissionsUseCase(this._repository);
  Future<List<RolePermission>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateRolePermissionUseCase {
  final RolePermissionRepository _repository;
  CreateRolePermissionUseCase(this._repository);
  Future<RolePermission> execute(RolePermission item) => _repository.create(item);
}

class UpdateRolePermissionUseCase {
  final RolePermissionRepository _repository;
  UpdateRolePermissionUseCase(this._repository);
  Future<RolePermission> execute(String id, RolePermission item) => _repository.update(id, item);
}

class DeleteRolePermissionUseCase {
  final RolePermissionRepository _repository;
  DeleteRolePermissionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
