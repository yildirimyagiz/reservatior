import 'package:reservatior/shared/repositories/agent_team_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAgentTeamByIdUseCase {
  final AgentTeamRepository _repository;
  GetAgentTeamByIdUseCase(this._repository);
  Future<AgentTeam> execute(String id) => _repository.getById(id);
}

class GetAgentTeamsUseCase {
  final AgentTeamRepository _repository;
  GetAgentTeamsUseCase(this._repository);
  Future<List<AgentTeam>> execute({
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

class CreateAgentTeamUseCase {
  final AgentTeamRepository _repository;
  CreateAgentTeamUseCase(this._repository);
  Future<AgentTeam> execute(AgentTeam item) => _repository.create(item);
}

class UpdateAgentTeamUseCase {
  final AgentTeamRepository _repository;
  UpdateAgentTeamUseCase(this._repository);
  Future<AgentTeam> execute(String id, AgentTeam item) => _repository.update(id, item);
}

class DeleteAgentTeamUseCase {
  final AgentTeamRepository _repository;
  DeleteAgentTeamUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
