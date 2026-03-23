import '../../features/shared/services/shared_amenity_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for SharedAmenity

class GetSharedAmenityByIdUseCase {
  final SharedAmenityService _service;
  
  GetSharedAmenityByIdUseCase(this._service);
  
  Future<SharedAmenity> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSharedAmenitysUseCase {
  final SharedAmenityService _service;
  
  GetSharedAmenitysUseCase(this._service);
  
  Future<List<SharedAmenity>> execute({
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

class CreateSharedAmenityUseCase {
  final SharedAmenityService _service;
  
  CreateSharedAmenityUseCase(this._service);
  
  Future<SharedAmenity> execute(SharedAmenity sharedAmenity) async {
    // Add validation logic here
    return await _service.create(sharedAmenity);
  }
}

class UpdateSharedAmenityUseCase {
  final SharedAmenityService _service;
  
  UpdateSharedAmenityUseCase(this._service);
  
  Future<SharedAmenity> execute(String id, SharedAmenity sharedAmenity) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, sharedAmenity);
  }
}

class DeleteSharedAmenityUseCase {
  final SharedAmenityService _service;
  
  DeleteSharedAmenityUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// SharedAmenity Use Case Container
class SharedAmenityUseCases {
  final GetSharedAmenityByIdUseCase getById;
  final GetSharedAmenitysUseCase getAll;
  final CreateSharedAmenityUseCase create;
  final UpdateSharedAmenityUseCase update;
  final DeleteSharedAmenityUseCase delete;
  
  SharedAmenityUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SharedAmenityUseCases.create(SharedAmenityService service) {
    return SharedAmenityUseCases(
      getById: GetSharedAmenityByIdUseCase(service),
      getAll: GetSharedAmenitysUseCase(service),
      create: CreateSharedAmenityUseCase(service),
      update: UpdateSharedAmenityUseCase(service),
      delete: DeleteSharedAmenityUseCase(service),
    );
  }
}
