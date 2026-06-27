import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/scraping_job_service.dart';

abstract class ScrapingJobRepository {
  Future<ScrapingJob> getById(String id);
  Future<List<ScrapingJob>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ScrapingJob> create(ScrapingJob item);
  Future<ScrapingJob> update(String id, ScrapingJob item);
  Future<void> delete(String id);
}

class ScrapingJobRepositoryImpl implements ScrapingJobRepository {
  final ScrapingJobService _service;
  ScrapingJobRepositoryImpl(this._service);

  @override
  Future<ScrapingJob> getById(String id) => _service.getScrapingJobById(id);

  @override
  Future<List<ScrapingJob>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getScrapingJobs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ScrapingJob> create(ScrapingJob item) => _service.createScrapingJob(item);

  @override
  Future<ScrapingJob> update(String id, ScrapingJob item) => _service.updateScrapingJob(id, item);

  @override
  Future<void> delete(String id) => _service.deleteScrapingJob(id);
}
