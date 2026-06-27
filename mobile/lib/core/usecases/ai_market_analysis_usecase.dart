import 'package:reservatior/shared/repositories/ai_market_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiMarketAnalysisByIdUseCase {
  final AiMarketAnalysisRepository _repository;
  GetAiMarketAnalysisByIdUseCase(this._repository);
  Future<AiMarketAnalysis> execute(String id) => _repository.getById(id);
}

class GetAiMarketAnalysissUseCase {
  final AiMarketAnalysisRepository _repository;
  GetAiMarketAnalysissUseCase(this._repository);
  Future<List<AiMarketAnalysis>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateAiMarketAnalysisUseCase {
  final AiMarketAnalysisRepository _repository;
  CreateAiMarketAnalysisUseCase(this._repository);
  Future<AiMarketAnalysis> execute(AiMarketAnalysis item) => _repository.create(item);
}

class UpdateAiMarketAnalysisUseCase {
  final AiMarketAnalysisRepository _repository;
  UpdateAiMarketAnalysisUseCase(this._repository);
  Future<AiMarketAnalysis> execute(String id, AiMarketAnalysis item) => _repository.update(id, item);
}

class DeleteAiMarketAnalysisUseCase {
  final AiMarketAnalysisRepository _repository;
  DeleteAiMarketAnalysisUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
