import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_model_service.dart';

abstract class AiModelRepository {
  Future<AiModel> getById(String id);
  Future<List<AiModel>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiModel> create(AiModel item);
  Future<AiModel> update(String id, AiModel item);
  Future<void> delete(String id);
}

class AiModelRepositoryImpl implements AiModelRepository {
  final AiModelService _service;
  AiModelRepositoryImpl(this._service);

  @override
  Future<AiModel> getById(String id) => _service.getAiModelById(id);

  @override
  Future<List<AiModel>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiModels(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiModel> create(AiModel item) => _service.createAiModel(item);

  @override
  Future<AiModel> update(String id, AiModel item) => _service.updateAiModel(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiModel(id);
}
