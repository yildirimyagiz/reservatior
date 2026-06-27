import 'package:reservatior/shared/repositories/ai_model_deployment_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiModelDeploymentByIdUseCase {
  final AiModelDeploymentRepository _repository;
  GetAiModelDeploymentByIdUseCase(this._repository);
  Future<AiModelDeployment> execute(String id) => _repository.getById(id);
}

class GetAiModelDeploymentsUseCase {
  final AiModelDeploymentRepository _repository;
  GetAiModelDeploymentsUseCase(this._repository);
  Future<List<AiModelDeployment>> execute({
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

class CreateAiModelDeploymentUseCase {
  final AiModelDeploymentRepository _repository;
  CreateAiModelDeploymentUseCase(this._repository);
  Future<AiModelDeployment> execute(AiModelDeployment item) => _repository.create(item);
}

class UpdateAiModelDeploymentUseCase {
  final AiModelDeploymentRepository _repository;
  UpdateAiModelDeploymentUseCase(this._repository);
  Future<AiModelDeployment> execute(String id, AiModelDeployment item) => _repository.update(id, item);
}

class DeleteAiModelDeploymentUseCase {
  final AiModelDeploymentRepository _repository;
  DeleteAiModelDeploymentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
