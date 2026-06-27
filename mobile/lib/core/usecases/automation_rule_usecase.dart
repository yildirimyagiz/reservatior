import 'package:reservatior/shared/repositories/automation_rule_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAutomationRuleByIdUseCase {
  final AutomationRuleRepository _repository;
  GetAutomationRuleByIdUseCase(this._repository);
  Future<AutomationRule> execute(String id) => _repository.getById(id);
}

class GetAutomationRulesUseCase {
  final AutomationRuleRepository _repository;
  GetAutomationRulesUseCase(this._repository);
  Future<List<AutomationRule>> execute({
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

class CreateAutomationRuleUseCase {
  final AutomationRuleRepository _repository;
  CreateAutomationRuleUseCase(this._repository);
  Future<AutomationRule> execute(AutomationRule item) => _repository.create(item);
}

class UpdateAutomationRuleUseCase {
  final AutomationRuleRepository _repository;
  UpdateAutomationRuleUseCase(this._repository);
  Future<AutomationRule> execute(String id, AutomationRule item) => _repository.update(id, item);
}

class DeleteAutomationRuleUseCase {
  final AutomationRuleRepository _repository;
  DeleteAutomationRuleUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
