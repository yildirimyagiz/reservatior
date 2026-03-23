import '../../features/shared/services/ai_investment_analysis_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIInvestmentAnalysis

class GetAIInvestmentAnalysisByIdUseCase {
  final AIInvestmentAnalysisService _service;
  
  GetAIInvestmentAnalysisByIdUseCase(this._service);
  
  Future<AIInvestmentAnalysis> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIInvestmentAnalysissUseCase {
  final AIInvestmentAnalysisService _service;
  
  GetAIInvestmentAnalysissUseCase(this._service);
  
  Future<List<AIInvestmentAnalysis>> execute({
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

class CreateAIInvestmentAnalysisUseCase {
  final AIInvestmentAnalysisService _service;
  
  CreateAIInvestmentAnalysisUseCase(this._service);
  
  Future<AIInvestmentAnalysis> execute(AIInvestmentAnalysis aIInvestmentAnalysis) async {
    // Add validation logic here
    return await _service.create(aIInvestmentAnalysis);
  }
}

class UpdateAIInvestmentAnalysisUseCase {
  final AIInvestmentAnalysisService _service;
  
  UpdateAIInvestmentAnalysisUseCase(this._service);
  
  Future<AIInvestmentAnalysis> execute(String id, AIInvestmentAnalysis aIInvestmentAnalysis) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIInvestmentAnalysis);
  }
}

class DeleteAIInvestmentAnalysisUseCase {
  final AIInvestmentAnalysisService _service;
  
  DeleteAIInvestmentAnalysisUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIInvestmentAnalysis Use Case Container
class AIInvestmentAnalysisUseCases {
  final GetAIInvestmentAnalysisByIdUseCase getById;
  final GetAIInvestmentAnalysissUseCase getAll;
  final CreateAIInvestmentAnalysisUseCase create;
  final UpdateAIInvestmentAnalysisUseCase update;
  final DeleteAIInvestmentAnalysisUseCase delete;
  
  AIInvestmentAnalysisUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIInvestmentAnalysisUseCases.create(AIInvestmentAnalysisService service) {
    return AIInvestmentAnalysisUseCases(
      getById: GetAIInvestmentAnalysisByIdUseCase(service),
      getAll: GetAIInvestmentAnalysissUseCase(service),
      create: CreateAIInvestmentAnalysisUseCase(service),
      update: UpdateAIInvestmentAnalysisUseCase(service),
      delete: DeleteAIInvestmentAnalysisUseCase(service),
    );
  }
}
