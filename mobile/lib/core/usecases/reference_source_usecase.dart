import '../../features/shared/services/reference_source_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ReferenceSource

class GetReferenceSourceByIdUseCase {
  final ReferenceSourceService _service;
  
  GetReferenceSourceByIdUseCase(this._service);
  
  Future<ReferenceSource> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetReferenceSourcesUseCase {
  final ReferenceSourceService _service;
  
  GetReferenceSourcesUseCase(this._service);
  
  Future<List<ReferenceSource>> execute({
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

class CreateReferenceSourceUseCase {
  final ReferenceSourceService _service;
  
  CreateReferenceSourceUseCase(this._service);
  
  Future<ReferenceSource> execute(ReferenceSource referenceSource) async {
    // Add validation logic here
    return await _service.create(referenceSource);
  }
}

class UpdateReferenceSourceUseCase {
  final ReferenceSourceService _service;
  
  UpdateReferenceSourceUseCase(this._service);
  
  Future<ReferenceSource> execute(String id, ReferenceSource referenceSource) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, referenceSource);
  }
}

class DeleteReferenceSourceUseCase {
  final ReferenceSourceService _service;
  
  DeleteReferenceSourceUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ReferenceSource Use Case Container
class ReferenceSourceUseCases {
  final GetReferenceSourceByIdUseCase getById;
  final GetReferenceSourcesUseCase getAll;
  final CreateReferenceSourceUseCase create;
  final UpdateReferenceSourceUseCase update;
  final DeleteReferenceSourceUseCase delete;
  
  ReferenceSourceUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ReferenceSourceUseCases.create(ReferenceSourceService service) {
    return ReferenceSourceUseCases(
      getById: GetReferenceSourceByIdUseCase(service),
      getAll: GetReferenceSourcesUseCase(service),
      create: CreateReferenceSourceUseCase(service),
      update: UpdateReferenceSourceUseCase(service),
      delete: DeleteReferenceSourceUseCase(service),
    );
  }
}
