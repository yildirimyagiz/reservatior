import '../../features/shared/services/analysis_job_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AnalysisJob

class GetAnalysisJobByIdUseCase {
  final AnalysisJobService _service;
  
  GetAnalysisJobByIdUseCase(this._service);
  
  Future<AnalysisJob> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAnalysisJobsUseCase {
  final AnalysisJobService _service;
  
  GetAnalysisJobsUseCase(this._service);
  
  Future<List<AnalysisJob>> execute({
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

class CreateAnalysisJobUseCase {
  final AnalysisJobService _service;
  
  CreateAnalysisJobUseCase(this._service);
  
  Future<AnalysisJob> execute(AnalysisJob analysisJob) async {
    // Add validation logic here
    return await _service.create(analysisJob);
  }
}

class UpdateAnalysisJobUseCase {
  final AnalysisJobService _service;
  
  UpdateAnalysisJobUseCase(this._service);
  
  Future<AnalysisJob> execute(String id, AnalysisJob analysisJob) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, analysisJob);
  }
}

class DeleteAnalysisJobUseCase {
  final AnalysisJobService _service;
  
  DeleteAnalysisJobUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AnalysisJob Use Case Container
class AnalysisJobUseCases {
  final GetAnalysisJobByIdUseCase getById;
  final GetAnalysisJobsUseCase getAll;
  final CreateAnalysisJobUseCase create;
  final UpdateAnalysisJobUseCase update;
  final DeleteAnalysisJobUseCase delete;
  
  AnalysisJobUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AnalysisJobUseCases.create(AnalysisJobService service) {
    return AnalysisJobUseCases(
      getById: GetAnalysisJobByIdUseCase(service),
      getAll: GetAnalysisJobsUseCase(service),
      create: CreateAnalysisJobUseCase(service),
      update: UpdateAnalysisJobUseCase(service),
      delete: DeleteAnalysisJobUseCase(service),
    );
  }
}
