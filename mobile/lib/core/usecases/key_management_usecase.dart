import '../../features/shared/services/key_management_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for KeyManagement

class GetKeyManagementByIdUseCase {
  final KeyManagementService _service;
  
  GetKeyManagementByIdUseCase(this._service);
  
  Future<KeyManagement> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetKeyManagementsUseCase {
  final KeyManagementService _service;
  
  GetKeyManagementsUseCase(this._service);
  
  Future<List<KeyManagement>> execute({
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

class CreateKeyManagementUseCase {
  final KeyManagementService _service;
  
  CreateKeyManagementUseCase(this._service);
  
  Future<KeyManagement> execute(KeyManagement keyManagement) async {
    // Add validation logic here
    return await _service.create(keyManagement);
  }
}

class UpdateKeyManagementUseCase {
  final KeyManagementService _service;
  
  UpdateKeyManagementUseCase(this._service);
  
  Future<KeyManagement> execute(String id, KeyManagement keyManagement) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, keyManagement);
  }
}

class DeleteKeyManagementUseCase {
  final KeyManagementService _service;
  
  DeleteKeyManagementUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// KeyManagement Use Case Container
class KeyManagementUseCases {
  final GetKeyManagementByIdUseCase getById;
  final GetKeyManagementsUseCase getAll;
  final CreateKeyManagementUseCase create;
  final UpdateKeyManagementUseCase update;
  final DeleteKeyManagementUseCase delete;
  
  KeyManagementUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory KeyManagementUseCases.create(KeyManagementService service) {
    return KeyManagementUseCases(
      getById: GetKeyManagementByIdUseCase(service),
      getAll: GetKeyManagementsUseCase(service),
      create: CreateKeyManagementUseCase(service),
      update: UpdateKeyManagementUseCase(service),
      delete: DeleteKeyManagementUseCase(service),
    );
  }
}
