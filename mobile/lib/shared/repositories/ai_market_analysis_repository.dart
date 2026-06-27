import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_market_analysis_service.dart';

abstract class AiMarketAnalysisRepository {
  Future<AiMarketAnalysis> getById(String id);
  Future<List<AiMarketAnalysis>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiMarketAnalysis> create(AiMarketAnalysis item);
  Future<AiMarketAnalysis> update(String id, AiMarketAnalysis item);
  Future<void> delete(String id);
}

class AiMarketAnalysisRepositoryImpl implements AiMarketAnalysisRepository {
  final AiMarketAnalysisService _service;
  AiMarketAnalysisRepositoryImpl(this._service);

  @override
  Future<AiMarketAnalysis> getById(String id) => _service.getAiMarketAnalysisById(id);

  @override
  Future<List<AiMarketAnalysis>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiMarketAnalysises(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiMarketAnalysis> create(AiMarketAnalysis item) => _service.createAiMarketAnalysis(item);

  @override
  Future<AiMarketAnalysis> update(String id, AiMarketAnalysis item) => _service.updateAiMarketAnalysis(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiMarketAnalysis(id);
}
