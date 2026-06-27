import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_lead_scoring_service.dart';

abstract class AiLeadScoringRepository {
  Future<AiLeadScoring> getById(String id);
  Future<List<AiLeadScoring>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiLeadScoring> create(AiLeadScoring item);
  Future<AiLeadScoring> update(String id, AiLeadScoring item);
  Future<void> delete(String id);
}

class AiLeadScoringRepositoryImpl implements AiLeadScoringRepository {
  final AiLeadScoringService _service;
  AiLeadScoringRepositoryImpl(this._service);

  @override
  Future<AiLeadScoring> getById(String id) => _service.getAiLeadScoringById(id);

  @override
  Future<List<AiLeadScoring>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiLeadScorings(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiLeadScoring> create(AiLeadScoring item) => _service.createAiLeadScoring(item);

  @override
  Future<AiLeadScoring> update(String id, AiLeadScoring item) => _service.updateAiLeadScoring(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiLeadScoring(id);
}
