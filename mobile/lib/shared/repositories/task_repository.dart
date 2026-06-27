import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/task_service.dart';

abstract class TaskRepository {
  Future<Task> getById(String id);
  Future<List<Task>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Task> create(Task item);
  Future<Task> update(String id, Task item);
  Future<void> delete(String id);
}

class TaskRepositoryImpl implements TaskRepository {
  final TaskService _service;
  TaskRepositoryImpl(this._service);

  @override
  Future<Task> getById(String id) => _service.getTaskById(id);

  @override
  Future<List<Task>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getTasks(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Task> create(Task item) => _service.createTask(item);

  @override
  Future<Task> update(String id, Task item) => _service.updateTask(id, item);

  @override
  Future<void> delete(String id) => _service.deleteTask(id);
}
