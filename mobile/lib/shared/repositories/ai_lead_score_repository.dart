import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_lead_score_service.dart';

abstract class AiLeadScoreRepository {
  Future<AiLeadScore> getById(String id);
  Future<List<AiLeadScore>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiLeadScore> create(AiLeadScore item);
  Future<AiLeadScore> update(String id, AiLeadScore item);
  Future<void> delete(String id);
}

class AiLeadScoreRepositoryImpl implements AiLeadScoreRepository {
  final AiLeadScoreService _service;
  AiLeadScoreRepositoryImpl(this._service);

  @override
  Future<AiLeadScore> getById(String id) => _service.getAiLeadScoreById(id);

  @override
  Future<List<AiLeadScore>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiLeadScores(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiLeadScore> create(AiLeadScore item) => _service.createAiLeadScore(item);

  @override
  Future<AiLeadScore> update(String id, AiLeadScore item) => _service.updateAiLeadScore(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiLeadScore(id);
}
