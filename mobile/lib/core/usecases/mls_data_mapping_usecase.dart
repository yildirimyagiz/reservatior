import '../../features/shared/services/mls_data_mapping_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MlsDataMapping

class GetMlsDataMappingByIdUseCase {
  final MlsDataMappingService _service;
  
  GetMlsDataMappingByIdUseCase(this._service);
  
  Future<MlsDataMapping> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMlsDataMappingsUseCase {
  final MlsDataMappingService _service;
  
  GetMlsDataMappingsUseCase(this._service);
  
  Future<List<MlsDataMapping>> execute({
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

class CreateMlsDataMappingUseCase {
  final MlsDataMappingService _service;
  
  CreateMlsDataMappingUseCase(this._service);
  
  Future<MlsDataMapping> execute(MlsDataMapping mlsDataMapping) async {
    // Add validation logic here
    return await _service.create(mlsDataMapping);
  }
}

class UpdateMlsDataMappingUseCase {
  final MlsDataMappingService _service;
  
  UpdateMlsDataMappingUseCase(this._service);
  
  Future<MlsDataMapping> execute(String id, MlsDataMapping mlsDataMapping) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mlsDataMapping);
  }
}

class DeleteMlsDataMappingUseCase {
  final MlsDataMappingService _service;
  
  DeleteMlsDataMappingUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MlsDataMapping Use Case Container
class MlsDataMappingUseCases {
  final GetMlsDataMappingByIdUseCase getById;
  final GetMlsDataMappingsUseCase getAll;
  final CreateMlsDataMappingUseCase create;
  final UpdateMlsDataMappingUseCase update;
  final DeleteMlsDataMappingUseCase delete;
  
  MlsDataMappingUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MlsDataMappingUseCases.create(MlsDataMappingService service) {
    return MlsDataMappingUseCases(
      getById: GetMlsDataMappingByIdUseCase(service),
      getAll: GetMlsDataMappingsUseCase(service),
      create: CreateMlsDataMappingUseCase(service),
      update: UpdateMlsDataMappingUseCase(service),
      delete: DeleteMlsDataMappingUseCase(service),
    );
  }
}
