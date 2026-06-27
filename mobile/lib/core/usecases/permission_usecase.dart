import 'package:reservatior/shared/repositories/permission_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPermissionByIdUseCase {
  final PermissionRepository _repository;
  GetPermissionByIdUseCase(this._repository);
  Future<Permission> execute(String id) => _repository.getById(id);
}

class GetPermissionsUseCase {
  final PermissionRepository _repository;
  GetPermissionsUseCase(this._repository);
  Future<List<Permission>> execute({
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

class CreatePermissionUseCase {
  final PermissionRepository _repository;
  CreatePermissionUseCase(this._repository);
  Future<Permission> execute(Permission item) => _repository.create(item);
}

class UpdatePermissionUseCase {
  final PermissionRepository _repository;
  UpdatePermissionUseCase(this._repository);
  Future<Permission> execute(String id, Permission item) => _repository.update(id, item);
}

class DeletePermissionUseCase {
  final PermissionRepository _repository;
  DeletePermissionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
