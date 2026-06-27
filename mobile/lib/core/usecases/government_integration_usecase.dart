import 'package:reservatior/shared/repositories/government_integration_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetGovernmentIntegrationByIdUseCase {
  final GovernmentIntegrationRepository _repository;
  GetGovernmentIntegrationByIdUseCase(this._repository);
  Future<GovernmentIntegration> execute(String id) => _repository.getById(id);
}

class GetGovernmentIntegrationsUseCase {
  final GovernmentIntegrationRepository _repository;
  GetGovernmentIntegrationsUseCase(this._repository);
  Future<List<GovernmentIntegration>> execute({
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

class CreateGovernmentIntegrationUseCase {
  final GovernmentIntegrationRepository _repository;
  CreateGovernmentIntegrationUseCase(this._repository);
  Future<GovernmentIntegration> execute(GovernmentIntegration item) => _repository.create(item);
}

class UpdateGovernmentIntegrationUseCase {
  final GovernmentIntegrationRepository _repository;
  UpdateGovernmentIntegrationUseCase(this._repository);
  Future<GovernmentIntegration> execute(String id, GovernmentIntegration item) => _repository.update(id, item);
}

class DeleteGovernmentIntegrationUseCase {
  final GovernmentIntegrationRepository _repository;
  DeleteGovernmentIntegrationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
