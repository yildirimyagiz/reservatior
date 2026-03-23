import '../../features/shared/services/project_report_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ProjectReport

class GetProjectReportByIdUseCase {
  final ProjectReportService _service;
  
  GetProjectReportByIdUseCase(this._service);
  
  Future<ProjectReport> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetProjectReportsUseCase {
  final ProjectReportService _service;
  
  GetProjectReportsUseCase(this._service);
  
  Future<List<ProjectReport>> execute({
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

class CreateProjectReportUseCase {
  final ProjectReportService _service;
  
  CreateProjectReportUseCase(this._service);
  
  Future<ProjectReport> execute(ProjectReport projectReport) async {
    // Add validation logic here
    return await _service.create(projectReport);
  }
}

class UpdateProjectReportUseCase {
  final ProjectReportService _service;
  
  UpdateProjectReportUseCase(this._service);
  
  Future<ProjectReport> execute(String id, ProjectReport projectReport) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, projectReport);
  }
}

class DeleteProjectReportUseCase {
  final ProjectReportService _service;
  
  DeleteProjectReportUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ProjectReport Use Case Container
class ProjectReportUseCases {
  final GetProjectReportByIdUseCase getById;
  final GetProjectReportsUseCase getAll;
  final CreateProjectReportUseCase create;
  final UpdateProjectReportUseCase update;
  final DeleteProjectReportUseCase delete;
  
  ProjectReportUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ProjectReportUseCases.create(ProjectReportService service) {
    return ProjectReportUseCases(
      getById: GetProjectReportByIdUseCase(service),
      getAll: GetProjectReportsUseCase(service),
      create: CreateProjectReportUseCase(service),
      update: UpdateProjectReportUseCase(service),
      delete: DeleteProjectReportUseCase(service),
    );
  }
}
