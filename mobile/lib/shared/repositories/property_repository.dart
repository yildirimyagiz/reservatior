import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_service.dart';

abstract class PropertyRepository {
  Future<Property> getById(String id);
  Future<List<Property>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Property> create(Property item);
  Future<Property> update(String id, Property item);
  Future<void> delete(String id);
}

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyService _service;
  PropertyRepositoryImpl(this._service);

  @override
  Future<Property> getById(String id) => _service.getPropertyById(id);

  @override
  Future<List<Property>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getProperties(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Property> create(Property item) => _service.createProperty(item);

  @override
  Future<Property> update(String id, Property item) => _service.updateProperty(id, item);

  @override
  Future<void> delete(String id) => _service.deleteProperty(id);
}
