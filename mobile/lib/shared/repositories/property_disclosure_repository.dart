import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_disclosure_service.dart';

abstract class PropertyDisclosureRepository {
  Future<PropertyDisclosure> getById(String id);
  Future<List<PropertyDisclosure>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PropertyDisclosure> create(PropertyDisclosure item);
  Future<PropertyDisclosure> update(String id, PropertyDisclosure item);
  Future<void> delete(String id);
}

class PropertyDisclosureRepositoryImpl implements PropertyDisclosureRepository {
  final PropertyDisclosureService _service;
  PropertyDisclosureRepositoryImpl(this._service);

  @override
  Future<PropertyDisclosure> getById(String id) => _service.getPropertyDisclosureById(id);

  @override
  Future<List<PropertyDisclosure>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPropertyDisclosures(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyDisclosure> create(PropertyDisclosure item) => _service.createPropertyDisclosure(item);

  @override
  Future<PropertyDisclosure> update(String id, PropertyDisclosure item) => _service.updatePropertyDisclosure(id, item);

  @override
  Future<void> delete(String id) => _service.deletePropertyDisclosure(id);
}
