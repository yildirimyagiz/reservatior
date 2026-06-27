import 'package:reservatior/shared/repositories/automation_execution_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAutomationExecutionByIdUseCase {
  final AutomationExecutionRepository _repository;
  GetAutomationExecutionByIdUseCase(this._repository);
  Future<AutomationExecution> execute(String id) => _repository.getById(id);
}

class GetAutomationExecutionsUseCase {
  final AutomationExecutionRepository _repository;
  GetAutomationExecutionsUseCase(this._repository);
  Future<List<AutomationExecution>> execute({
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

class CreateAutomationExecutionUseCase {
  final AutomationExecutionRepository _repository;
  CreateAutomationExecutionUseCase(this._repository);
  Future<AutomationExecution> execute(AutomationExecution item) => _repository.create(item);
}

class UpdateAutomationExecutionUseCase {
  final AutomationExecutionRepository _repository;
  UpdateAutomationExecutionUseCase(this._repository);
  Future<AutomationExecution> execute(String id, AutomationExecution item) => _repository.update(id, item);
}

class DeleteAutomationExecutionUseCase {
  final AutomationExecutionRepository _repository;
  DeleteAutomationExecutionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
