import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_valuation_model_service.dart';

abstract class AiValuationModelRepository {
  Future<AiValuationModel> getById(String id);
  Future<List<AiValuationModel>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiValuationModel> create(AiValuationModel item);
  Future<AiValuationModel> update(String id, AiValuationModel item);
  Future<void> delete(String id);
}

class AiValuationModelRepositoryImpl implements AiValuationModelRepository {
  final AiValuationModelService _service;
  AiValuationModelRepositoryImpl(this._service);

  @override
  Future<AiValuationModel> getById(String id) => _service.getAiValuationModelById(id);

  @override
  Future<List<AiValuationModel>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiValuationModels(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiValuationModel> create(AiValuationModel item) => _service.createAiValuationModel(item);

  @override
  Future<AiValuationModel> update(String id, AiValuationModel item) => _service.updateAiValuationModel(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiValuationModel(id);
}
