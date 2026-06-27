import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_amenity_service.dart';

abstract class PropertyAmenityRepository {
  Future<PropertyAmenity> getById(String id);
  Future<List<PropertyAmenity>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PropertyAmenity> create(PropertyAmenity item);
  Future<PropertyAmenity> update(String id, PropertyAmenity item);
  Future<void> delete(String id);
}

class PropertyAmenityRepositoryImpl implements PropertyAmenityRepository {
  final PropertyAmenityService _service;
  PropertyAmenityRepositoryImpl(this._service);

  @override
  Future<PropertyAmenity> getById(String id) => _service.getPropertyAmenityById(id);

  @override
  Future<List<PropertyAmenity>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPropertyAmenities(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyAmenity> create(PropertyAmenity item) => _service.createPropertyAmenity(item);

  @override
  Future<PropertyAmenity> update(String id, PropertyAmenity item) => _service.updatePropertyAmenity(id, item);

  @override
  Future<void> delete(String id) => _service.deletePropertyAmenity(id);
}
