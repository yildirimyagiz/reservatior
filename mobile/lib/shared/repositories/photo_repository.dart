import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/photo_service.dart';

abstract class PhotoRepository {
  Future<Photo> getById(String id);
  Future<List<Photo>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Photo> create(Photo item);
  Future<Photo> update(String id, Photo item);
  Future<void> delete(String id);
}

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoService _service;
  PhotoRepositoryImpl(this._service);

  @override
  Future<Photo> getById(String id) => _service.getPhotoById(id);

  @override
  Future<List<Photo>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPhotos(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Photo> create(Photo item) => _service.createPhoto(item);

  @override
  Future<Photo> update(String id, Photo item) => _service.updatePhoto(id, item);

  @override
  Future<void> delete(String id) => _service.deletePhoto(id);
}
