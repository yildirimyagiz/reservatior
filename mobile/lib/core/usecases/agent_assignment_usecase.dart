import 'package:reservatior/shared/repositories/agent_assignment_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAgentAssignmentByIdUseCase {
  final AgentAssignmentRepository _repository;
  GetAgentAssignmentByIdUseCase(this._repository);
  Future<AgentAssignment> execute(String id) => _repository.getById(id);
}

class GetAgentAssignmentsUseCase {
  final AgentAssignmentRepository _repository;
  GetAgentAssignmentsUseCase(this._repository);
  Future<List<AgentAssignment>> execute({
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

class CreateAgentAssignmentUseCase {
  final AgentAssignmentRepository _repository;
  CreateAgentAssignmentUseCase(this._repository);
  Future<AgentAssignment> execute(AgentAssignment item) => _repository.create(item);
}

class UpdateAgentAssignmentUseCase {
  final AgentAssignmentRepository _repository;
  UpdateAgentAssignmentUseCase(this._repository);
  Future<AgentAssignment> execute(String id, AgentAssignment item) => _repository.update(id, item);
}

class DeleteAgentAssignmentUseCase {
  final AgentAssignmentRepository _repository;
  DeleteAgentAssignmentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
