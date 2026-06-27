import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_photo_service.dart';

abstract class PropertyPhotoRepository {
  Future<PropertyPhoto> getById(String id);
  Future<List<PropertyPhoto>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PropertyPhoto> create(PropertyPhoto item);
  Future<PropertyPhoto> update(String id, PropertyPhoto item);
  Future<void> delete(String id);
}

class PropertyPhotoRepositoryImpl implements PropertyPhotoRepository {
  final PropertyPhotoService _service;
  PropertyPhotoRepositoryImpl(this._service);

  @override
  Future<PropertyPhoto> getById(String id) => _service.getPropertyPhotoById(id);

  @override
  Future<List<PropertyPhoto>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPropertyPhotos(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyPhoto> create(PropertyPhoto item) => _service.createPropertyPhoto(item);

  @override
  Future<PropertyPhoto> update(String id, PropertyPhoto item) => _service.updatePropertyPhoto(id, item);

  @override
  Future<void> delete(String id) => _service.deletePropertyPhoto(id);
}
