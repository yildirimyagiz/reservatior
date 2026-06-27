import 'package:reservatior/shared/repositories/property_photo_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyPhotoByIdUseCase {
  final PropertyPhotoRepository _repository;
  GetPropertyPhotoByIdUseCase(this._repository);
  Future<PropertyPhoto> execute(String id) => _repository.getById(id);
}

class GetPropertyPhotosUseCase {
  final PropertyPhotoRepository _repository;
  GetPropertyPhotosUseCase(this._repository);
  Future<List<PropertyPhoto>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreatePropertyPhotoUseCase {
  final PropertyPhotoRepository _repository;
  CreatePropertyPhotoUseCase(this._repository);
  Future<PropertyPhoto> execute(PropertyPhoto item) => _repository.create(item);
}

class UpdatePropertyPhotoUseCase {
  final PropertyPhotoRepository _repository;
  UpdatePropertyPhotoUseCase(this._repository);
  Future<PropertyPhoto> execute(String id, PropertyPhoto item) => _repository.update(id, item);
}

class DeletePropertyPhotoUseCase {
  final PropertyPhotoRepository _repository;
  DeletePropertyPhotoUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
