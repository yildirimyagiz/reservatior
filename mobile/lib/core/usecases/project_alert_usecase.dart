import 'package:reservatior/shared/repositories/project_alert_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetProjectAlertByIdUseCase {
  final ProjectAlertRepository _repository;
  GetProjectAlertByIdUseCase(this._repository);
  Future<ProjectAlert> execute(String id) => _repository.getById(id);
}

class GetProjectAlertsUseCase {
  final ProjectAlertRepository _repository;
  GetProjectAlertsUseCase(this._repository);
  Future<List<ProjectAlert>> execute({
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

class CreateProjectAlertUseCase {
  final ProjectAlertRepository _repository;
  CreateProjectAlertUseCase(this._repository);
  Future<ProjectAlert> execute(ProjectAlert item) => _repository.create(item);
}

class UpdateProjectAlertUseCase {
  final ProjectAlertRepository _repository;
  UpdateProjectAlertUseCase(this._repository);
  Future<ProjectAlert> execute(String id, ProjectAlert item) => _repository.update(id, item);
}

class DeleteProjectAlertUseCase {
  final ProjectAlertRepository _repository;
  DeleteProjectAlertUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
