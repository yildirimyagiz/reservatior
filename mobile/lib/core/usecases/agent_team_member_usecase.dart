import '../../features/shared/services/agent_team_member_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AgentTeamMember

class GetAgentTeamMemberByIdUseCase {
  final AgentTeamMemberService _service;
  
  GetAgentTeamMemberByIdUseCase(this._service);
  
  Future<AgentTeamMember> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAgentTeamMembersUseCase {
  final AgentTeamMemberService _service;
  
  GetAgentTeamMembersUseCase(this._service);
  
  Future<List<AgentTeamMember>> execute({
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

class CreateAgentTeamMemberUseCase {
  final AgentTeamMemberService _service;
  
  CreateAgentTeamMemberUseCase(this._service);
  
  Future<AgentTeamMember> execute(AgentTeamMember agentTeamMember) async {
    // Add validation logic here
    return await _service.create(agentTeamMember);
  }
}

class UpdateAgentTeamMemberUseCase {
  final AgentTeamMemberService _service;
  
  UpdateAgentTeamMemberUseCase(this._service);
  
  Future<AgentTeamMember> execute(String id, AgentTeamMember agentTeamMember) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, agentTeamMember);
  }
}

class DeleteAgentTeamMemberUseCase {
  final AgentTeamMemberService _service;
  
  DeleteAgentTeamMemberUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AgentTeamMember Use Case Container
class AgentTeamMemberUseCases {
  final GetAgentTeamMemberByIdUseCase getById;
  final GetAgentTeamMembersUseCase getAll;
  final CreateAgentTeamMemberUseCase create;
  final UpdateAgentTeamMemberUseCase update;
  final DeleteAgentTeamMemberUseCase delete;
  
  AgentTeamMemberUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AgentTeamMemberUseCases.create(AgentTeamMemberService service) {
    return AgentTeamMemberUseCases(
      getById: GetAgentTeamMemberByIdUseCase(service),
      getAll: GetAgentTeamMembersUseCase(service),
      create: CreateAgentTeamMemberUseCase(service),
      update: UpdateAgentTeamMemberUseCase(service),
      delete: DeleteAgentTeamMemberUseCase(service),
    );
  }
}
