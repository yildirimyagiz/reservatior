import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/lease_service.dart';

abstract class LeaseRepository {
  Future<Lease> getById(String id);
  Future<List<Lease>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Lease> create(Lease item);
  Future<Lease> update(String id, Lease item);
  Future<void> delete(String id);
}

class LeaseRepositoryImpl implements LeaseRepository {
  final LeaseService _service;
  LeaseRepositoryImpl(this._service);

  @override
  Future<Lease> getById(String id) => _service.getLeaseById(id);

  @override
  Future<List<Lease>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getLeases(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Lease> create(Lease item) => _service.createLease(item);

  @override
  Future<Lease> update(String id, Lease item) => _service.updateLease(id, item);

  @override
  Future<void> delete(String id) => _service.deleteLease(id);
}
