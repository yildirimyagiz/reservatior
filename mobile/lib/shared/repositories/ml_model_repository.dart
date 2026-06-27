import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ml_model_service.dart';

abstract class MlModelRepository {
  Future<MlModel> getById(String id);
  Future<List<MlModel>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MlModel> create(MlModel item);
  Future<MlModel> update(String id, MlModel item);
  Future<void> delete(String id);
}

class MlModelRepositoryImpl implements MlModelRepository {
  final MlModelService _service;
  MlModelRepositoryImpl(this._service);

  @override
  Future<MlModel> getById(String id) => _service.getMlModelById(id);

  @override
  Future<List<MlModel>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMlModels(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MlModel> create(MlModel item) => _service.createMlModel(item);

  @override
  Future<MlModel> update(String id, MlModel item) => _service.updateMlModel(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMlModel(id);
}
