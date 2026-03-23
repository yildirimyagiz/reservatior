import '../../features/shared/services/ai_valuation_model_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIValuationModel

class GetAIValuationModelByIdUseCase {
  final AIValuationModelService _service;
  
  GetAIValuationModelByIdUseCase(this._service);
  
  Future<AIValuationModel> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIValuationModelsUseCase {
  final AIValuationModelService _service;
  
  GetAIValuationModelsUseCase(this._service);
  
  Future<List<AIValuationModel>> execute({
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

class CreateAIValuationModelUseCase {
  final AIValuationModelService _service;
  
  CreateAIValuationModelUseCase(this._service);
  
  Future<AIValuationModel> execute(AIValuationModel aIValuationModel) async {
    // Add validation logic here
    return await _service.create(aIValuationModel);
  }
}

class UpdateAIValuationModelUseCase {
  final AIValuationModelService _service;
  
  UpdateAIValuationModelUseCase(this._service);
  
  Future<AIValuationModel> execute(String id, AIValuationModel aIValuationModel) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIValuationModel);
  }
}

class DeleteAIValuationModelUseCase {
  final AIValuationModelService _service;
  
  DeleteAIValuationModelUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIValuationModel Use Case Container
class AIValuationModelUseCases {
  final GetAIValuationModelByIdUseCase getById;
  final GetAIValuationModelsUseCase getAll;
  final CreateAIValuationModelUseCase create;
  final UpdateAIValuationModelUseCase update;
  final DeleteAIValuationModelUseCase delete;
  
  AIValuationModelUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIValuationModelUseCases.create(AIValuationModelService service) {
    return AIValuationModelUseCases(
      getById: GetAIValuationModelByIdUseCase(service),
      getAll: GetAIValuationModelsUseCase(service),
      create: CreateAIValuationModelUseCase(service),
      update: UpdateAIValuationModelUseCase(service),
      delete: DeleteAIValuationModelUseCase(service),
    );
  }
}
