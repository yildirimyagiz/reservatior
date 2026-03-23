import '../../features/shared/services/m_l_s_sync_job_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MLSSyncJob

class GetMLSSyncJobByIdUseCase {
  final MLSSyncJobService _service;
  
  GetMLSSyncJobByIdUseCase(this._service);
  
  Future<MLSSyncJob> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMLSSyncJobsUseCase {
  final MLSSyncJobService _service;
  
  GetMLSSyncJobsUseCase(this._service);
  
  Future<List<MLSSyncJob>> execute({
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

class CreateMLSSyncJobUseCase {
  final MLSSyncJobService _service;
  
  CreateMLSSyncJobUseCase(this._service);
  
  Future<MLSSyncJob> execute(MLSSyncJob mLSSyncJob) async {
    // Add validation logic here
    return await _service.create(mLSSyncJob);
  }
}

class UpdateMLSSyncJobUseCase {
  final MLSSyncJobService _service;
  
  UpdateMLSSyncJobUseCase(this._service);
  
  Future<MLSSyncJob> execute(String id, MLSSyncJob mLSSyncJob) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mLSSyncJob);
  }
}

class DeleteMLSSyncJobUseCase {
  final MLSSyncJobService _service;
  
  DeleteMLSSyncJobUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MLSSyncJob Use Case Container
class MLSSyncJobUseCases {
  final GetMLSSyncJobByIdUseCase getById;
  final GetMLSSyncJobsUseCase getAll;
  final CreateMLSSyncJobUseCase create;
  final UpdateMLSSyncJobUseCase update;
  final DeleteMLSSyncJobUseCase delete;
  
  MLSSyncJobUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MLSSyncJobUseCases.create(MLSSyncJobService service) {
    return MLSSyncJobUseCases(
      getById: GetMLSSyncJobByIdUseCase(service),
      getAll: GetMLSSyncJobsUseCase(service),
      create: CreateMLSSyncJobUseCase(service),
      update: UpdateMLSSyncJobUseCase(service),
      delete: DeleteMLSSyncJobUseCase(service),
    );
  }
}
