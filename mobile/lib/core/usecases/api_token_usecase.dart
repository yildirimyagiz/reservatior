import '../../features/shared/services/api_token_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ApiToken

class GetApiTokenByIdUseCase {
  final ApiTokenService _service;
  
  GetApiTokenByIdUseCase(this._service);
  
  Future<ApiToken> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetApiTokensUseCase {
  final ApiTokenService _service;
  
  GetApiTokensUseCase(this._service);
  
  Future<List<ApiToken>> execute({
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

class CreateApiTokenUseCase {
  final ApiTokenService _service;
  
  CreateApiTokenUseCase(this._service);
  
  Future<ApiToken> execute(ApiToken apiToken) async {
    // Add validation logic here
    return await _service.create(apiToken);
  }
}

class UpdateApiTokenUseCase {
  final ApiTokenService _service;
  
  UpdateApiTokenUseCase(this._service);
  
  Future<ApiToken> execute(String id, ApiToken apiToken) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, apiToken);
  }
}

class DeleteApiTokenUseCase {
  final ApiTokenService _service;
  
  DeleteApiTokenUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ApiToken Use Case Container
class ApiTokenUseCases {
  final GetApiTokenByIdUseCase getById;
  final GetApiTokensUseCase getAll;
  final CreateApiTokenUseCase create;
  final UpdateApiTokenUseCase update;
  final DeleteApiTokenUseCase delete;
  
  ApiTokenUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ApiTokenUseCases.create(ApiTokenService service) {
    return ApiTokenUseCases(
      getById: GetApiTokenByIdUseCase(service),
      getAll: GetApiTokensUseCase(service),
      create: CreateApiTokenUseCase(service),
      update: UpdateApiTokenUseCase(service),
      delete: DeleteApiTokenUseCase(service),
    );
  }
}
