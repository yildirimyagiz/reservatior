import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/predictive_model_service.dart';

abstract class PredictiveModelRepository {
  Future<PredictiveModel> getById(String id);
  Future<List<PredictiveModel>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PredictiveModel> create(PredictiveModel item);
  Future<PredictiveModel> update(String id, PredictiveModel item);
  Future<void> delete(String id);
}

class PredictiveModelRepositoryImpl implements PredictiveModelRepository {
  final PredictiveModelService _service;
  PredictiveModelRepositoryImpl(this._service);

  @override
  Future<PredictiveModel> getById(String id) => _service.getPredictiveModelById(id);

  @override
  Future<List<PredictiveModel>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPredictiveModels(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PredictiveModel> create(PredictiveModel item) => _service.createPredictiveModel(item);

  @override
  Future<PredictiveModel> update(String id, PredictiveModel item) => _service.updatePredictiveModel(id, item);

  @override
  Future<void> delete(String id) => _service.deletePredictiveModel(id);
}
