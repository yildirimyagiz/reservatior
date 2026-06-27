import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/analysis_job_service.dart';

abstract class AnalysisJobRepository {
  Future<AnalysisJob> getById(String id);
  Future<List<AnalysisJob>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AnalysisJob> create(AnalysisJob item);
  Future<AnalysisJob> update(String id, AnalysisJob item);
  Future<void> delete(String id);
}

class AnalysisJobRepositoryImpl implements AnalysisJobRepository {
  final AnalysisJobService _service;
  AnalysisJobRepositoryImpl(this._service);

  @override
  Future<AnalysisJob> getById(String id) => _service.getAnalysisJobById(id);

  @override
  Future<List<AnalysisJob>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAnalysisJobs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AnalysisJob> create(AnalysisJob item) => _service.createAnalysisJob(item);

  @override
  Future<AnalysisJob> update(String id, AnalysisJob item) => _service.updateAnalysisJob(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAnalysisJob(id);
}
