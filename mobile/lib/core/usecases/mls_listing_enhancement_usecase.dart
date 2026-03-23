import '../../features/shared/services/mls_listing_enhancement_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MlsListingEnhancement

class GetMlsListingEnhancementByIdUseCase {
  final MlsListingEnhancementService _service;
  
  GetMlsListingEnhancementByIdUseCase(this._service);
  
  Future<MlsListingEnhancement> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMlsListingEnhancementsUseCase {
  final MlsListingEnhancementService _service;
  
  GetMlsListingEnhancementsUseCase(this._service);
  
  Future<List<MlsListingEnhancement>> execute({
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

class CreateMlsListingEnhancementUseCase {
  final MlsListingEnhancementService _service;
  
  CreateMlsListingEnhancementUseCase(this._service);
  
  Future<MlsListingEnhancement> execute(MlsListingEnhancement mlsListingEnhancement) async {
    // Add validation logic here
    return await _service.create(mlsListingEnhancement);
  }
}

class UpdateMlsListingEnhancementUseCase {
  final MlsListingEnhancementService _service;
  
  UpdateMlsListingEnhancementUseCase(this._service);
  
  Future<MlsListingEnhancement> execute(String id, MlsListingEnhancement mlsListingEnhancement) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mlsListingEnhancement);
  }
}

class DeleteMlsListingEnhancementUseCase {
  final MlsListingEnhancementService _service;
  
  DeleteMlsListingEnhancementUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MlsListingEnhancement Use Case Container
class MlsListingEnhancementUseCases {
  final GetMlsListingEnhancementByIdUseCase getById;
  final GetMlsListingEnhancementsUseCase getAll;
  final CreateMlsListingEnhancementUseCase create;
  final UpdateMlsListingEnhancementUseCase update;
  final DeleteMlsListingEnhancementUseCase delete;
  
  MlsListingEnhancementUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MlsListingEnhancementUseCases.create(MlsListingEnhancementService service) {
    return MlsListingEnhancementUseCases(
      getById: GetMlsListingEnhancementByIdUseCase(service),
      getAll: GetMlsListingEnhancementsUseCase(service),
      create: CreateMlsListingEnhancementUseCase(service),
      update: UpdateMlsListingEnhancementUseCase(service),
      delete: DeleteMlsListingEnhancementUseCase(service),
    );
  }
}
