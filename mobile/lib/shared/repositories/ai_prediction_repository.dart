import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_prediction_service.dart';

abstract class AiPredictionRepository {
  Future<AiPrediction> getById(String id);
  Future<List<AiPrediction>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiPrediction> create(AiPrediction item);
  Future<AiPrediction> update(String id, AiPrediction item);
  Future<void> delete(String id);
}

class AiPredictionRepositoryImpl implements AiPredictionRepository {
  final AiPredictionService _service;
  AiPredictionRepositoryImpl(this._service);

  @override
  Future<AiPrediction> getById(String id) => _service.getAiPredictionById(id);

  @override
  Future<List<AiPrediction>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiPredictions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiPrediction> create(AiPrediction item) => _service.createAiPrediction(item);

  @override
  Future<AiPrediction> update(String id, AiPrediction item) => _service.updateAiPrediction(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiPrediction(id);
}
