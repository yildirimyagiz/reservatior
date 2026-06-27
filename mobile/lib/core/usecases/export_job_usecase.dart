import 'package:reservatior/shared/repositories/export_job_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetExportJobByIdUseCase {
  final ExportJobRepository _repository;
  GetExportJobByIdUseCase(this._repository);
  Future<ExportJob> execute(String id) => _repository.getById(id);
}

class GetExportJobsUseCase {
  final ExportJobRepository _repository;
  GetExportJobsUseCase(this._repository);
  Future<List<ExportJob>> execute({
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

class CreateExportJobUseCase {
  final ExportJobRepository _repository;
  CreateExportJobUseCase(this._repository);
  Future<ExportJob> execute(ExportJob item) => _repository.create(item);
}

class UpdateExportJobUseCase {
  final ExportJobRepository _repository;
  UpdateExportJobUseCase(this._repository);
  Future<ExportJob> execute(String id, ExportJob item) => _repository.update(id, item);
}

class DeleteExportJobUseCase {
  final ExportJobRepository _repository;
  DeleteExportJobUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
