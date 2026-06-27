import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/amenity_service.dart';

abstract class AmenityRepository {
  Future<Amenity> getById(String id);
  Future<List<Amenity>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Amenity> create(Amenity item);
  Future<Amenity> update(String id, Amenity item);
  Future<void> delete(String id);
}

class AmenityRepositoryImpl implements AmenityRepository {
  final AmenityService _service;
  AmenityRepositoryImpl(this._service);

  @override
  Future<Amenity> getById(String id) => _service.getAmenityById(id);

  @override
  Future<List<Amenity>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAmenities(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Amenity> create(Amenity item) => _service.createAmenity(item);

  @override
  Future<Amenity> update(String id, Amenity item) => _service.updateAmenity(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAmenity(id);
}
