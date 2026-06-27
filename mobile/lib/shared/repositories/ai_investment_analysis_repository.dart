import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_investment_analysis_service.dart';

abstract class AiInvestmentAnalysisRepository {
  Future<AiInvestmentAnalysis> getById(String id);
  Future<List<AiInvestmentAnalysis>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiInvestmentAnalysis> create(AiInvestmentAnalysis item);
  Future<AiInvestmentAnalysis> update(String id, AiInvestmentAnalysis item);
  Future<void> delete(String id);
}

class AiInvestmentAnalysisRepositoryImpl implements AiInvestmentAnalysisRepository {
  final AiInvestmentAnalysisService _service;
  AiInvestmentAnalysisRepositoryImpl(this._service);

  @override
  Future<AiInvestmentAnalysis> getById(String id) => _service.getAiInvestmentAnalysisById(id);

  @override
  Future<List<AiInvestmentAnalysis>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiInvestmentAnalysises(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiInvestmentAnalysis> create(AiInvestmentAnalysis item) => _service.createAiInvestmentAnalysis(item);

  @override
  Future<AiInvestmentAnalysis> update(String id, AiInvestmentAnalysis item) => _service.updateAiInvestmentAnalysis(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiInvestmentAnalysis(id);
}
