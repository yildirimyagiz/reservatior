import 'package:reservatior/shared/repositories/task_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetTaskByIdUseCase {
  final TaskRepository _repository;
  GetTaskByIdUseCase(this._repository);
  Future<Task> execute(String id) => _repository.getById(id);
}

class GetTasksUseCase {
  final TaskRepository _repository;
  GetTasksUseCase(this._repository);
  Future<List<Task>> execute({
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

class CreateTaskUseCase {
  final TaskRepository _repository;
  CreateTaskUseCase(this._repository);
  Future<Task> execute(Task item) => _repository.create(item);
}

class UpdateTaskUseCase {
  final TaskRepository _repository;
  UpdateTaskUseCase(this._repository);
  Future<Task> execute(String id, Task item) => _repository.update(id, item);
}

class DeleteTaskUseCase {
  final TaskRepository _repository;
  DeleteTaskUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
