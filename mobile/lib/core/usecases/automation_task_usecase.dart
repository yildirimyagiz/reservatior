import 'package:reservatior/shared/repositories/automation_task_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAutomationTaskByIdUseCase {
  final AutomationTaskRepository _repository;
  GetAutomationTaskByIdUseCase(this._repository);
  Future<AutomationTask> execute(String id) => _repository.getById(id);
}

class GetAutomationTasksUseCase {
  final AutomationTaskRepository _repository;
  GetAutomationTasksUseCase(this._repository);
  Future<List<AutomationTask>> execute({
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

class CreateAutomationTaskUseCase {
  final AutomationTaskRepository _repository;
  CreateAutomationTaskUseCase(this._repository);
  Future<AutomationTask> execute(AutomationTask item) => _repository.create(item);
}

class UpdateAutomationTaskUseCase {
  final AutomationTaskRepository _repository;
  UpdateAutomationTaskUseCase(this._repository);
  Future<AutomationTask> execute(String id, AutomationTask item) => _repository.update(id, item);
}

class DeleteAutomationTaskUseCase {
  final AutomationTaskRepository _repository;
  DeleteAutomationTaskUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
