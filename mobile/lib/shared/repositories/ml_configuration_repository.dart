import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ml_configuration_service.dart';

abstract class MlConfigurationRepository {
  Future<MlConfiguration> getById(String id);
  Future<List<MlConfiguration>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MlConfiguration> create(MlConfiguration item);
  Future<MlConfiguration> update(String id, MlConfiguration item);
  Future<void> delete(String id);
}

class MlConfigurationRepositoryImpl implements MlConfigurationRepository {
  final MlConfigurationService _service;
  MlConfigurationRepositoryImpl(this._service);

  @override
  Future<MlConfiguration> getById(String id) => _service.getMlConfigurationById(id);

  @override
  Future<List<MlConfiguration>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMlConfigurations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MlConfiguration> create(MlConfiguration item) => _service.createMlConfiguration(item);

  @override
  Future<MlConfiguration> update(String id, MlConfiguration item) => _service.updateMlConfiguration(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMlConfiguration(id);
}
