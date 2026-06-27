import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/project_alert_service.dart';

abstract class ProjectAlertRepository {
  Future<ProjectAlert> getById(String id);
  Future<List<ProjectAlert>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ProjectAlert> create(ProjectAlert item);
  Future<ProjectAlert> update(String id, ProjectAlert item);
  Future<void> delete(String id);
}

class ProjectAlertRepositoryImpl implements ProjectAlertRepository {
  final ProjectAlertService _service;
  ProjectAlertRepositoryImpl(this._service);

  @override
  Future<ProjectAlert> getById(String id) => _service.getProjectAlertById(id);

  @override
  Future<List<ProjectAlert>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getProjectAlerts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ProjectAlert> create(ProjectAlert item) => _service.createProjectAlert(item);

  @override
  Future<ProjectAlert> update(String id, ProjectAlert item) => _service.updateProjectAlert(id, item);

  @override
  Future<void> delete(String id) => _service.deleteProjectAlert(id);
}
