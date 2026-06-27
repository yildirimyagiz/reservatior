import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/project_service.dart';

abstract class ProjectRepository {
  Future<Project> getById(String id);
  Future<List<Project>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Project> create(Project item);
  Future<Project> update(String id, Project item);
  Future<void> delete(String id);
}

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectService _service;
  ProjectRepositoryImpl(this._service);

  @override
  Future<Project> getById(String id) => _service.getProjectById(id);

  @override
  Future<List<Project>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getProjects(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Project> create(Project item) => _service.createProject(item);

  @override
  Future<Project> update(String id, Project item) => _service.updateProject(id, item);

  @override
  Future<void> delete(String id) => _service.deleteProject(id);
}
