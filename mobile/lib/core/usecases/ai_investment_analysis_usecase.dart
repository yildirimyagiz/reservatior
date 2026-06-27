import 'package:reservatior/shared/repositories/ai_investment_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiInvestmentAnalysisByIdUseCase {
  final AiInvestmentAnalysisRepository _repository;
  GetAiInvestmentAnalysisByIdUseCase(this._repository);
  Future<AiInvestmentAnalysis> execute(String id) => _repository.getById(id);
}

class GetAiInvestmentAnalysissUseCase {
  final AiInvestmentAnalysisRepository _repository;
  GetAiInvestmentAnalysissUseCase(this._repository);
  Future<List<AiInvestmentAnalysis>> execute({
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

class CreateAiInvestmentAnalysisUseCase {
  final AiInvestmentAnalysisRepository _repository;
  CreateAiInvestmentAnalysisUseCase(this._repository);
  Future<AiInvestmentAnalysis> execute(AiInvestmentAnalysis item) => _repository.create(item);
}

class UpdateAiInvestmentAnalysisUseCase {
  final AiInvestmentAnalysisRepository _repository;
  UpdateAiInvestmentAnalysisUseCase(this._repository);
  Future<AiInvestmentAnalysis> execute(String id, AiInvestmentAnalysis item) => _repository.update(id, item);
}

class DeleteAiInvestmentAnalysisUseCase {
  final AiInvestmentAnalysisRepository _repository;
  DeleteAiInvestmentAnalysisUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
