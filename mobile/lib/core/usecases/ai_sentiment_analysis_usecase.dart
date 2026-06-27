import 'package:reservatior/shared/repositories/ai_sentiment_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiSentimentAnalysisByIdUseCase {
  final AiSentimentAnalysisRepository _repository;
  GetAiSentimentAnalysisByIdUseCase(this._repository);
  Future<AiSentimentAnalysis> execute(String id) => _repository.getById(id);
}

class GetAiSentimentAnalysissUseCase {
  final AiSentimentAnalysisRepository _repository;
  GetAiSentimentAnalysissUseCase(this._repository);
  Future<List<AiSentimentAnalysis>> execute({
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

class CreateAiSentimentAnalysisUseCase {
  final AiSentimentAnalysisRepository _repository;
  CreateAiSentimentAnalysisUseCase(this._repository);
  Future<AiSentimentAnalysis> execute(AiSentimentAnalysis item) => _repository.create(item);
}

class UpdateAiSentimentAnalysisUseCase {
  final AiSentimentAnalysisRepository _repository;
  UpdateAiSentimentAnalysisUseCase(this._repository);
  Future<AiSentimentAnalysis> execute(String id, AiSentimentAnalysis item) => _repository.update(id, item);
}

class DeleteAiSentimentAnalysisUseCase {
  final AiSentimentAnalysisRepository _repository;
  DeleteAiSentimentAnalysisUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
