import '../../features/shared/services/ai_model_deployment_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AIModelDeployment

class GetAIModelDeploymentByIdUseCase {
  final AIModelDeploymentService _service;
  
  GetAIModelDeploymentByIdUseCase(this._service);
  
  Future<AIModelDeployment> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAIModelDeploymentsUseCase {
  final AIModelDeploymentService _service;
  
  GetAIModelDeploymentsUseCase(this._service);
  
  Future<List<AIModelDeployment>> execute({
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

class CreateAIModelDeploymentUseCase {
  final AIModelDeploymentService _service;
  
  CreateAIModelDeploymentUseCase(this._service);
  
  Future<AIModelDeployment> execute(AIModelDeployment aIModelDeployment) async {
    // Add validation logic here
    return await _service.create(aIModelDeployment);
  }
}

class UpdateAIModelDeploymentUseCase {
  final AIModelDeploymentService _service;
  
  UpdateAIModelDeploymentUseCase(this._service);
  
  Future<AIModelDeployment> execute(String id, AIModelDeployment aIModelDeployment) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aIModelDeployment);
  }
}

class DeleteAIModelDeploymentUseCase {
  final AIModelDeploymentService _service;
  
  DeleteAIModelDeploymentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AIModelDeployment Use Case Container
class AIModelDeploymentUseCases {
  final GetAIModelDeploymentByIdUseCase getById;
  final GetAIModelDeploymentsUseCase getAll;
  final CreateAIModelDeploymentUseCase create;
  final UpdateAIModelDeploymentUseCase update;
  final DeleteAIModelDeploymentUseCase delete;
  
  AIModelDeploymentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AIModelDeploymentUseCases.create(AIModelDeploymentService service) {
    return AIModelDeploymentUseCases(
      getById: GetAIModelDeploymentByIdUseCase(service),
      getAll: GetAIModelDeploymentsUseCase(service),
      create: CreateAIModelDeploymentUseCase(service),
      update: UpdateAIModelDeploymentUseCase(service),
      delete: DeleteAIModelDeploymentUseCase(service),
    );
  }
}
