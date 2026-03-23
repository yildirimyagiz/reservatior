import '../../features/shared/services/facility_block_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for FacilityBlock

class GetFacilityBlockByIdUseCase {
  final FacilityBlockService _service;
  
  GetFacilityBlockByIdUseCase(this._service);
  
  Future<FacilityBlock> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetFacilityBlocksUseCase {
  final FacilityBlockService _service;
  
  GetFacilityBlocksUseCase(this._service);
  
  Future<List<FacilityBlock>> execute({
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

class CreateFacilityBlockUseCase {
  final FacilityBlockService _service;
  
  CreateFacilityBlockUseCase(this._service);
  
  Future<FacilityBlock> execute(FacilityBlock facilityBlock) async {
    // Add validation logic here
    return await _service.create(facilityBlock);
  }
}

class UpdateFacilityBlockUseCase {
  final FacilityBlockService _service;
  
  UpdateFacilityBlockUseCase(this._service);
  
  Future<FacilityBlock> execute(String id, FacilityBlock facilityBlock) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, facilityBlock);
  }
}

class DeleteFacilityBlockUseCase {
  final FacilityBlockService _service;
  
  DeleteFacilityBlockUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// FacilityBlock Use Case Container
class FacilityBlockUseCases {
  final GetFacilityBlockByIdUseCase getById;
  final GetFacilityBlocksUseCase getAll;
  final CreateFacilityBlockUseCase create;
  final UpdateFacilityBlockUseCase update;
  final DeleteFacilityBlockUseCase delete;
  
  FacilityBlockUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory FacilityBlockUseCases.create(FacilityBlockService service) {
    return FacilityBlockUseCases(
      getById: GetFacilityBlockByIdUseCase(service),
      getAll: GetFacilityBlocksUseCase(service),
      create: CreateFacilityBlockUseCase(service),
      update: UpdateFacilityBlockUseCase(service),
      delete: DeleteFacilityBlockUseCase(service),
    );
  }
}
