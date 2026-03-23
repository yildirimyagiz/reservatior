import '../../features/shared/services/facility_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Facility

class GetFacilityByIdUseCase {
  final FacilityService _service;
  
  GetFacilityByIdUseCase(this._service);
  
  Future<Facility> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetFacilitysUseCase {
  final FacilityService _service;
  
  GetFacilitysUseCase(this._service);
  
  Future<List<Facility>> execute({
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

class CreateFacilityUseCase {
  final FacilityService _service;
  
  CreateFacilityUseCase(this._service);
  
  Future<Facility> execute(Facility facility) async {
    // Add validation logic here
    return await _service.create(facility);
  }
}

class UpdateFacilityUseCase {
  final FacilityService _service;
  
  UpdateFacilityUseCase(this._service);
  
  Future<Facility> execute(String id, Facility facility) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, facility);
  }
}

class DeleteFacilityUseCase {
  final FacilityService _service;
  
  DeleteFacilityUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Facility Use Case Container
class FacilityUseCases {
  final GetFacilityByIdUseCase getById;
  final GetFacilitysUseCase getAll;
  final CreateFacilityUseCase create;
  final UpdateFacilityUseCase update;
  final DeleteFacilityUseCase delete;
  
  FacilityUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory FacilityUseCases.create(FacilityService service) {
    return FacilityUseCases(
      getById: GetFacilityByIdUseCase(service),
      getAll: GetFacilitysUseCase(service),
      create: CreateFacilityUseCase(service),
      update: UpdateFacilityUseCase(service),
      delete: DeleteFacilityUseCase(service),
    );
  }
}
