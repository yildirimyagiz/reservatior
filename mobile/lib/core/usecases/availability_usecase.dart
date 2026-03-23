import '../../features/shared/services/availability_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Availability

class GetAvailabilityByIdUseCase {
  final AvailabilityService _service;
  
  GetAvailabilityByIdUseCase(this._service);
  
  Future<Availability> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAvailabilitysUseCase {
  final AvailabilityService _service;
  
  GetAvailabilitysUseCase(this._service);
  
  Future<List<Availability>> execute({
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

class CreateAvailabilityUseCase {
  final AvailabilityService _service;
  
  CreateAvailabilityUseCase(this._service);
  
  Future<Availability> execute(Availability availability) async {
    // Add validation logic here
    return await _service.create(availability);
  }
}

class UpdateAvailabilityUseCase {
  final AvailabilityService _service;
  
  UpdateAvailabilityUseCase(this._service);
  
  Future<Availability> execute(String id, Availability availability) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, availability);
  }
}

class DeleteAvailabilityUseCase {
  final AvailabilityService _service;
  
  DeleteAvailabilityUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Availability Use Case Container
class AvailabilityUseCases {
  final GetAvailabilityByIdUseCase getById;
  final GetAvailabilitysUseCase getAll;
  final CreateAvailabilityUseCase create;
  final UpdateAvailabilityUseCase update;
  final DeleteAvailabilityUseCase delete;
  
  AvailabilityUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AvailabilityUseCases.create(AvailabilityService service) {
    return AvailabilityUseCases(
      getById: GetAvailabilityByIdUseCase(service),
      getAll: GetAvailabilitysUseCase(service),
      create: CreateAvailabilityUseCase(service),
      update: UpdateAvailabilityUseCase(service),
      delete: DeleteAvailabilityUseCase(service),
    );
  }
}
