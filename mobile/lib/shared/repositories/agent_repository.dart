import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/agent_service.dart';

abstract class AgentRepository {
  Future<Agent> getById(String id);
  Future<List<Agent>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Agent> create(Agent item);
  Future<Agent> update(String id, Agent item);
  Future<void> delete(String id);
  Future<Map<String, dynamic>> getPerformance(String id);
  Future<List<AgentAssignment>> getAssignments(String id);
}

class AgentRepositoryImpl implements AgentRepository {
  final AgentService _service;
  AgentRepositoryImpl(this._service);

  @override
  Future<Agent> getById(String id) => _service.getAgentById(id);

  @override
  Future<List<Agent>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAgents(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Agent> create(Agent item) => _service.createAgent(item);

  @override
  Future<Agent> update(String id, Agent item) => _service.updateAgent(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAgent(id);

  @override
  Future<Map<String, dynamic>> getPerformance(String id) => _service.getPerformance(id);

  @override
  Future<List<AgentAssignment>> getAssignments(String id) => _service.getAssignments(id);
}
