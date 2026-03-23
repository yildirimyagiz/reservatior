import '../../features/shared/services/tenant_application_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for TenantApplication

class GetTenantApplicationByIdUseCase {
  final TenantApplicationService _service;
  
  GetTenantApplicationByIdUseCase(this._service);
  
  Future<TenantApplication> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetTenantApplicationsUseCase {
  final TenantApplicationService _service;
  
  GetTenantApplicationsUseCase(this._service);
  
  Future<List<TenantApplication>> execute({
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

class CreateTenantApplicationUseCase {
  final TenantApplicationService _service;
  
  CreateTenantApplicationUseCase(this._service);
  
  Future<TenantApplication> execute(TenantApplication tenantApplication) async {
    // Add validation logic here
    return await _service.create(tenantApplication);
  }
}

class UpdateTenantApplicationUseCase {
  final TenantApplicationService _service;
  
  UpdateTenantApplicationUseCase(this._service);
  
  Future<TenantApplication> execute(String id, TenantApplication tenantApplication) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, tenantApplication);
  }
}

class DeleteTenantApplicationUseCase {
  final TenantApplicationService _service;
  
  DeleteTenantApplicationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// TenantApplication Use Case Container
class TenantApplicationUseCases {
  final GetTenantApplicationByIdUseCase getById;
  final GetTenantApplicationsUseCase getAll;
  final CreateTenantApplicationUseCase create;
  final UpdateTenantApplicationUseCase update;
  final DeleteTenantApplicationUseCase delete;
  
  TenantApplicationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory TenantApplicationUseCases.create(TenantApplicationService service) {
    return TenantApplicationUseCases(
      getById: GetTenantApplicationByIdUseCase(service),
      getAll: GetTenantApplicationsUseCase(service),
      create: CreateTenantApplicationUseCase(service),
      update: UpdateTenantApplicationUseCase(service),
      delete: DeleteTenantApplicationUseCase(service),
    );
  }
}
