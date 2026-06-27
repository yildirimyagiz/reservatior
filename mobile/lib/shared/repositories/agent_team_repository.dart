import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/agent_team_service.dart';

abstract class AgentTeamRepository {
  Future<AgentTeam> getById(String id);
  Future<List<AgentTeam>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AgentTeam> create(AgentTeam item);
  Future<AgentTeam> update(String id, AgentTeam item);
  Future<void> delete(String id);
  Future<List<Map<String, dynamic>>> getMembers(String id);
}

class AgentTeamRepositoryImpl implements AgentTeamRepository {
  final AgentTeamService _service;
  AgentTeamRepositoryImpl(this._service);

  @override
  Future<AgentTeam> getById(String id) => _service.getAgentTeamById(id);

  @override
  Future<List<AgentTeam>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAgentTeams(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AgentTeam> create(AgentTeam item) => _service.createAgentTeam(item);

  @override
  Future<AgentTeam> update(String id, AgentTeam item) => _service.updateAgentTeam(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAgentTeam(id);

  @override
  Future<List<Map<String, dynamic>>> getMembers(String id) => _service.getMembers(id);
}
