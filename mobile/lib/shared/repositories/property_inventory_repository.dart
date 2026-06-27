import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_inventory_service.dart';

abstract class PropertyInventoryRepository {
  Future<PropertyInventory> getById(String id);
  Future<List<PropertyInventory>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PropertyInventory> create(PropertyInventory item);
  Future<PropertyInventory> update(String id, PropertyInventory item);
  Future<void> delete(String id);
}

class PropertyInventoryRepositoryImpl implements PropertyInventoryRepository {
  final PropertyInventoryService _service;
  PropertyInventoryRepositoryImpl(this._service);

  @override
  Future<PropertyInventory> getById(String id) => _service.getPropertyInventoryById(id);

  @override
  Future<List<PropertyInventory>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPropertyInventories(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyInventory> create(PropertyInventory item) => _service.createPropertyInventory(item);

  @override
  Future<PropertyInventory> update(String id, PropertyInventory item) => _service.updatePropertyInventory(id, item);

  @override
  Future<void> delete(String id) => _service.deletePropertyInventory(id);
}
