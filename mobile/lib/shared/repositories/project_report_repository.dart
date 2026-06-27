import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/project_report_service.dart';

abstract class ProjectReportRepository {
  Future<ProjectReport> getById(String id);
  Future<List<ProjectReport>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ProjectReport> create(ProjectReport item);
  Future<ProjectReport> update(String id, ProjectReport item);
  Future<void> delete(String id);
}

class ProjectReportRepositoryImpl implements ProjectReportRepository {
  final ProjectReportService _service;
  ProjectReportRepositoryImpl(this._service);

  @override
  Future<ProjectReport> getById(String id) => _service.getProjectReportById(id);

  @override
  Future<List<ProjectReport>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getProjectReports(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ProjectReport> create(ProjectReport item) => _service.createProjectReport(item);

  @override
  Future<ProjectReport> update(String id, ProjectReport item) => _service.updateProjectReport(id, item);

  @override
  Future<void> delete(String id) => _service.deleteProjectReport(id);
}
