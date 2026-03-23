import '../../features/shared/services/agent_performance_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AgentPerformance

class GetAgentPerformanceByIdUseCase {
  final AgentPerformanceService _service;
  
  GetAgentPerformanceByIdUseCase(this._service);
  
  Future<AgentPerformance> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAgentPerformancesUseCase {
  final AgentPerformanceService _service;
  
  GetAgentPerformancesUseCase(this._service);
  
  Future<List<AgentPerformance>> execute({
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

class CreateAgentPerformanceUseCase {
  final AgentPerformanceService _service;
  
  CreateAgentPerformanceUseCase(this._service);
  
  Future<AgentPerformance> execute(AgentPerformance agentPerformance) async {
    // Add validation logic here
    return await _service.create(agentPerformance);
  }
}

class UpdateAgentPerformanceUseCase {
  final AgentPerformanceService _service;
  
  UpdateAgentPerformanceUseCase(this._service);
  
  Future<AgentPerformance> execute(String id, AgentPerformance agentPerformance) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, agentPerformance);
  }
}

class DeleteAgentPerformanceUseCase {
  final AgentPerformanceService _service;
  
  DeleteAgentPerformanceUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AgentPerformance Use Case Container
class AgentPerformanceUseCases {
  final GetAgentPerformanceByIdUseCase getById;
  final GetAgentPerformancesUseCase getAll;
  final CreateAgentPerformanceUseCase create;
  final UpdateAgentPerformanceUseCase update;
  final DeleteAgentPerformanceUseCase delete;
  
  AgentPerformanceUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AgentPerformanceUseCases.create(AgentPerformanceService service) {
    return AgentPerformanceUseCases(
      getById: GetAgentPerformanceByIdUseCase(service),
      getAll: GetAgentPerformancesUseCase(service),
      create: CreateAgentPerformanceUseCase(service),
      update: UpdateAgentPerformanceUseCase(service),
      delete: DeleteAgentPerformanceUseCase(service),
    );
  }
}
