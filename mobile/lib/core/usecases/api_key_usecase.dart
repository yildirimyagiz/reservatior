import 'package:reservatior/shared/repositories/api_key_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetApiKeyByIdUseCase {
  final ApiKeyRepository _repository;
  GetApiKeyByIdUseCase(this._repository);
  Future<ApiKey> execute(String id) => _repository.getById(id);
}

class GetApiKeysUseCase {
  final ApiKeyRepository _repository;
  GetApiKeysUseCase(this._repository);
  Future<List<ApiKey>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateApiKeyUseCase {
  final ApiKeyRepository _repository;
  CreateApiKeyUseCase(this._repository);
  Future<ApiKey> execute(ApiKey item) => _repository.create(item);
}

class UpdateApiKeyUseCase {
  final ApiKeyRepository _repository;
  UpdateApiKeyUseCase(this._repository);
  Future<ApiKey> execute(String id, ApiKey item) => _repository.update(id, item);
}

class DeleteApiKeyUseCase {
  final ApiKeyRepository _repository;
  DeleteApiKeyUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
