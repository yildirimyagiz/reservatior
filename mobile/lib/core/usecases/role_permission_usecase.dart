import '../../features/shared/services/role_permission_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for RolePermission

class GetRolePermissionByIdUseCase {
  final RolePermissionService _service;
  
  GetRolePermissionByIdUseCase(this._service);
  
  Future<RolePermission> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetRolePermissionsUseCase {
  final RolePermissionService _service;
  
  GetRolePermissionsUseCase(this._service);
  
  Future<List<RolePermission>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateRolePermissionUseCase {
  final RolePermissionService _service;
  
  CreateRolePermissionUseCase(this._service);
  
  Future<RolePermission> execute(RolePermission rolePermission) async {
    // Add validation logic here
    return await _service.create(rolePermission);
  }
}

class UpdateRolePermissionUseCase {
  final RolePermissionService _service;
  
  UpdateRolePermissionUseCase(this._service);
  
  Future<RolePermission> execute(String id, RolePermission rolePermission) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, rolePermission);
  }
}

class DeleteRolePermissionUseCase {
  final RolePermissionService _service;
  
  DeleteRolePermissionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// RolePermission Use Case Container
class RolePermissionUseCases {
  final GetRolePermissionByIdUseCase getById;
  final GetRolePermissionsUseCase getAll;
  final CreateRolePermissionUseCase create;
  final UpdateRolePermissionUseCase update;
  final DeleteRolePermissionUseCase delete;
  
  RolePermissionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory RolePermissionUseCases.create(RolePermissionService service) {
    return RolePermissionUseCases(
      getById: GetRolePermissionByIdUseCase(service),
      getAll: GetRolePermissionsUseCase(service),
      create: CreateRolePermissionUseCase(service),
      update: UpdateRolePermissionUseCase(service),
      delete: DeleteRolePermissionUseCase(service),
    );
  }
}
