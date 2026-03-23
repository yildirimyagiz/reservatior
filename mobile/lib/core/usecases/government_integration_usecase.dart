import '../../features/shared/services/government_integration_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for GovernmentIntegration

class GetGovernmentIntegrationByIdUseCase {
  final GovernmentIntegrationService _service;
  
  GetGovernmentIntegrationByIdUseCase(this._service);
  
  Future<GovernmentIntegration> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetGovernmentIntegrationsUseCase {
  final GovernmentIntegrationService _service;
  
  GetGovernmentIntegrationsUseCase(this._service);
  
  Future<List<GovernmentIntegration>> execute({
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

class CreateGovernmentIntegrationUseCase {
  final GovernmentIntegrationService _service;
  
  CreateGovernmentIntegrationUseCase(this._service);
  
  Future<GovernmentIntegration> execute(GovernmentIntegration governmentIntegration) async {
    // Add validation logic here
    return await _service.create(governmentIntegration);
  }
}

class UpdateGovernmentIntegrationUseCase {
  final GovernmentIntegrationService _service;
  
  UpdateGovernmentIntegrationUseCase(this._service);
  
  Future<GovernmentIntegration> execute(String id, GovernmentIntegration governmentIntegration) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, governmentIntegration);
  }
}

class DeleteGovernmentIntegrationUseCase {
  final GovernmentIntegrationService _service;
  
  DeleteGovernmentIntegrationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// GovernmentIntegration Use Case Container
class GovernmentIntegrationUseCases {
  final GetGovernmentIntegrationByIdUseCase getById;
  final GetGovernmentIntegrationsUseCase getAll;
  final CreateGovernmentIntegrationUseCase create;
  final UpdateGovernmentIntegrationUseCase update;
  final DeleteGovernmentIntegrationUseCase delete;
  
  GovernmentIntegrationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory GovernmentIntegrationUseCases.create(GovernmentIntegrationService service) {
    return GovernmentIntegrationUseCases(
      getById: GetGovernmentIntegrationByIdUseCase(service),
      getAll: GetGovernmentIntegrationsUseCase(service),
      create: CreateGovernmentIntegrationUseCase(service),
      update: UpdateGovernmentIntegrationUseCase(service),
      delete: DeleteGovernmentIntegrationUseCase(service),
    );
  }
}
