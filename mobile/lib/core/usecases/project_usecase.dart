import 'package:reservatior/shared/repositories/project_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetProjectByIdUseCase {
  final ProjectRepository _repository;
  GetProjectByIdUseCase(this._repository);
  Future<Project> execute(String id) => _repository.getById(id);
}

class GetProjectsUseCase {
  final ProjectRepository _repository;
  GetProjectsUseCase(this._repository);
  Future<List<Project>> execute({
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

class CreateProjectUseCase {
  final ProjectRepository _repository;
  CreateProjectUseCase(this._repository);
  Future<Project> execute(Project item) => _repository.create(item);
}

class UpdateProjectUseCase {
  final ProjectRepository _repository;
  UpdateProjectUseCase(this._repository);
  Future<Project> execute(String id, Project item) => _repository.update(id, item);
}

class DeleteProjectUseCase {
  final ProjectRepository _repository;
  DeleteProjectUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
