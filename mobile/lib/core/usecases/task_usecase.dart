import '../../features/shared/services/task_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Task

class GetTaskByIdUseCase {
  final TaskService _service;
  
  GetTaskByIdUseCase(this._service);
  
  Future<Task> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetTasksUseCase {
  final TaskService _service;
  
  GetTasksUseCase(this._service);
  
  Future<List<Task>> execute({
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

class CreateTaskUseCase {
  final TaskService _service;
  
  CreateTaskUseCase(this._service);
  
  Future<Task> execute(Task task) async {
    // Add validation logic here
    return await _service.create(task);
  }
}

class UpdateTaskUseCase {
  final TaskService _service;
  
  UpdateTaskUseCase(this._service);
  
  Future<Task> execute(String id, Task task) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, task);
  }
}

class DeleteTaskUseCase {
  final TaskService _service;
  
  DeleteTaskUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Task Use Case Container
class TaskUseCases {
  final GetTaskByIdUseCase getById;
  final GetTasksUseCase getAll;
  final CreateTaskUseCase create;
  final UpdateTaskUseCase update;
  final DeleteTaskUseCase delete;
  
  TaskUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory TaskUseCases.create(TaskService service) {
    return TaskUseCases(
      getById: GetTaskByIdUseCase(service),
      getAll: GetTasksUseCase(service),
      create: CreateTaskUseCase(service),
      update: UpdateTaskUseCase(service),
      delete: DeleteTaskUseCase(service),
    );
  }
}
