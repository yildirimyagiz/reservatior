import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/facility_service.dart';

abstract class FacilityRepository {
  Future<Facility> getById(String id);
  Future<List<Facility>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Facility> create(Facility item);
  Future<Facility> update(String id, Facility item);
  Future<void> delete(String id);
}

class FacilityRepositoryImpl implements FacilityRepository {
  final FacilityService _service;
  FacilityRepositoryImpl(this._service);

  @override
  Future<Facility> getById(String id) => _service.getFacilityById(id);

  @override
  Future<List<Facility>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getFacilities(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Facility> create(Facility item) => _service.createFacility(item);

  @override
  Future<Facility> update(String id, Facility item) => _service.updateFacility(id, item);

  @override
  Future<void> delete(String id) => _service.deleteFacility(id);
}
