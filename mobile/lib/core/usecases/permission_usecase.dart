import '../../features/shared/services/permission_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Permission

class GetPermissionByIdUseCase {
  final PermissionService _service;
  
  GetPermissionByIdUseCase(this._service);
  
  Future<Permission> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPermissionsUseCase {
  final PermissionService _service;
  
  GetPermissionsUseCase(this._service);
  
  Future<List<Permission>> execute({
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

class CreatePermissionUseCase {
  final PermissionService _service;
  
  CreatePermissionUseCase(this._service);
  
  Future<Permission> execute(Permission permission) async {
    // Add validation logic here
    return await _service.create(permission);
  }
}

class UpdatePermissionUseCase {
  final PermissionService _service;
  
  UpdatePermissionUseCase(this._service);
  
  Future<Permission> execute(String id, Permission permission) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, permission);
  }
}

class DeletePermissionUseCase {
  final PermissionService _service;
  
  DeletePermissionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Permission Use Case Container
class PermissionUseCases {
  final GetPermissionByIdUseCase getById;
  final GetPermissionsUseCase getAll;
  final CreatePermissionUseCase create;
  final UpdatePermissionUseCase update;
  final DeletePermissionUseCase delete;
  
  PermissionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PermissionUseCases.create(PermissionService service) {
    return PermissionUseCases(
      getById: GetPermissionByIdUseCase(service),
      getAll: GetPermissionsUseCase(service),
      create: CreatePermissionUseCase(service),
      update: UpdatePermissionUseCase(service),
      delete: DeletePermissionUseCase(service),
    );
  }
}
