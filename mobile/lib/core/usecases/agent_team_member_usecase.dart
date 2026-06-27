import 'package:reservatior/shared/repositories/agent_team_member_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAgentTeamMemberByIdUseCase {
  final AgentTeamMemberRepository _repository;
  GetAgentTeamMemberByIdUseCase(this._repository);
  Future<AgentTeamMember> execute(String id) => _repository.getById(id);
}

class GetAgentTeamMembersUseCase {
  final AgentTeamMemberRepository _repository;
  GetAgentTeamMembersUseCase(this._repository);
  Future<List<AgentTeamMember>> execute({
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

class CreateAgentTeamMemberUseCase {
  final AgentTeamMemberRepository _repository;
  CreateAgentTeamMemberUseCase(this._repository);
  Future<AgentTeamMember> execute(AgentTeamMember item) => _repository.create(item);
}

class UpdateAgentTeamMemberUseCase {
  final AgentTeamMemberRepository _repository;
  UpdateAgentTeamMemberUseCase(this._repository);
  Future<AgentTeamMember> execute(String id, AgentTeamMember item) => _repository.update(id, item);
}

class DeleteAgentTeamMemberUseCase {
  final AgentTeamMemberRepository _repository;
  DeleteAgentTeamMemberUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
