import '../../features/shared/services/ai_tenant_screening_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AITenantScreening

class GetAITenantScreeningByIdUseCase {
  final AITenantScreeningService _service;
  
  GetAITenantScreeningByIdUseCase(this._service);
  
  Future<AITenantScreening> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAITenantScreeningsUseCase {
  final AITenantScreeningService _service;
  
  GetAITenantScreeningsUseCase(this._service);
  
  Future<List<AITenantScreening>> execute({
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

class CreateAITenantScreeningUseCase {
  final AITenantScreeningService _service;
  
  CreateAITenantScreeningUseCase(this._service);
  
  Future<AITenantScreening> execute(AITenantScreening aITenantScreening) async {
    // Add validation logic here
    return await _service.create(aITenantScreening);
  }
}

class UpdateAITenantScreeningUseCase {
  final AITenantScreeningService _service;
  
  UpdateAITenantScreeningUseCase(this._service);
  
  Future<AITenantScreening> execute(String id, AITenantScreening aITenantScreening) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aITenantScreening);
  }
}

class DeleteAITenantScreeningUseCase {
  final AITenantScreeningService _service;
  
  DeleteAITenantScreeningUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AITenantScreening Use Case Container
class AITenantScreeningUseCases {
  final GetAITenantScreeningByIdUseCase getById;
  final GetAITenantScreeningsUseCase getAll;
  final CreateAITenantScreeningUseCase create;
  final UpdateAITenantScreeningUseCase update;
  final DeleteAITenantScreeningUseCase delete;
  
  AITenantScreeningUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AITenantScreeningUseCases.create(AITenantScreeningService service) {
    return AITenantScreeningUseCases(
      getById: GetAITenantScreeningByIdUseCase(service),
      getAll: GetAITenantScreeningsUseCase(service),
      create: CreateAITenantScreeningUseCase(service),
      update: UpdateAITenantScreeningUseCase(service),
      delete: DeleteAITenantScreeningUseCase(service),
    );
  }
}
