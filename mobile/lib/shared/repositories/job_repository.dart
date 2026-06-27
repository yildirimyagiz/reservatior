import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/job_service.dart';

abstract class JobRepository {
  Future<Job> getById(String id);
  Future<List<Job>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Job> create(Job item);
  Future<Job> update(String id, Job item);
  Future<void> delete(String id);
}

class JobRepositoryImpl implements JobRepository {
  final JobService _service;
  JobRepositoryImpl(this._service);

  @override
  Future<Job> getById(String id) => _service.getJobById(id);

  @override
  Future<List<Job>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getJobs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Job> create(Job item) => _service.createJob(item);

  @override
  Future<Job> update(String id, Job item) => _service.updateJob(id, item);

  @override
  Future<void> delete(String id) => _service.deleteJob(id);
}
