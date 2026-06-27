import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_viewing_service.dart';

abstract class PropertyViewingRepository {
  Future<PropertyViewing> getById(String id);
  Future<List<PropertyViewing>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PropertyViewing> create(PropertyViewing item);
  Future<PropertyViewing> update(String id, PropertyViewing item);
  Future<void> delete(String id);
}

class PropertyViewingRepositoryImpl implements PropertyViewingRepository {
  final PropertyViewingService _service;
  PropertyViewingRepositoryImpl(this._service);

  @override
  Future<PropertyViewing> getById(String id) => _service.getPropertyViewingById(id);

  @override
  Future<List<PropertyViewing>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPropertyViewings(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyViewing> create(PropertyViewing item) => _service.createPropertyViewing(item);

  @override
  Future<PropertyViewing> update(String id, PropertyViewing item) => _service.updatePropertyViewing(id, item);

  @override
  Future<void> delete(String id) => _service.deletePropertyViewing(id);
}
