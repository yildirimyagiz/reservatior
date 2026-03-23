import '../../features/shared/services/tenant_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Tenant

class GetTenantByIdUseCase {
  final TenantService _service;
  
  GetTenantByIdUseCase(this._service);
  
  Future<Tenant> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetTenantsUseCase {
  final TenantService _service;
  
  GetTenantsUseCase(this._service);
  
  Future<List<Tenant>> execute({
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

class CreateTenantUseCase {
  final TenantService _service;
  
  CreateTenantUseCase(this._service);
  
  Future<Tenant> execute(Tenant tenant) async {
    // Add validation logic here
    return await _service.create(tenant);
  }
}

class UpdateTenantUseCase {
  final TenantService _service;
  
  UpdateTenantUseCase(this._service);
  
  Future<Tenant> execute(String id, Tenant tenant) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, tenant);
  }
}

class DeleteTenantUseCase {
  final TenantService _service;
  
  DeleteTenantUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Tenant Use Case Container
class TenantUseCases {
  final GetTenantByIdUseCase getById;
  final GetTenantsUseCase getAll;
  final CreateTenantUseCase create;
  final UpdateTenantUseCase update;
  final DeleteTenantUseCase delete;
  
  TenantUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory TenantUseCases.create(TenantService service) {
    return TenantUseCases(
      getById: GetTenantByIdUseCase(service),
      getAll: GetTenantsUseCase(service),
      create: CreateTenantUseCase(service),
      update: UpdateTenantUseCase(service),
      delete: DeleteTenantUseCase(service),
    );
  }
}
