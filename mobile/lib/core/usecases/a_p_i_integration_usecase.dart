import '../../features/shared/services/api_integration_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ApiIntegration

class GetApiIntegrationByIdUseCase {
  final ApiIntegrationService _service;
  
  GetApiIntegrationByIdUseCase(this._service);
  
  Future<ApiIntegration> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetApiIntegrationsUseCase {
  final ApiIntegrationService _service;
  
  GetApiIntegrationsUseCase(this._service);
  
  Future<List<ApiIntegration>> execute({
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

class CreateApiIntegrationUseCase {
  final ApiIntegrationService _service;
  
  CreateApiIntegrationUseCase(this._service);
  
  Future<ApiIntegration> execute(ApiIntegration aPIIntegration) async {
    // Add validation logic here
    return await _service.create(aPIIntegration);
  }
}

class UpdateApiIntegrationUseCase {
  final ApiIntegrationService _service;
  
  UpdateApiIntegrationUseCase(this._service);
  
  Future<ApiIntegration> execute(String id, ApiIntegration aPIIntegration) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aPIIntegration);
  }
}

class DeleteApiIntegrationUseCase {
  final ApiIntegrationService _service;
  
  DeleteApiIntegrationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ApiIntegration Use Case Container
class ApiIntegrationUseCases {
  final GetApiIntegrationByIdUseCase getById;
  final GetApiIntegrationsUseCase getAll;
  final CreateApiIntegrationUseCase create;
  final UpdateApiIntegrationUseCase update;
  final DeleteApiIntegrationUseCase delete;
  
  ApiIntegrationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ApiIntegrationUseCases.create(ApiIntegrationService service) {
    return ApiIntegrationUseCases(
      getById: GetApiIntegrationByIdUseCase(service),
      getAll: GetApiIntegrationsUseCase(service),
      create: CreateApiIntegrationUseCase(service),
      update: UpdateApiIntegrationUseCase(service),
      delete: DeleteApiIntegrationUseCase(service),
    );
  }
}
