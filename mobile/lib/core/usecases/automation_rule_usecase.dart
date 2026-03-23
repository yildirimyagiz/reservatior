import '../../features/shared/services/automation_rule_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AutomationRule

class GetAutomationRuleByIdUseCase {
  final AutomationRuleService _service;
  
  GetAutomationRuleByIdUseCase(this._service);
  
  Future<AutomationRule> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAutomationRulesUseCase {
  final AutomationRuleService _service;
  
  GetAutomationRulesUseCase(this._service);
  
  Future<List<AutomationRule>> execute({
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

class CreateAutomationRuleUseCase {
  final AutomationRuleService _service;
  
  CreateAutomationRuleUseCase(this._service);
  
  Future<AutomationRule> execute(AutomationRule automationRule) async {
    // Add validation logic here
    return await _service.create(automationRule);
  }
}

class UpdateAutomationRuleUseCase {
  final AutomationRuleService _service;
  
  UpdateAutomationRuleUseCase(this._service);
  
  Future<AutomationRule> execute(String id, AutomationRule automationRule) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, automationRule);
  }
}

class DeleteAutomationRuleUseCase {
  final AutomationRuleService _service;
  
  DeleteAutomationRuleUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AutomationRule Use Case Container
class AutomationRuleUseCases {
  final GetAutomationRuleByIdUseCase getById;
  final GetAutomationRulesUseCase getAll;
  final CreateAutomationRuleUseCase create;
  final UpdateAutomationRuleUseCase update;
  final DeleteAutomationRuleUseCase delete;
  
  AutomationRuleUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AutomationRuleUseCases.create(AutomationRuleService service) {
    return AutomationRuleUseCases(
      getById: GetAutomationRuleByIdUseCase(service),
      getAll: GetAutomationRulesUseCase(service),
      create: CreateAutomationRuleUseCase(service),
      update: UpdateAutomationRuleUseCase(service),
      delete: DeleteAutomationRuleUseCase(service),
    );
  }
}
