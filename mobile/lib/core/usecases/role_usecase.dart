import 'package:reservatior/shared/repositories/role_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetRoleByIdUseCase {
  final RoleRepository _repository;
  GetRoleByIdUseCase(this._repository);
  Future<Role> execute(String id) => _repository.getById(id);
}

class GetRolesUseCase {
  final RoleRepository _repository;
  GetRolesUseCase(this._repository);
  Future<List<Role>> execute({
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

class CreateRoleUseCase {
  final RoleRepository _repository;
  CreateRoleUseCase(this._repository);
  Future<Role> execute(Role item) => _repository.create(item);
}

class UpdateRoleUseCase {
  final RoleRepository _repository;
  UpdateRoleUseCase(this._repository);
  Future<Role> execute(String id, Role item) => _repository.update(id, item);
}

class DeleteRoleUseCase {
  final RoleRepository _repository;
  DeleteRoleUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
