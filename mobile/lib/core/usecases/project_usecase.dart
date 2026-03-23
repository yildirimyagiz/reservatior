import '../../features/shared/services/project_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Project

class GetProjectByIdUseCase {
  final ProjectService _service;
  
  GetProjectByIdUseCase(this._service);
  
  Future<Project> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetProjectsUseCase {
  final ProjectService _service;
  
  GetProjectsUseCase(this._service);
  
  Future<List<Project>> execute({
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

class CreateProjectUseCase {
  final ProjectService _service;
  
  CreateProjectUseCase(this._service);
  
  Future<Project> execute(Project project) async {
    // Add validation logic here
    return await _service.create(project);
  }
}

class UpdateProjectUseCase {
  final ProjectService _service;
  
  UpdateProjectUseCase(this._service);
  
  Future<Project> execute(String id, Project project) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, project);
  }
}

class DeleteProjectUseCase {
  final ProjectService _service;
  
  DeleteProjectUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Project Use Case Container
class ProjectUseCases {
  final GetProjectByIdUseCase getById;
  final GetProjectsUseCase getAll;
  final CreateProjectUseCase create;
  final UpdateProjectUseCase update;
  final DeleteProjectUseCase delete;
  
  ProjectUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ProjectUseCases.create(ProjectService service) {
    return ProjectUseCases(
      getById: GetProjectByIdUseCase(service),
      getAll: GetProjectsUseCase(service),
      create: CreateProjectUseCase(service),
      update: UpdateProjectUseCase(service),
      delete: DeleteProjectUseCase(service),
    );
  }
}
