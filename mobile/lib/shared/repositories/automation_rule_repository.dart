import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/automation_rule_service.dart';

abstract class AutomationRuleRepository {
  Future<AutomationRule> getById(String id);
  Future<List<AutomationRule>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AutomationRule> create(AutomationRule item);
  Future<AutomationRule> update(String id, AutomationRule item);
  Future<void> delete(String id);
}

class AutomationRuleRepositoryImpl implements AutomationRuleRepository {
  final AutomationRuleService _service;
  AutomationRuleRepositoryImpl(this._service);

  @override
  Future<AutomationRule> getById(String id) => _service.getAutomationRuleById(id);

  @override
  Future<List<AutomationRule>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAutomationRules(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AutomationRule> create(AutomationRule item) => _service.createAutomationRule(item);

  @override
  Future<AutomationRule> update(String id, AutomationRule item) => _service.updateAutomationRule(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAutomationRule(id);
}
