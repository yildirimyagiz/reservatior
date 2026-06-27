import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/escrow_status_history_service.dart';

abstract class EscrowStatusHistoryRepository {
  Future<EscrowStatusHistory> getById(String id);
  Future<List<EscrowStatusHistory>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<EscrowStatusHistory> create(EscrowStatusHistory item);
  Future<EscrowStatusHistory> update(String id, EscrowStatusHistory item);
  Future<void> delete(String id);
}

class EscrowStatusHistoryRepositoryImpl implements EscrowStatusHistoryRepository {
  final EscrowStatusHistoryService _service;
  EscrowStatusHistoryRepositoryImpl(this._service);

  @override
  Future<EscrowStatusHistory> getById(String id) => _service.getEscrowStatusHistoryById(id);

  @override
  Future<List<EscrowStatusHistory>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getEscrowStatusHistories(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<EscrowStatusHistory> create(EscrowStatusHistory item) => _service.createEscrowStatusHistory(item);

  @override
  Future<EscrowStatusHistory> update(String id, EscrowStatusHistory item) => _service.updateEscrowStatusHistory(id, item);

  @override
  Future<void> delete(String id) => _service.deleteEscrowStatusHistory(id);
}
