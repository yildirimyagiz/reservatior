import 'package:reservatior/shared/repositories/export_file_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetExportFileByIdUseCase {
  final ExportFileRepository _repository;
  GetExportFileByIdUseCase(this._repository);
  Future<ExportFile> execute(String id) => _repository.getById(id);
}

class GetExportFilesUseCase {
  final ExportFileRepository _repository;
  GetExportFilesUseCase(this._repository);
  Future<List<ExportFile>> execute({
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

class CreateExportFileUseCase {
  final ExportFileRepository _repository;
  CreateExportFileUseCase(this._repository);
  Future<ExportFile> execute(ExportFile item) => _repository.create(item);
}

class UpdateExportFileUseCase {
  final ExportFileRepository _repository;
  UpdateExportFileUseCase(this._repository);
  Future<ExportFile> execute(String id, ExportFile item) => _repository.update(id, item);
}

class DeleteExportFileUseCase {
  final ExportFileRepository _repository;
  DeleteExportFileUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
