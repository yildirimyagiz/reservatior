import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/agent_performance_service.dart';

abstract class AgentPerformanceRepository {
  Future<AgentPerformance> getById(String id);
  Future<List<AgentPerformance>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AgentPerformance> create(AgentPerformance item);
  Future<AgentPerformance> update(String id, AgentPerformance item);
  Future<void> delete(String id);
}

class AgentPerformanceRepositoryImpl implements AgentPerformanceRepository {
  final AgentPerformanceService _service;
  AgentPerformanceRepositoryImpl(this._service);

  @override
  Future<AgentPerformance> getById(String id) => _service.getAgentPerformanceById(id);

  @override
  Future<List<AgentPerformance>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAgentPerformances(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AgentPerformance> create(AgentPerformance item) => _service.createAgentPerformance(item);

  @override
  Future<AgentPerformance> update(String id, AgentPerformance item) => _service.updateAgentPerformance(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAgentPerformance(id);
}
