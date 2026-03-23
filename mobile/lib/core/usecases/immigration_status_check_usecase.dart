import '../../features/shared/services/immigration_status_check_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ImmigrationStatusCheck

class GetImmigrationStatusCheckByIdUseCase {
  final ImmigrationStatusCheckService _service;
  
  GetImmigrationStatusCheckByIdUseCase(this._service);
  
  Future<ImmigrationStatusCheck> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetImmigrationStatusChecksUseCase {
  final ImmigrationStatusCheckService _service;
  
  GetImmigrationStatusChecksUseCase(this._service);
  
  Future<List<ImmigrationStatusCheck>> execute({
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

class CreateImmigrationStatusCheckUseCase {
  final ImmigrationStatusCheckService _service;
  
  CreateImmigrationStatusCheckUseCase(this._service);
  
  Future<ImmigrationStatusCheck> execute(ImmigrationStatusCheck immigrationStatusCheck) async {
    // Add validation logic here
    return await _service.create(immigrationStatusCheck);
  }
}

class UpdateImmigrationStatusCheckUseCase {
  final ImmigrationStatusCheckService _service;
  
  UpdateImmigrationStatusCheckUseCase(this._service);
  
  Future<ImmigrationStatusCheck> execute(String id, ImmigrationStatusCheck immigrationStatusCheck) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, immigrationStatusCheck);
  }
}

class DeleteImmigrationStatusCheckUseCase {
  final ImmigrationStatusCheckService _service;
  
  DeleteImmigrationStatusCheckUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ImmigrationStatusCheck Use Case Container
class ImmigrationStatusCheckUseCases {
  final GetImmigrationStatusCheckByIdUseCase getById;
  final GetImmigrationStatusChecksUseCase getAll;
  final CreateImmigrationStatusCheckUseCase create;
  final UpdateImmigrationStatusCheckUseCase update;
  final DeleteImmigrationStatusCheckUseCase delete;
  
  ImmigrationStatusCheckUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ImmigrationStatusCheckUseCases.create(ImmigrationStatusCheckService service) {
    return ImmigrationStatusCheckUseCases(
      getById: GetImmigrationStatusCheckByIdUseCase(service),
      getAll: GetImmigrationStatusChecksUseCase(service),
      create: CreateImmigrationStatusCheckUseCase(service),
      update: UpdateImmigrationStatusCheckUseCase(service),
      delete: DeleteImmigrationStatusCheckUseCase(service),
    );
  }
}
