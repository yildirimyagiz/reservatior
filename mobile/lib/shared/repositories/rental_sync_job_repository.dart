import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/rental_sync_job_service.dart';

abstract class RentalSyncJobRepository {
  Future<RentalSyncJob> getById(String id);
  Future<List<RentalSyncJob>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<RentalSyncJob> create(RentalSyncJob item);
  Future<RentalSyncJob> update(String id, RentalSyncJob item);
  Future<void> delete(String id);
}

class RentalSyncJobRepositoryImpl implements RentalSyncJobRepository {
  final RentalSyncJobService _service;
  RentalSyncJobRepositoryImpl(this._service);

  @override
  Future<RentalSyncJob> getById(String id) => _service.getRentalSyncJobById(id);

  @override
  Future<List<RentalSyncJob>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getRentalSyncJobs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<RentalSyncJob> create(RentalSyncJob item) => _service.createRentalSyncJob(item);

  @override
  Future<RentalSyncJob> update(String id, RentalSyncJob item) => _service.updateRentalSyncJob(id, item);

  @override
  Future<void> delete(String id) => _service.deleteRentalSyncJob(id);
}
