import '../../features/shared/services/role_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Role

class GetRoleByIdUseCase {
  final RoleService _service;
  
  GetRoleByIdUseCase(this._service);
  
  Future<Role> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetRolesUseCase {
  final RoleService _service;
  
  GetRolesUseCase(this._service);
  
  Future<List<Role>> execute({
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

class CreateRoleUseCase {
  final RoleService _service;
  
  CreateRoleUseCase(this._service);
  
  Future<Role> execute(Role role) async {
    // Add validation logic here
    return await _service.create(role);
  }
}

class UpdateRoleUseCase {
  final RoleService _service;
  
  UpdateRoleUseCase(this._service);
  
  Future<Role> execute(String id, Role role) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, role);
  }
}

class DeleteRoleUseCase {
  final RoleService _service;
  
  DeleteRoleUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Role Use Case Container
class RoleUseCases {
  final GetRoleByIdUseCase getById;
  final GetRolesUseCase getAll;
  final CreateRoleUseCase create;
  final UpdateRoleUseCase update;
  final DeleteRoleUseCase delete;
  
  RoleUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory RoleUseCases.create(RoleService service) {
    return RoleUseCases(
      getById: GetRoleByIdUseCase(service),
      getAll: GetRolesUseCase(service),
      create: CreateRoleUseCase(service),
      update: UpdateRoleUseCase(service),
      delete: DeleteRoleUseCase(service),
    );
  }
}
