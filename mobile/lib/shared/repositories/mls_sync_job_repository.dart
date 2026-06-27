import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mls_sync_job_service.dart';

abstract class MlsSyncJobRepository {
  Future<MlsSyncJob> getById(String id);
  Future<List<MlsSyncJob>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MlsSyncJob> create(MlsSyncJob item);
  Future<MlsSyncJob> update(String id, MlsSyncJob item);
  Future<void> delete(String id);
}

class MlsSyncJobRepositoryImpl implements MlsSyncJobRepository {
  final MlsSyncJobService _service;
  MlsSyncJobRepositoryImpl(this._service);

  @override
  Future<MlsSyncJob> getById(String id) => _service.getMlsSyncJobById(id);

  @override
  Future<List<MlsSyncJob>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMlsSyncJobs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MlsSyncJob> create(MlsSyncJob item) => _service.createMlsSyncJob(item);

  @override
  Future<MlsSyncJob> update(String id, MlsSyncJob item) => _service.updateMlsSyncJob(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMlsSyncJob(id);
}
