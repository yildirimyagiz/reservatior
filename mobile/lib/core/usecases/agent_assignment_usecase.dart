import '../../features/shared/services/agent_assignment_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AgentAssignment

class GetAgentAssignmentByIdUseCase {
  final AgentAssignmentService _service;
  
  GetAgentAssignmentByIdUseCase(this._service);
  
  Future<AgentAssignment> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAgentAssignmentsUseCase {
  final AgentAssignmentService _service;
  
  GetAgentAssignmentsUseCase(this._service);
  
  Future<List<AgentAssignment>> execute({
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

class CreateAgentAssignmentUseCase {
  final AgentAssignmentService _service;
  
  CreateAgentAssignmentUseCase(this._service);
  
  Future<AgentAssignment> execute(AgentAssignment agentAssignment) async {
    // Add validation logic here
    return await _service.create(agentAssignment);
  }
}

class UpdateAgentAssignmentUseCase {
  final AgentAssignmentService _service;
  
  UpdateAgentAssignmentUseCase(this._service);
  
  Future<AgentAssignment> execute(String id, AgentAssignment agentAssignment) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, agentAssignment);
  }
}

class DeleteAgentAssignmentUseCase {
  final AgentAssignmentService _service;
  
  DeleteAgentAssignmentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AgentAssignment Use Case Container
class AgentAssignmentUseCases {
  final GetAgentAssignmentByIdUseCase getById;
  final GetAgentAssignmentsUseCase getAll;
  final CreateAgentAssignmentUseCase create;
  final UpdateAgentAssignmentUseCase update;
  final DeleteAgentAssignmentUseCase delete;
  
  AgentAssignmentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AgentAssignmentUseCases.create(AgentAssignmentService service) {
    return AgentAssignmentUseCases(
      getById: GetAgentAssignmentByIdUseCase(service),
      getAll: GetAgentAssignmentsUseCase(service),
      create: CreateAgentAssignmentUseCase(service),
      update: UpdateAgentAssignmentUseCase(service),
      delete: DeleteAgentAssignmentUseCase(service),
    );
  }
}
