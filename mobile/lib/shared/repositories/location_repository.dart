import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/location_service.dart';

abstract class LocationRepository {
  Future<Location> getById(String id);
  Future<List<Location>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Location> create(Location item);
  Future<Location> update(String id, Location item);
  Future<void> delete(String id);
}

class LocationRepositoryImpl implements LocationRepository {
  final LocationService _service;
  LocationRepositoryImpl(this._service);

  @override
  Future<Location> getById(String id) => _service.getLocationById(id);

  @override
  Future<List<Location>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getLocations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Location> create(Location item) => _service.createLocation(item);

  @override
  Future<Location> update(String id, Location item) => _service.updateLocation(id, item);

  @override
  Future<void> delete(String id) => _service.deleteLocation(id);
}
