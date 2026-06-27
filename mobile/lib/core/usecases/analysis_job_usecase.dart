import 'package:reservatior/shared/repositories/analysis_job_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAnalysisJobByIdUseCase {
  final AnalysisJobRepository _repository;
  GetAnalysisJobByIdUseCase(this._repository);
  Future<AnalysisJob> execute(String id) => _repository.getById(id);
}

class GetAnalysisJobsUseCase {
  final AnalysisJobRepository _repository;
  GetAnalysisJobsUseCase(this._repository);
  Future<List<AnalysisJob>> execute({
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

class CreateAnalysisJobUseCase {
  final AnalysisJobRepository _repository;
  CreateAnalysisJobUseCase(this._repository);
  Future<AnalysisJob> execute(AnalysisJob item) => _repository.create(item);
}

class UpdateAnalysisJobUseCase {
  final AnalysisJobRepository _repository;
  UpdateAnalysisJobUseCase(this._repository);
  Future<AnalysisJob> execute(String id, AnalysisJob item) => _repository.update(id, item);
}

class DeleteAnalysisJobUseCase {
  final AnalysisJobRepository _repository;
  DeleteAnalysisJobUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
