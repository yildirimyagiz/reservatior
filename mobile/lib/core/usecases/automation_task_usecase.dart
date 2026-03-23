import '../../features/shared/services/automation_task_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AutomationTask

class GetAutomationTaskByIdUseCase {
  final AutomationTaskService _service;
  
  GetAutomationTaskByIdUseCase(this._service);
  
  Future<AutomationTask> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAutomationTasksUseCase {
  final AutomationTaskService _service;
  
  GetAutomationTasksUseCase(this._service);
  
  Future<List<AutomationTask>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateAutomationTaskUseCase {
  final AutomationTaskService _service;
  
  CreateAutomationTaskUseCase(this._service);
  
  Future<AutomationTask> execute(AutomationTask automationTask) async {
    // Add validation logic here
    return await _service.create(automationTask);
  }
}

class UpdateAutomationTaskUseCase {
  final AutomationTaskService _service;
  
  UpdateAutomationTaskUseCase(this._service);
  
  Future<AutomationTask> execute(String id, AutomationTask automationTask) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, automationTask);
  }
}

class DeleteAutomationTaskUseCase {
  final AutomationTaskService _service;
  
  DeleteAutomationTaskUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AutomationTask Use Case Container
class AutomationTaskUseCases {
  final GetAutomationTaskByIdUseCase getById;
  final GetAutomationTasksUseCase getAll;
  final CreateAutomationTaskUseCase create;
  final UpdateAutomationTaskUseCase update;
  final DeleteAutomationTaskUseCase delete;
  
  AutomationTaskUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AutomationTaskUseCases.create(AutomationTaskService service) {
    return AutomationTaskUseCases(
      getById: GetAutomationTaskByIdUseCase(service),
      getAll: GetAutomationTasksUseCase(service),
      create: CreateAutomationTaskUseCase(service),
      update: UpdateAutomationTaskUseCase(service),
      delete: DeleteAutomationTaskUseCase(service),
    );
  }
}
