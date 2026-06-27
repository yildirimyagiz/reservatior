import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/escrow_dispute_service.dart';

abstract class EscrowDisputeRepository {
  Future<EscrowDispute> getById(String id);
  Future<List<EscrowDispute>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<EscrowDispute> create(EscrowDispute item);
  Future<EscrowDispute> update(String id, EscrowDispute item);
  Future<void> delete(String id);
}

class EscrowDisputeRepositoryImpl implements EscrowDisputeRepository {
  final EscrowDisputeService _service;
  EscrowDisputeRepositoryImpl(this._service);

  @override
  Future<EscrowDispute> getById(String id) => _service.getEscrowDisputeById(id);

  @override
  Future<List<EscrowDispute>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getEscrowDisputes(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<EscrowDispute> create(EscrowDispute item) => _service.createEscrowDispute(item);

  @override
  Future<EscrowDispute> update(String id, EscrowDispute item) => _service.updateEscrowDispute(id, item);

  @override
  Future<void> delete(String id) => _service.deleteEscrowDispute(id);
}
