import '../../features/shared/services/ai_model_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIModel

class GetAIModelByIdUseCase {
  final AIModelService _service;
  
  GetAIModelByIdUseCase(this._service);
  
  Future<AIModel> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIModelsUseCase {
  final AIModelService _service;
  
  GetAIModelsUseCase(this._service);
  
  Future<List<AIModel>> execute({
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

class CreateAIModelUseCase {
  final AIModelService _service;
  
  CreateAIModelUseCase(this._service);
  
  Future<AIModel> execute(AIModel aIModel) async {
    // Add validation logic here
    return await _service.create(aIModel);
  }
}

class UpdateAIModelUseCase {
  final AIModelService _service;
  
  UpdateAIModelUseCase(this._service);
  
  Future<AIModel> execute(String id, AIModel aIModel) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIModel);
  }
}

class DeleteAIModelUseCase {
  final AIModelService _service;
  
  DeleteAIModelUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIModel Use Case Container
class AIModelUseCases {
  final GetAIModelByIdUseCase getById;
  final GetAIModelsUseCase getAll;
  final CreateAIModelUseCase create;
  final UpdateAIModelUseCase update;
  final DeleteAIModelUseCase delete;
  
  AIModelUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIModelUseCases.create(AIModelService service) {
    return AIModelUseCases(
      getById: GetAIModelByIdUseCase(service),
      getAll: GetAIModelsUseCase(service),
      create: CreateAIModelUseCase(service),
      update: UpdateAIModelUseCase(service),
      delete: DeleteAIModelUseCase(service),
    );
  }
}
