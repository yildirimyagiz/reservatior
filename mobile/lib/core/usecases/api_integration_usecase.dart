import 'package:reservatior/shared/repositories/api_integration_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAPIIntegrationByIdUseCase {
  final APIIntegrationRepository _repository;
  GetAPIIntegrationByIdUseCase(this._repository);
  Future<APIIntegration> execute(String id) => _repository.getById(id);
}

class GetAPIIntegrationsUseCase {
  final APIIntegrationRepository _repository;
  GetAPIIntegrationsUseCase(this._repository);
  Future<List<APIIntegration>> execute({
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

class CreateAPIIntegrationUseCase {
  final APIIntegrationRepository _repository;
  CreateAPIIntegrationUseCase(this._repository);
  Future<APIIntegration> execute(APIIntegration item) => _repository.create(item);
}

class UpdateAPIIntegrationUseCase {
  final APIIntegrationRepository _repository;
  UpdateAPIIntegrationUseCase(this._repository);
  Future<APIIntegration> execute(String id, APIIntegration item) => _repository.update(id, item);
}

class DeleteAPIIntegrationUseCase {
  final APIIntegrationRepository _repository;
  DeleteAPIIntegrationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
