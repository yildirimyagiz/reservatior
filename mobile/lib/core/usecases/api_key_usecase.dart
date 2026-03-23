import '../../features/shared/services/api_key_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ApiKey

class GetApiKeyByIdUseCase {
  final ApiKeyService _service;
  
  GetApiKeyByIdUseCase(this._service);
  
  Future<ApiKey> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetApiKeysUseCase {
  final ApiKeyService _service;
  
  GetApiKeysUseCase(this._service);
  
  Future<List<ApiKey>> execute({
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

class CreateApiKeyUseCase {
  final ApiKeyService _service;
  
  CreateApiKeyUseCase(this._service);
  
  Future<ApiKey> execute(ApiKey apiKey) async {
    // Add validation logic here
    return await _service.create(apiKey);
  }
}

class UpdateApiKeyUseCase {
  final ApiKeyService _service;
  
  UpdateApiKeyUseCase(this._service);
  
  Future<ApiKey> execute(String id, ApiKey apiKey) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, apiKey);
  }
}

class DeleteApiKeyUseCase {
  final ApiKeyService _service;
  
  DeleteApiKeyUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ApiKey Use Case Container
class ApiKeyUseCases {
  final GetApiKeyByIdUseCase getById;
  final GetApiKeysUseCase getAll;
  final CreateApiKeyUseCase create;
  final UpdateApiKeyUseCase update;
  final DeleteApiKeyUseCase delete;
  
  ApiKeyUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ApiKeyUseCases.create(ApiKeyService service) {
    return ApiKeyUseCases(
      getById: GetApiKeyByIdUseCase(service),
      getAll: GetApiKeysUseCase(service),
      create: CreateApiKeyUseCase(service),
      update: UpdateApiKeyUseCase(service),
      delete: DeleteApiKeyUseCase(service),
    );
  }
}
