import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mls_data_mapping_service.dart';

abstract class MlsDataMappingRepository {
  Future<MlsDataMapping> getById(String id);
  Future<List<MlsDataMapping>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MlsDataMapping> create(MlsDataMapping item);
  Future<MlsDataMapping> update(String id, MlsDataMapping item);
  Future<void> delete(String id);
}

class MlsDataMappingRepositoryImpl implements MlsDataMappingRepository {
  final MlsDataMappingService _service;
  MlsDataMappingRepositoryImpl(this._service);

  @override
  Future<MlsDataMapping> getById(String id) => _service.getMlsDataMappingById(id);

  @override
  Future<List<MlsDataMapping>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMlsDataMappings(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MlsDataMapping> create(MlsDataMapping item) => _service.createMlsDataMapping(item);

  @override
  Future<MlsDataMapping> update(String id, MlsDataMapping item) => _service.updateMlsDataMapping(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMlsDataMapping(id);
}
