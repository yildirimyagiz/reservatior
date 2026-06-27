import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/export_job_service.dart';

abstract class ExportJobRepository {
  Future<ExportJob> getById(String id);
  Future<List<ExportJob>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ExportJob> create(ExportJob item);
  Future<ExportJob> update(String id, ExportJob item);
  Future<void> delete(String id);
}

class ExportJobRepositoryImpl implements ExportJobRepository {
  final ExportJobService _service;
  ExportJobRepositoryImpl(this._service);

  @override
  Future<ExportJob> getById(String id) => _service.getExportJobById(id);

  @override
  Future<List<ExportJob>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getExportJobs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ExportJob> create(ExportJob item) => _service.createExportJob(item);

  @override
  Future<ExportJob> update(String id, ExportJob item) => _service.updateExportJob(id, item);

  @override
  Future<void> delete(String id) => _service.deleteExportJob(id);
}
