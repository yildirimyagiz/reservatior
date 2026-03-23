import '../../features/shared/services/export_file_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ExportFile

class GetExportFileByIdUseCase {
  final ExportFileService _service;
  
  GetExportFileByIdUseCase(this._service);
  
  Future<ExportFile> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetExportFilesUseCase {
  final ExportFileService _service;
  
  GetExportFilesUseCase(this._service);
  
  Future<List<ExportFile>> execute({
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

class CreateExportFileUseCase {
  final ExportFileService _service;
  
  CreateExportFileUseCase(this._service);
  
  Future<ExportFile> execute(ExportFile exportFile) async {
    // Add validation logic here
    return await _service.create(exportFile);
  }
}

class UpdateExportFileUseCase {
  final ExportFileService _service;
  
  UpdateExportFileUseCase(this._service);
  
  Future<ExportFile> execute(String id, ExportFile exportFile) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, exportFile);
  }
}

class DeleteExportFileUseCase {
  final ExportFileService _service;
  
  DeleteExportFileUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ExportFile Use Case Container
class ExportFileUseCases {
  final GetExportFileByIdUseCase getById;
  final GetExportFilesUseCase getAll;
  final CreateExportFileUseCase create;
  final UpdateExportFileUseCase update;
  final DeleteExportFileUseCase delete;
  
  ExportFileUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ExportFileUseCases.create(ExportFileService service) {
    return ExportFileUseCases(
      getById: GetExportFileByIdUseCase(service),
      getAll: GetExportFilesUseCase(service),
      create: CreateExportFileUseCase(service),
      update: UpdateExportFileUseCase(service),
      delete: DeleteExportFileUseCase(service),
    );
  }
}
