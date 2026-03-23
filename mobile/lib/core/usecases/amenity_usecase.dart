import '../../features/shared/services/amenity_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Amenity

class GetAmenityByIdUseCase {
  final AmenityService _service;
  
  GetAmenityByIdUseCase(this._service);
  
  Future<Amenity> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAmenitysUseCase {
  final AmenityService _service;
  
  GetAmenitysUseCase(this._service);
  
  Future<List<Amenity>> execute({
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

class CreateAmenityUseCase {
  final AmenityService _service;
  
  CreateAmenityUseCase(this._service);
  
  Future<Amenity> execute(Amenity amenity) async {
    // Add validation logic here
    return await _service.create(amenity);
  }
}

class UpdateAmenityUseCase {
  final AmenityService _service;
  
  UpdateAmenityUseCase(this._service);
  
  Future<Amenity> execute(String id, Amenity amenity) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, amenity);
  }
}

class DeleteAmenityUseCase {
  final AmenityService _service;
  
  DeleteAmenityUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Amenity Use Case Container
class AmenityUseCases {
  final GetAmenityByIdUseCase getById;
  final GetAmenitysUseCase getAll;
  final CreateAmenityUseCase create;
  final UpdateAmenityUseCase update;
  final DeleteAmenityUseCase delete;
  
  AmenityUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AmenityUseCases.create(AmenityService service) {
    return AmenityUseCases(
      getById: GetAmenityByIdUseCase(service),
      getAll: GetAmenitysUseCase(service),
      create: CreateAmenityUseCase(service),
      update: UpdateAmenityUseCase(service),
      delete: DeleteAmenityUseCase(service),
    );
  }
}
