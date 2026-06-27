import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/shared_amenity_service.dart';

abstract class SharedAmenityRepository {
  Future<SharedAmenity> getById(String id);
  Future<List<SharedAmenity>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<SharedAmenity> create(SharedAmenity item);
  Future<SharedAmenity> update(String id, SharedAmenity item);
  Future<void> delete(String id);
}

class SharedAmenityRepositoryImpl implements SharedAmenityRepository {
  final SharedAmenityService _service;
  SharedAmenityRepositoryImpl(this._service);

  @override
  Future<SharedAmenity> getById(String id) => _service.getSharedAmenityById(id);

  @override
  Future<List<SharedAmenity>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSharedAmenities(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<SharedAmenity> create(SharedAmenity item) => _service.createSharedAmenity(item);

  @override
  Future<SharedAmenity> update(String id, SharedAmenity item) => _service.updateSharedAmenity(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSharedAmenity(id);
}
