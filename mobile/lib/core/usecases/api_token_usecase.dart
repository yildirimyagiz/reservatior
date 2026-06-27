import 'package:reservatior/shared/repositories/api_token_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetApiTokenByIdUseCase {
  final ApiTokenRepository _repository;
  GetApiTokenByIdUseCase(this._repository);
  Future<ApiToken> execute(String id) => _repository.getById(id);
}

class GetApiTokensUseCase {
  final ApiTokenRepository _repository;
  GetApiTokensUseCase(this._repository);
  Future<List<ApiToken>> execute({
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

class CreateApiTokenUseCase {
  final ApiTokenRepository _repository;
  CreateApiTokenUseCase(this._repository);
  Future<ApiToken> execute(ApiToken item) => _repository.create(item);
}

class UpdateApiTokenUseCase {
  final ApiTokenRepository _repository;
  UpdateApiTokenUseCase(this._repository);
  Future<ApiToken> execute(String id, ApiToken item) => _repository.update(id, item);
}

class DeleteApiTokenUseCase {
  final ApiTokenRepository _repository;
  DeleteApiTokenUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
