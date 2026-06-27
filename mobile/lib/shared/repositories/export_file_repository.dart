import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/export_file_service.dart';

abstract class ExportFileRepository {
  Future<ExportFile> getById(String id);
  Future<List<ExportFile>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ExportFile> create(ExportFile item);
  Future<ExportFile> update(String id, ExportFile item);
  Future<void> delete(String id);
}

class ExportFileRepositoryImpl implements ExportFileRepository {
  final ExportFileService _service;
  ExportFileRepositoryImpl(this._service);

  @override
  Future<ExportFile> getById(String id) => _service.getExportFileById(id);

  @override
  Future<List<ExportFile>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getExportFiles(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ExportFile> create(ExportFile item) => _service.createExportFile(item);

  @override
  Future<ExportFile> update(String id, ExportFile item) => _service.updateExportFile(id, item);

  @override
  Future<void> delete(String id) => _service.deleteExportFile(id);
}
