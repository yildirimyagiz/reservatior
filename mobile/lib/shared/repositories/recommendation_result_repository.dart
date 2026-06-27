import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/recommendation_result_service.dart';

abstract class RecommendationResultRepository {
  Future<RecommendationResult> getById(String id);
  Future<List<RecommendationResult>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<RecommendationResult> create(RecommendationResult item);
  Future<RecommendationResult> update(String id, RecommendationResult item);
  Future<void> delete(String id);
}

class RecommendationResultRepositoryImpl implements RecommendationResultRepository {
  final RecommendationResultService _service;
  RecommendationResultRepositoryImpl(this._service);

  @override
  Future<RecommendationResult> getById(String id) => _service.getRecommendationResultById(id);

  @override
  Future<List<RecommendationResult>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getRecommendationResults(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<RecommendationResult> create(RecommendationResult item) => _service.createRecommendationResult(item);

  @override
  Future<RecommendationResult> update(String id, RecommendationResult item) => _service.updateRecommendationResult(id, item);

  @override
  Future<void> delete(String id) => _service.deleteRecommendationResult(id);
}
