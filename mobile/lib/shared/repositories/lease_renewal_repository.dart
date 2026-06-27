import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/lease_renewal_service.dart';

abstract class LeaseRenewalRepository {
  Future<LeaseRenewal> getById(String id);
  Future<List<LeaseRenewal>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<LeaseRenewal> create(LeaseRenewal item);
  Future<LeaseRenewal> update(String id, LeaseRenewal item);
  Future<void> delete(String id);
}

class LeaseRenewalRepositoryImpl implements LeaseRenewalRepository {
  final LeaseRenewalService _service;
  LeaseRenewalRepositoryImpl(this._service);

  @override
  Future<LeaseRenewal> getById(String id) => _service.getLeaseRenewalById(id);

  @override
  Future<List<LeaseRenewal>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getLeaseRenewals(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<LeaseRenewal> create(LeaseRenewal item) => _service.createLeaseRenewal(item);

  @override
  Future<LeaseRenewal> update(String id, LeaseRenewal item) => _service.updateLeaseRenewal(id, item);

  @override
  Future<void> delete(String id) => _service.deleteLeaseRenewal(id);
}
