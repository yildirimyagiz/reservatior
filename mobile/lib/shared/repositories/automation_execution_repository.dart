import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/automation_execution_service.dart';

abstract class AutomationExecutionRepository {
  Future<AutomationExecution> getById(String id);
  Future<List<AutomationExecution>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AutomationExecution> create(AutomationExecution item);
  Future<AutomationExecution> update(String id, AutomationExecution item);
  Future<void> delete(String id);
}

class AutomationExecutionRepositoryImpl implements AutomationExecutionRepository {
  final AutomationExecutionService _service;
  AutomationExecutionRepositoryImpl(this._service);

  @override
  Future<AutomationExecution> getById(String id) => _service.getAutomationExecutionById(id);

  @override
  Future<List<AutomationExecution>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAutomationExecutions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AutomationExecution> create(AutomationExecution item) => _service.createAutomationExecution(item);

  @override
  Future<AutomationExecution> update(String id, AutomationExecution item) => _service.updateAutomationExecution(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAutomationExecution(id);
}
