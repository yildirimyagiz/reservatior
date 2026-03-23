import '../../features/shared/services/project_analytics_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ProjectAnalytics

class GetProjectAnalyticsByIdUseCase {
  final ProjectAnalyticsService _service;
  
  GetProjectAnalyticsByIdUseCase(this._service);
  
  Future<ProjectAnalytics> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetProjectAnalyticssUseCase {
  final ProjectAnalyticsService _service;
  
  GetProjectAnalyticssUseCase(this._service);
  
  Future<List<ProjectAnalytics>> execute({
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

class CreateProjectAnalyticsUseCase {
  final ProjectAnalyticsService _service;
  
  CreateProjectAnalyticsUseCase(this._service);
  
  Future<ProjectAnalytics> execute(ProjectAnalytics projectAnalytics) async {
    // Add validation logic here
    return await _service.create(projectAnalytics);
  }
}

class UpdateProjectAnalyticsUseCase {
  final ProjectAnalyticsService _service;
  
  UpdateProjectAnalyticsUseCase(this._service);
  
  Future<ProjectAnalytics> execute(String id, ProjectAnalytics projectAnalytics) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, projectAnalytics);
  }
}

class DeleteProjectAnalyticsUseCase {
  final ProjectAnalyticsService _service;
  
  DeleteProjectAnalyticsUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ProjectAnalytics Use Case Container
class ProjectAnalyticsUseCases {
  final GetProjectAnalyticsByIdUseCase getById;
  final GetProjectAnalyticssUseCase getAll;
  final CreateProjectAnalyticsUseCase create;
  final UpdateProjectAnalyticsUseCase update;
  final DeleteProjectAnalyticsUseCase delete;
  
  ProjectAnalyticsUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ProjectAnalyticsUseCases.create(ProjectAnalyticsService service) {
    return ProjectAnalyticsUseCases(
      getById: GetProjectAnalyticsByIdUseCase(service),
      getAll: GetProjectAnalyticssUseCase(service),
      create: CreateProjectAnalyticsUseCase(service),
      update: UpdateProjectAnalyticsUseCase(service),
      delete: DeleteProjectAnalyticsUseCase(service),
    );
  }
}
