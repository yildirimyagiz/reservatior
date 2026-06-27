import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_recommendation_service.dart';

abstract class AiRecommendationRepository {
  Future<AiRecommendation> getById(String id);
  Future<List<AiRecommendation>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiRecommendation> create(AiRecommendation item);
  Future<AiRecommendation> update(String id, AiRecommendation item);
  Future<void> delete(String id);
}

class AiRecommendationRepositoryImpl implements AiRecommendationRepository {
  final AiRecommendationService _service;
  AiRecommendationRepositoryImpl(this._service);

  @override
  Future<AiRecommendation> getById(String id) => _service.getAiRecommendationById(id);

  @override
  Future<List<AiRecommendation>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiRecommendations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiRecommendation> create(AiRecommendation item) => _service.createAiRecommendation(item);

  @override
  Future<AiRecommendation> update(String id, AiRecommendation item) => _service.updateAiRecommendation(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiRecommendation(id);
}
