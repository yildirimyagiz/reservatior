import 'package:reservatior/shared/repositories/tenant_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetTenantByIdUseCase {
  final TenantRepository _repository;
  GetTenantByIdUseCase(this._repository);
  Future<Tenant> execute(String id) => _repository.getById(id);
}

class GetTenantsUseCase {
  final TenantRepository _repository;
  GetTenantsUseCase(this._repository);
  Future<List<Tenant>> execute({
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

class CreateTenantUseCase {
  final TenantRepository _repository;
  CreateTenantUseCase(this._repository);
  Future<Tenant> execute(Tenant item) => _repository.create(item);
}

class UpdateTenantUseCase {
  final TenantRepository _repository;
  UpdateTenantUseCase(this._repository);
  Future<Tenant> execute(String id, Tenant item) => _repository.update(id, item);
}

class DeleteTenantUseCase {
  final TenantRepository _repository;
  DeleteTenantUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
