import '../../features/shared/services/agent_team_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AgentTeam

class GetAgentTeamByIdUseCase {
  final AgentTeamService _service;
  
  GetAgentTeamByIdUseCase(this._service);
  
  Future<AgentTeam> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAgentTeamsUseCase {
  final AgentTeamService _service;
  
  GetAgentTeamsUseCase(this._service);
  
  Future<List<AgentTeam>> execute({
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

class CreateAgentTeamUseCase {
  final AgentTeamService _service;
  
  CreateAgentTeamUseCase(this._service);
  
  Future<AgentTeam> execute(AgentTeam agentTeam) async {
    // Add validation logic here
    return await _service.create(agentTeam);
  }
}

class UpdateAgentTeamUseCase {
  final AgentTeamService _service;
  
  UpdateAgentTeamUseCase(this._service);
  
  Future<AgentTeam> execute(String id, AgentTeam agentTeam) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, agentTeam);
  }
}

class DeleteAgentTeamUseCase {
  final AgentTeamService _service;
  
  DeleteAgentTeamUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AgentTeam Use Case Container
class AgentTeamUseCases {
  final GetAgentTeamByIdUseCase getById;
  final GetAgentTeamsUseCase getAll;
  final CreateAgentTeamUseCase create;
  final UpdateAgentTeamUseCase update;
  final DeleteAgentTeamUseCase delete;
  
  AgentTeamUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AgentTeamUseCases.create(AgentTeamService service) {
    return AgentTeamUseCases(
      getById: GetAgentTeamByIdUseCase(service),
      getAll: GetAgentTeamsUseCase(service),
      create: CreateAgentTeamUseCase(service),
      update: UpdateAgentTeamUseCase(service),
      delete: DeleteAgentTeamUseCase(service),
    );
  }
}
