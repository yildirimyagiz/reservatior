import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_sentiment_analysis_service.dart';

abstract class AiSentimentAnalysisRepository {
  Future<AiSentimentAnalysis> getById(String id);
  Future<List<AiSentimentAnalysis>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiSentimentAnalysis> create(AiSentimentAnalysis item);
  Future<AiSentimentAnalysis> update(String id, AiSentimentAnalysis item);
  Future<void> delete(String id);
}

class AiSentimentAnalysisRepositoryImpl implements AiSentimentAnalysisRepository {
  final AiSentimentAnalysisService _service;
  AiSentimentAnalysisRepositoryImpl(this._service);

  @override
  Future<AiSentimentAnalysis> getById(String id) => _service.getAiSentimentAnalysisById(id);

  @override
  Future<List<AiSentimentAnalysis>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiSentimentAnalysises(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiSentimentAnalysis> create(AiSentimentAnalysis item) => _service.createAiSentimentAnalysis(item);

  @override
  Future<AiSentimentAnalysis> update(String id, AiSentimentAnalysis item) => _service.updateAiSentimentAnalysis(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiSentimentAnalysis(id);
}
