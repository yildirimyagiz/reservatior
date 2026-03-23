import '../../features/shared/services/export_job_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ExportJob

class GetExportJobByIdUseCase {
  final ExportJobService _service;
  
  GetExportJobByIdUseCase(this._service);
  
  Future<ExportJob> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetExportJobsUseCase {
  final ExportJobService _service;
  
  GetExportJobsUseCase(this._service);
  
  Future<List<ExportJob>> execute({
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

class CreateExportJobUseCase {
  final ExportJobService _service;
  
  CreateExportJobUseCase(this._service);
  
  Future<ExportJob> execute(ExportJob exportJob) async {
    // Add validation logic here
    return await _service.create(exportJob);
  }
}

class UpdateExportJobUseCase {
  final ExportJobService _service;
  
  UpdateExportJobUseCase(this._service);
  
  Future<ExportJob> execute(String id, ExportJob exportJob) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, exportJob);
  }
}

class DeleteExportJobUseCase {
  final ExportJobService _service;
  
  DeleteExportJobUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ExportJob Use Case Container
class ExportJobUseCases {
  final GetExportJobByIdUseCase getById;
  final GetExportJobsUseCase getAll;
  final CreateExportJobUseCase create;
  final UpdateExportJobUseCase update;
  final DeleteExportJobUseCase delete;
  
  ExportJobUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ExportJobUseCases.create(ExportJobService service) {
    return ExportJobUseCases(
      getById: GetExportJobByIdUseCase(service),
      getAll: GetExportJobsUseCase(service),
      create: CreateExportJobUseCase(service),
      update: UpdateExportJobUseCase(service),
      delete: DeleteExportJobUseCase(service),
    );
  }
}
