import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/availability_service.dart';

abstract class AvailabilityRepository {
  Future<Availability> getById(String id);
  Future<List<Availability>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Availability> create(Availability item);
  Future<Availability> update(String id, Availability item);
  Future<void> delete(String id);
}

class AvailabilityRepositoryImpl implements AvailabilityRepository {
  final AvailabilityService _service;
  AvailabilityRepositoryImpl(this._service);

  @override
  Future<Availability> getById(String id) => _service.getAvailabilityById(id);

  @override
  Future<List<Availability>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAvailabilities(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Availability> create(Availability item) => _service.createAvailability(item);

  @override
  Future<Availability> update(String id, Availability item) => _service.updateAvailability(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAvailability(id);
}
