import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/automation_task_service.dart';

abstract class AutomationTaskRepository {
  Future<AutomationTask> getById(String id);
  Future<List<AutomationTask>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AutomationTask> create(AutomationTask item);
  Future<AutomationTask> update(String id, AutomationTask item);
  Future<void> delete(String id);
}

class AutomationTaskRepositoryImpl implements AutomationTaskRepository {
  final AutomationTaskService _service;
  AutomationTaskRepositoryImpl(this._service);

  @override
  Future<AutomationTask> getById(String id) => _service.getAutomationTaskById(id);

  @override
  Future<List<AutomationTask>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAutomationTasks(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AutomationTask> create(AutomationTask item) => _service.createAutomationTask(item);

  @override
  Future<AutomationTask> update(String id, AutomationTask item) => _service.updateAutomationTask(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAutomationTask(id);
}
