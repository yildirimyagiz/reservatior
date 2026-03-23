import '../../features/shared/services/ai_property_valuation_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIPropertyValuation

class GetAIPropertyValuationByIdUseCase {
  final AIPropertyValuationService _service;
  
  GetAIPropertyValuationByIdUseCase(this._service);
  
  Future<AIPropertyValuation> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIPropertyValuationsUseCase {
  final AIPropertyValuationService _service;
  
  GetAIPropertyValuationsUseCase(this._service);
  
  Future<List<AIPropertyValuation>> execute({
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

class CreateAIPropertyValuationUseCase {
  final AIPropertyValuationService _service;
  
  CreateAIPropertyValuationUseCase(this._service);
  
  Future<AIPropertyValuation> execute(AIPropertyValuation aIPropertyValuation) async {
    // Add validation logic here
    return await _service.create(aIPropertyValuation);
  }
}

class UpdateAIPropertyValuationUseCase {
  final AIPropertyValuationService _service;
  
  UpdateAIPropertyValuationUseCase(this._service);
  
  Future<AIPropertyValuation> execute(String id, AIPropertyValuation aIPropertyValuation) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIPropertyValuation);
  }
}

class DeleteAIPropertyValuationUseCase {
  final AIPropertyValuationService _service;
  
  DeleteAIPropertyValuationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIPropertyValuation Use Case Container
class AIPropertyValuationUseCases {
  final GetAIPropertyValuationByIdUseCase getById;
  final GetAIPropertyValuationsUseCase getAll;
  final CreateAIPropertyValuationUseCase create;
  final UpdateAIPropertyValuationUseCase update;
  final DeleteAIPropertyValuationUseCase delete;
  
  AIPropertyValuationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIPropertyValuationUseCases.create(AIPropertyValuationService service) {
    return AIPropertyValuationUseCases(
      getById: GetAIPropertyValuationByIdUseCase(service),
      getAll: GetAIPropertyValuationsUseCase(service),
      create: CreateAIPropertyValuationUseCase(service),
      update: UpdateAIPropertyValuationUseCase(service),
      delete: DeleteAIPropertyValuationUseCase(service),
    );
  }
}
