import '../../features/shared/services/location_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Location

class GetLocationByIdUseCase {
  final LocationService _service;
  
  GetLocationByIdUseCase(this._service);
  
  Future<Location> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetLocationsUseCase {
  final LocationService _service;
  
  GetLocationsUseCase(this._service);
  
  Future<List<Location>> execute({
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

class CreateLocationUseCase {
  final LocationService _service;
  
  CreateLocationUseCase(this._service);
  
  Future<Location> execute(Location location) async {
    // Add validation logic here
    return await _service.create(location);
  }
}

class UpdateLocationUseCase {
  final LocationService _service;
  
  UpdateLocationUseCase(this._service);
  
  Future<Location> execute(String id, Location location) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, location);
  }
}

class DeleteLocationUseCase {
  final LocationService _service;
  
  DeleteLocationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Location Use Case Container
class LocationUseCases {
  final GetLocationByIdUseCase getById;
  final GetLocationsUseCase getAll;
  final CreateLocationUseCase create;
  final UpdateLocationUseCase update;
  final DeleteLocationUseCase delete;
  
  LocationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory LocationUseCases.create(LocationService service) {
    return LocationUseCases(
      getById: GetLocationByIdUseCase(service),
      getAll: GetLocationsUseCase(service),
      create: CreateLocationUseCase(service),
      update: UpdateLocationUseCase(service),
      delete: DeleteLocationUseCase(service),
    );
  }
}
