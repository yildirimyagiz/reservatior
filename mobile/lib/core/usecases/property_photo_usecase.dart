import '../../features/shared/services/property_photo_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyPhoto

class GetPropertyPhotoByIdUseCase {
  final PropertyPhotoService _service;
  
  GetPropertyPhotoByIdUseCase(this._service);
  
  Future<PropertyPhoto> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyPhotosUseCase {
  final PropertyPhotoService _service;
  
  GetPropertyPhotosUseCase(this._service);
  
  Future<List<PropertyPhoto>> execute({
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

class CreatePropertyPhotoUseCase {
  final PropertyPhotoService _service;
  
  CreatePropertyPhotoUseCase(this._service);
  
  Future<PropertyPhoto> execute(PropertyPhoto propertyPhoto) async {
    // Add validation logic here
    return await _service.create(propertyPhoto);
  }
}

class UpdatePropertyPhotoUseCase {
  final PropertyPhotoService _service;
  
  UpdatePropertyPhotoUseCase(this._service);
  
  Future<PropertyPhoto> execute(String id, PropertyPhoto propertyPhoto) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyPhoto);
  }
}

class DeletePropertyPhotoUseCase {
  final PropertyPhotoService _service;
  
  DeletePropertyPhotoUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyPhoto Use Case Container
class PropertyPhotoUseCases {
  final GetPropertyPhotoByIdUseCase getById;
  final GetPropertyPhotosUseCase getAll;
  final CreatePropertyPhotoUseCase create;
  final UpdatePropertyPhotoUseCase update;
  final DeletePropertyPhotoUseCase delete;
  
  PropertyPhotoUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyPhotoUseCases.create(PropertyPhotoService service) {
    return PropertyPhotoUseCases(
      getById: GetPropertyPhotoByIdUseCase(service),
      getAll: GetPropertyPhotosUseCase(service),
      create: CreatePropertyPhotoUseCase(service),
      update: UpdatePropertyPhotoUseCase(service),
      delete: DeletePropertyPhotoUseCase(service),
    );
  }
}
