import 'package:reservatior/shared/repositories/project_analytics_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetProjectAnalyticsByIdUseCase {
  final ProjectAnalyticsRepository _repository;
  GetProjectAnalyticsByIdUseCase(this._repository);
  Future<ProjectAnalytics> execute(String id) => _repository.getById(id);
}

class GetProjectAnalyticssUseCase {
  final ProjectAnalyticsRepository _repository;
  GetProjectAnalyticssUseCase(this._repository);
  Future<List<ProjectAnalytics>> execute({
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

class CreateProjectAnalyticsUseCase {
  final ProjectAnalyticsRepository _repository;
  CreateProjectAnalyticsUseCase(this._repository);
  Future<ProjectAnalytics> execute(ProjectAnalytics item) => _repository.create(item);
}

class UpdateProjectAnalyticsUseCase {
  final ProjectAnalyticsRepository _repository;
  UpdateProjectAnalyticsUseCase(this._repository);
  Future<ProjectAnalytics> execute(String id, ProjectAnalytics item) => _repository.update(id, item);
}

class DeleteProjectAnalyticsUseCase {
  final ProjectAnalyticsRepository _repository;
  DeleteProjectAnalyticsUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
