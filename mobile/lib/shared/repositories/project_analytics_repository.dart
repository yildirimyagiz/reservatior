import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/project_analytics_service.dart';

abstract class ProjectAnalyticsRepository {
  Future<ProjectAnalytics> getById(String id);
  Future<List<ProjectAnalytics>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ProjectAnalytics> create(ProjectAnalytics item);
  Future<ProjectAnalytics> update(String id, ProjectAnalytics item);
  Future<void> delete(String id);
}

class ProjectAnalyticsRepositoryImpl implements ProjectAnalyticsRepository {
  final ProjectAnalyticsService _service;
  ProjectAnalyticsRepositoryImpl(this._service);

  @override
  Future<ProjectAnalytics> getById(String id) => _service.getProjectAnalyticsById(id);

  @override
  Future<List<ProjectAnalytics>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getProjectAnalyticses(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ProjectAnalytics> create(ProjectAnalytics item) => _service.createProjectAnalytics(item);

  @override
  Future<ProjectAnalytics> update(String id, ProjectAnalytics item) => _service.updateProjectAnalytics(id, item);

  @override
  Future<void> delete(String id) => _service.deleteProjectAnalytics(id);
}
