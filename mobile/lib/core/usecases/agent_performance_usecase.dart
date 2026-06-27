import 'package:reservatior/shared/repositories/agent_performance_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAgentPerformanceByIdUseCase {
  final AgentPerformanceRepository _repository;
  GetAgentPerformanceByIdUseCase(this._repository);
  Future<AgentPerformance> execute(String id) => _repository.getById(id);
}

class GetAgentPerformancesUseCase {
  final AgentPerformanceRepository _repository;
  GetAgentPerformancesUseCase(this._repository);
  Future<List<AgentPerformance>> execute({
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

class CreateAgentPerformanceUseCase {
  final AgentPerformanceRepository _repository;
  CreateAgentPerformanceUseCase(this._repository);
  Future<AgentPerformance> execute(AgentPerformance item) => _repository.create(item);
}

class UpdateAgentPerformanceUseCase {
  final AgentPerformanceRepository _repository;
  UpdateAgentPerformanceUseCase(this._repository);
  Future<AgentPerformance> execute(String id, AgentPerformance item) => _repository.update(id, item);
}

class DeleteAgentPerformanceUseCase {
  final AgentPerformanceRepository _repository;
  DeleteAgentPerformanceUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
