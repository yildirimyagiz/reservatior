import 'package:reservatior/shared/repositories/agent_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAgentByIdUseCase {
  final AgentRepository _repository;
  GetAgentByIdUseCase(this._repository);
  Future<Agent> execute(String id) => _repository.getById(id);
}

class GetAgentsUseCase {
  final AgentRepository _repository;
  GetAgentsUseCase(this._repository);
  Future<List<Agent>> execute({
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

class CreateAgentUseCase {
  final AgentRepository _repository;
  CreateAgentUseCase(this._repository);
  Future<Agent> execute(Agent item) => _repository.create(item);
}

class UpdateAgentUseCase {
  final AgentRepository _repository;
  UpdateAgentUseCase(this._repository);
  Future<Agent> execute(String id, Agent item) => _repository.update(id, item);
}

class DeleteAgentUseCase {
  final AgentRepository _repository;
  DeleteAgentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
