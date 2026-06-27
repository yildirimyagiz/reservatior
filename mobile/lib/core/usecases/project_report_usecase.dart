import 'package:reservatior/shared/repositories/project_report_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetProjectReportByIdUseCase {
  final ProjectReportRepository _repository;
  GetProjectReportByIdUseCase(this._repository);
  Future<ProjectReport> execute(String id) => _repository.getById(id);
}

class GetProjectReportsUseCase {
  final ProjectReportRepository _repository;
  GetProjectReportsUseCase(this._repository);
  Future<List<ProjectReport>> execute({
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

class CreateProjectReportUseCase {
  final ProjectReportRepository _repository;
  CreateProjectReportUseCase(this._repository);
  Future<ProjectReport> execute(ProjectReport item) => _repository.create(item);
}

class UpdateProjectReportUseCase {
  final ProjectReportRepository _repository;
  UpdateProjectReportUseCase(this._repository);
  Future<ProjectReport> execute(String id, ProjectReport item) => _repository.update(id, item);
}

class DeleteProjectReportUseCase {
  final ProjectReportRepository _repository;
  DeleteProjectReportUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
