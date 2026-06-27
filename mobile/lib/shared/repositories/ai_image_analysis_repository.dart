import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_image_analysis_service.dart';

abstract class AiImageAnalysisRepository {
  Future<AiImageAnalysis> getById(String id);
  Future<List<AiImageAnalysis>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiImageAnalysis> create(AiImageAnalysis item);
  Future<AiImageAnalysis> update(String id, AiImageAnalysis item);
  Future<void> delete(String id);
}

class AiImageAnalysisRepositoryImpl implements AiImageAnalysisRepository {
  final AiImageAnalysisService _service;
  AiImageAnalysisRepositoryImpl(this._service);

  @override
  Future<AiImageAnalysis> getById(String id) => _service.getAiImageAnalysisById(id);

  @override
  Future<List<AiImageAnalysis>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiImageAnalysises(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiImageAnalysis> create(AiImageAnalysis item) => _service.createAiImageAnalysis(item);

  @override
  Future<AiImageAnalysis> update(String id, AiImageAnalysis item) => _service.updateAiImageAnalysis(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiImageAnalysis(id);
}
