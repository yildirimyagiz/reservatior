import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/agent_assignment_service.dart';

abstract class AgentAssignmentRepository {
  Future<AgentAssignment> getById(String id);
  Future<List<AgentAssignment>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AgentAssignment> create(AgentAssignment item);
  Future<AgentAssignment> update(String id, AgentAssignment item);
  Future<void> delete(String id);
}

class AgentAssignmentRepositoryImpl implements AgentAssignmentRepository {
  final AgentAssignmentService _service;
  AgentAssignmentRepositoryImpl(this._service);

  @override
  Future<AgentAssignment> getById(String id) => _service.getAgentAssignmentById(id);

  @override
  Future<List<AgentAssignment>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAgentAssignments(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AgentAssignment> create(AgentAssignment item) => _service.createAgentAssignment(item);

  @override
  Future<AgentAssignment> update(String id, AgentAssignment item) => _service.updateAgentAssignment(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAgentAssignment(id);
}
