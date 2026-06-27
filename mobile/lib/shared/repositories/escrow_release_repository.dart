import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/escrow_release_service.dart';

abstract class EscrowReleaseRepository {
  Future<EscrowRelease> getById(String id);
  Future<List<EscrowRelease>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<EscrowRelease> create(EscrowRelease item);
  Future<EscrowRelease> update(String id, EscrowRelease item);
  Future<void> delete(String id);
}

class EscrowReleaseRepositoryImpl implements EscrowReleaseRepository {
  final EscrowReleaseService _service;
  EscrowReleaseRepositoryImpl(this._service);

  @override
  Future<EscrowRelease> getById(String id) => _service.getEscrowReleaseById(id);

  @override
  Future<List<EscrowRelease>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getEscrowReleases(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<EscrowRelease> create(EscrowRelease item) => _service.createEscrowRelease(item);

  @override
  Future<EscrowRelease> update(String id, EscrowRelease item) => _service.updateEscrowRelease(id, item);

  @override
  Future<void> delete(String id) => _service.deleteEscrowRelease(id);
}
