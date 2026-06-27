import 'package:reservatior/shared/repositories/photo_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPhotoByIdUseCase {
  final PhotoRepository _repository;
  GetPhotoByIdUseCase(this._repository);
  Future<Photo> execute(String id) => _repository.getById(id);
}

class GetPhotosUseCase {
  final PhotoRepository _repository;
  GetPhotosUseCase(this._repository);
  Future<List<Photo>> execute({
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

class CreatePhotoUseCase {
  final PhotoRepository _repository;
  CreatePhotoUseCase(this._repository);
  Future<Photo> execute(Photo item) => _repository.create(item);
}

class UpdatePhotoUseCase {
  final PhotoRepository _repository;
  UpdatePhotoUseCase(this._repository);
  Future<Photo> execute(String id, Photo item) => _repository.update(id, item);
}

class DeletePhotoUseCase {
  final PhotoRepository _repository;
  DeletePhotoUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
