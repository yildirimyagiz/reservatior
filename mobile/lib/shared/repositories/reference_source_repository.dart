import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/reference_source_service.dart';

abstract class ReferenceSourceRepository {
  Future<ReferenceSource> getById(String id);
  Future<List<ReferenceSource>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ReferenceSource> create(ReferenceSource item);
  Future<ReferenceSource> update(String id, ReferenceSource item);
  Future<void> delete(String id);
}

class ReferenceSourceRepositoryImpl implements ReferenceSourceRepository {
  final ReferenceSourceService _service;
  ReferenceSourceRepositoryImpl(this._service);

  @override
  Future<ReferenceSource> getById(String id) => _service.getReferenceSourceById(id);

  @override
  Future<List<ReferenceSource>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getReferenceSources(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ReferenceSource> create(ReferenceSource item) => _service.createReferenceSource(item);

  @override
  Future<ReferenceSource> update(String id, ReferenceSource item) => _service.updateReferenceSource(id, item);

  @override
  Future<void> delete(String id) => _service.deleteReferenceSource(id);
}
