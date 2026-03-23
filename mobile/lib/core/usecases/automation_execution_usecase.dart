import '../../features/shared/services/automation_execution_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AutomationExecution

class GetAutomationExecutionByIdUseCase {
  final AutomationExecutionService _service;
  
  GetAutomationExecutionByIdUseCase(this._service);
  
  Future<AutomationExecution> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAutomationExecutionsUseCase {
  final AutomationExecutionService _service;
  
  GetAutomationExecutionsUseCase(this._service);
  
  Future<List<AutomationExecution>> execute({
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

class CreateAutomationExecutionUseCase {
  final AutomationExecutionService _service;
  
  CreateAutomationExecutionUseCase(this._service);
  
  Future<AutomationExecution> execute(AutomationExecution automationExecution) async {
    // Add validation logic here
    return await _service.create(automationExecution);
  }
}

class UpdateAutomationExecutionUseCase {
  final AutomationExecutionService _service;
  
  UpdateAutomationExecutionUseCase(this._service);
  
  Future<AutomationExecution> execute(String id, AutomationExecution automationExecution) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, automationExecution);
  }
}

class DeleteAutomationExecutionUseCase {
  final AutomationExecutionService _service;
  
  DeleteAutomationExecutionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AutomationExecution Use Case Container
class AutomationExecutionUseCases {
  final GetAutomationExecutionByIdUseCase getById;
  final GetAutomationExecutionsUseCase getAll;
  final CreateAutomationExecutionUseCase create;
  final UpdateAutomationExecutionUseCase update;
  final DeleteAutomationExecutionUseCase delete;
  
  AutomationExecutionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AutomationExecutionUseCases.create(AutomationExecutionService service) {
    return AutomationExecutionUseCases(
      getById: GetAutomationExecutionByIdUseCase(service),
      getAll: GetAutomationExecutionsUseCase(service),
      create: CreateAutomationExecutionUseCase(service),
      update: UpdateAutomationExecutionUseCase(service),
      delete: DeleteAutomationExecutionUseCase(service),
    );
  }
}
