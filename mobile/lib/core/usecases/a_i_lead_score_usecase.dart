import '../../features/shared/services/ai_lead_score_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AILeadScore

class GetAILeadScoreByIdUseCase {
  final AILeadScoreService _service;
  
  GetAILeadScoreByIdUseCase(this._service);
  
  Future<AILeadScore> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAILeadScoresUseCase {
  final AILeadScoreService _service;
  
  GetAILeadScoresUseCase(this._service);
  
  Future<List<AILeadScore>> execute({
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

class CreateAILeadScoreUseCase {
  final AILeadScoreService _service;
  
  CreateAILeadScoreUseCase(this._service);
  
  Future<AILeadScore> execute(AILeadScore aILeadScore) async {
    // Add validation logic here
    return await _service.create(aILeadScore);
  }
}

class UpdateAILeadScoreUseCase {
  final AILeadScoreService _service;
  
  UpdateAILeadScoreUseCase(this._service);
  
  Future<AILeadScore> execute(String id, AILeadScore aILeadScore) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aILeadScore);
  }
}

class DeleteAILeadScoreUseCase {
  final AILeadScoreService _service;
  
  DeleteAILeadScoreUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AILeadScore Use Case Container
class AILeadScoreUseCases {
  final GetAILeadScoreByIdUseCase getById;
  final GetAILeadScoresUseCase getAll;
  final CreateAILeadScoreUseCase create;
  final UpdateAILeadScoreUseCase update;
  final DeleteAILeadScoreUseCase delete;
  
  AILeadScoreUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AILeadScoreUseCases.create(AILeadScoreService service) {
    return AILeadScoreUseCases(
      getById: GetAILeadScoreByIdUseCase(service),
      getAll: GetAILeadScoresUseCase(service),
      create: CreateAILeadScoreUseCase(service),
      update: UpdateAILeadScoreUseCase(service),
      delete: DeleteAILeadScoreUseCase(service),
    );
  }
}
