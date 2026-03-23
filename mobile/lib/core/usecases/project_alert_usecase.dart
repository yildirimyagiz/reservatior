import '../../features/shared/services/project_alert_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ProjectAlert

class GetProjectAlertByIdUseCase {
  final ProjectAlertService _service;
  
  GetProjectAlertByIdUseCase(this._service);
  
  Future<ProjectAlert> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetProjectAlertsUseCase {
  final ProjectAlertService _service;
  
  GetProjectAlertsUseCase(this._service);
  
  Future<List<ProjectAlert>> execute({
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

class CreateProjectAlertUseCase {
  final ProjectAlertService _service;
  
  CreateProjectAlertUseCase(this._service);
  
  Future<ProjectAlert> execute(ProjectAlert projectAlert) async {
    // Add validation logic here
    return await _service.create(projectAlert);
  }
}

class UpdateProjectAlertUseCase {
  final ProjectAlertService _service;
  
  UpdateProjectAlertUseCase(this._service);
  
  Future<ProjectAlert> execute(String id, ProjectAlert projectAlert) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, projectAlert);
  }
}

class DeleteProjectAlertUseCase {
  final ProjectAlertService _service;
  
  DeleteProjectAlertUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ProjectAlert Use Case Container
class ProjectAlertUseCases {
  final GetProjectAlertByIdUseCase getById;
  final GetProjectAlertsUseCase getAll;
  final CreateProjectAlertUseCase create;
  final UpdateProjectAlertUseCase update;
  final DeleteProjectAlertUseCase delete;
  
  ProjectAlertUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ProjectAlertUseCases.create(ProjectAlertService service) {
    return ProjectAlertUseCases(
      getById: GetProjectAlertByIdUseCase(service),
      getAll: GetProjectAlertsUseCase(service),
      create: CreateProjectAlertUseCase(service),
      update: UpdateProjectAlertUseCase(service),
      delete: DeleteProjectAlertUseCase(service),
    );
  }
}
