import '../../features/shared/services/agent_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Agent

class GetAgentByIdUseCase {
  final AgentService _service;
  
  GetAgentByIdUseCase(this._service);
  
  Future<Agent> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAgentsUseCase {
  final AgentService _service;
  
  GetAgentsUseCase(this._service);
  
  Future<List<Agent>> execute({
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

class CreateAgentUseCase {
  final AgentService _service;
  
  CreateAgentUseCase(this._service);
  
  Future<Agent> execute(Agent agent) async {
    // Add validation logic here
    return await _service.create(agent);
  }
}

class UpdateAgentUseCase {
  final AgentService _service;
  
  UpdateAgentUseCase(this._service);
  
  Future<Agent> execute(String id, Agent agent) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, agent);
  }
}

class DeleteAgentUseCase {
  final AgentService _service;
  
  DeleteAgentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Agent Use Case Container
class AgentUseCases {
  final GetAgentByIdUseCase getById;
  final GetAgentsUseCase getAll;
  final CreateAgentUseCase create;
  final UpdateAgentUseCase update;
  final DeleteAgentUseCase delete;
  
  AgentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AgentUseCases.create(AgentService service) {
    return AgentUseCases(
      getById: GetAgentByIdUseCase(service),
      getAll: GetAgentsUseCase(service),
      create: CreateAgentUseCase(service),
      update: UpdateAgentUseCase(service),
      delete: DeleteAgentUseCase(service),
    );
  }
}
