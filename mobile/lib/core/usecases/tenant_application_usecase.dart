import 'package:reservatior/shared/repositories/tenant_application_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetTenantApplicationByIdUseCase {
  final TenantApplicationRepository _repository;
  GetTenantApplicationByIdUseCase(this._repository);
  Future<TenantApplication> execute(String id) => _repository.getById(id);
}

class GetTenantApplicationsUseCase {
  final TenantApplicationRepository _repository;
  GetTenantApplicationsUseCase(this._repository);
  Future<List<TenantApplication>> execute({
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

class CreateTenantApplicationUseCase {
  final TenantApplicationRepository _repository;
  CreateTenantApplicationUseCase(this._repository);
  Future<TenantApplication> execute(TenantApplication item) => _repository.create(item);
}

class UpdateTenantApplicationUseCase {
  final TenantApplicationRepository _repository;
  UpdateTenantApplicationUseCase(this._repository);
  Future<TenantApplication> execute(String id, TenantApplication item) => _repository.update(id, item);
}

class DeleteTenantApplicationUseCase {
  final TenantApplicationRepository _repository;
  DeleteTenantApplicationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
