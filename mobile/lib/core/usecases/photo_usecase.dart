import '../../features/shared/services/photo_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Photo

class GetPhotoByIdUseCase {
  final PhotoService _service;
  
  GetPhotoByIdUseCase(this._service);
  
  Future<Photo> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPhotosUseCase {
  final PhotoService _service;
  
  GetPhotosUseCase(this._service);
  
  Future<List<Photo>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreatePhotoUseCase {
  final PhotoService _service;
  
  CreatePhotoUseCase(this._service);
  
  Future<Photo> execute(Photo photo) async {
    // Add validation logic here
    return await _service.create(photo);
  }
}

class UpdatePhotoUseCase {
  final PhotoService _service;
  
  UpdatePhotoUseCase(this._service);
  
  Future<Photo> execute(String id, Photo photo) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, photo);
  }
}

class DeletePhotoUseCase {
  final PhotoService _service;
  
  DeletePhotoUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Photo Use Case Container
class PhotoUseCases {
  final GetPhotoByIdUseCase getById;
  final GetPhotosUseCase getAll;
  final CreatePhotoUseCase create;
  final UpdatePhotoUseCase update;
  final DeletePhotoUseCase delete;
  
  PhotoUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PhotoUseCases.create(PhotoService service) {
    return PhotoUseCases(
      getById: GetPhotoByIdUseCase(service),
      getAll: GetPhotosUseCase(service),
      create: CreatePhotoUseCase(service),
      update: UpdatePhotoUseCase(service),
      delete: DeletePhotoUseCase(service),
    );
  }
}
