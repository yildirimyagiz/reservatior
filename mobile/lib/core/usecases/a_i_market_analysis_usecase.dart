import '../../features/shared/services/ai_market_analysis_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIMarketAnalysis

class GetAIMarketAnalysisByIdUseCase {
  final AIMarketAnalysisService _service;
  
  GetAIMarketAnalysisByIdUseCase(this._service);
  
  Future<AIMarketAnalysis> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIMarketAnalysissUseCase {
  final AIMarketAnalysisService _service;
  
  GetAIMarketAnalysissUseCase(this._service);
  
  Future<List<AIMarketAnalysis>> execute({
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

class CreateAIMarketAnalysisUseCase {
  final AIMarketAnalysisService _service;
  
  CreateAIMarketAnalysisUseCase(this._service);
  
  Future<AIMarketAnalysis> execute(AIMarketAnalysis aIMarketAnalysis) async {
    // Add validation logic here
    return await _service.create(aIMarketAnalysis);
  }
}

class UpdateAIMarketAnalysisUseCase {
  final AIMarketAnalysisService _service;
  
  UpdateAIMarketAnalysisUseCase(this._service);
  
  Future<AIMarketAnalysis> execute(String id, AIMarketAnalysis aIMarketAnalysis) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIMarketAnalysis);
  }
}

class DeleteAIMarketAnalysisUseCase {
  final AIMarketAnalysisService _service;
  
  DeleteAIMarketAnalysisUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIMarketAnalysis Use Case Container
class AIMarketAnalysisUseCases {
  final GetAIMarketAnalysisByIdUseCase getById;
  final GetAIMarketAnalysissUseCase getAll;
  final CreateAIMarketAnalysisUseCase create;
  final UpdateAIMarketAnalysisUseCase update;
  final DeleteAIMarketAnalysisUseCase delete;
  
  AIMarketAnalysisUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIMarketAnalysisUseCases.create(AIMarketAnalysisService service) {
    return AIMarketAnalysisUseCases(
      getById: GetAIMarketAnalysisByIdUseCase(service),
      getAll: GetAIMarketAnalysissUseCase(service),
      create: CreateAIMarketAnalysisUseCase(service),
      update: UpdateAIMarketAnalysisUseCase(service),
      delete: DeleteAIMarketAnalysisUseCase(service),
    );
  }
}
