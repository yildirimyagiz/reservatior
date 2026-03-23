import '../../features/shared/services/ai_recommendation_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIRecommendation

class GetAIRecommendationByIdUseCase {
  final AIRecommendationService _service;
  
  GetAIRecommendationByIdUseCase(this._service);
  
  Future<AIRecommendation> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIRecommendationsUseCase {
  final AIRecommendationService _service;
  
  GetAIRecommendationsUseCase(this._service);
  
  Future<List<AIRecommendation>> execute({
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

class CreateAIRecommendationUseCase {
  final AIRecommendationService _service;
  
  CreateAIRecommendationUseCase(this._service);
  
  Future<AIRecommendation> execute(AIRecommendation aIRecommendation) async {
    // Add validation logic here
    return await _service.create(aIRecommendation);
  }
}

class UpdateAIRecommendationUseCase {
  final AIRecommendationService _service;
  
  UpdateAIRecommendationUseCase(this._service);
  
  Future<AIRecommendation> execute(String id, AIRecommendation aIRecommendation) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIRecommendation);
  }
}

class DeleteAIRecommendationUseCase {
  final AIRecommendationService _service;
  
  DeleteAIRecommendationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIRecommendation Use Case Container
class AIRecommendationUseCases {
  final GetAIRecommendationByIdUseCase getById;
  final GetAIRecommendationsUseCase getAll;
  final CreateAIRecommendationUseCase create;
  final UpdateAIRecommendationUseCase update;
  final DeleteAIRecommendationUseCase delete;
  
  AIRecommendationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIRecommendationUseCases.create(AIRecommendationService service) {
    return AIRecommendationUseCases(
      getById: GetAIRecommendationByIdUseCase(service),
      getAll: GetAIRecommendationsUseCase(service),
      create: CreateAIRecommendationUseCase(service),
      update: UpdateAIRecommendationUseCase(service),
      delete: DeleteAIRecommendationUseCase(service),
    );
  }
}
