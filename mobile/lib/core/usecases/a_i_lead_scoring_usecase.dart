import '../../features/shared/services/ai_lead_scoring_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AILeadScoring

class GetAILeadScoringByIdUseCase {
  final AILeadScoringService _service;
  
  GetAILeadScoringByIdUseCase(this._service);
  
  Future<AILeadScoring> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAILeadScoringsUseCase {
  final AILeadScoringService _service;
  
  GetAILeadScoringsUseCase(this._service);
  
  Future<List<AILeadScoring>> execute({
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

class CreateAILeadScoringUseCase {
  final AILeadScoringService _service;
  
  CreateAILeadScoringUseCase(this._service);
  
  Future<AILeadScoring> execute(AILeadScoring aILeadScoring) async {
    // Add validation logic here
    return await _service.create(aILeadScoring);
  }
}

class UpdateAILeadScoringUseCase {
  final AILeadScoringService _service;
  
  UpdateAILeadScoringUseCase(this._service);
  
  Future<AILeadScoring> execute(String id, AILeadScoring aILeadScoring) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aILeadScoring);
  }
}

class DeleteAILeadScoringUseCase {
  final AILeadScoringService _service;
  
  DeleteAILeadScoringUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AILeadScoring Use Case Container
class AILeadScoringUseCases {
  final GetAILeadScoringByIdUseCase getById;
  final GetAILeadScoringsUseCase getAll;
  final CreateAILeadScoringUseCase create;
  final UpdateAILeadScoringUseCase update;
  final DeleteAILeadScoringUseCase delete;
  
  AILeadScoringUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AILeadScoringUseCases.create(AILeadScoringService service) {
    return AILeadScoringUseCases(
      getById: GetAILeadScoringByIdUseCase(service),
      getAll: GetAILeadScoringsUseCase(service),
      create: CreateAILeadScoringUseCase(service),
      update: UpdateAILeadScoringUseCase(service),
      delete: DeleteAILeadScoringUseCase(service),
    );
  }
}
