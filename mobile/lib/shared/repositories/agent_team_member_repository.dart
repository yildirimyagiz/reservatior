import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/agent_team_member_service.dart';

abstract class AgentTeamMemberRepository {
  Future<AgentTeamMember> getById(String id);
  Future<List<AgentTeamMember>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AgentTeamMember> create(AgentTeamMember item);
  Future<AgentTeamMember> update(String id, AgentTeamMember item);
  Future<void> delete(String id);
}

class AgentTeamMemberRepositoryImpl implements AgentTeamMemberRepository {
  final AgentTeamMemberService _service;
  AgentTeamMemberRepositoryImpl(this._service);

  @override
  Future<AgentTeamMember> getById(String id) => _service.getAgentTeamMemberById(id);

  @override
  Future<List<AgentTeamMember>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAgentTeamMembers(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AgentTeamMember> create(AgentTeamMember item) => _service.createAgentTeamMember(item);

  @override
  Future<AgentTeamMember> update(String id, AgentTeamMember item) => _service.updateAgentTeamMember(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAgentTeamMember(id);
}
