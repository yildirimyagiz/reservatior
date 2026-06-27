import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/commission_service.dart';

abstract class CommissionRepository {
  Future<Commission> getById(String id);
  Future<List<Commission>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Commission> create(Commission item);
  Future<Commission> update(String id, Commission item);
  Future<void> delete(String id);
}

class CommissionRepositoryImpl implements CommissionRepository {
  final CommissionService _service;
  CommissionRepositoryImpl(this._service);

  @override
  Future<Commission> getById(String id) => _service.getCommissionById(id);

  @override
  Future<List<Commission>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getCommissions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Commission> create(Commission item) => _service.createCommission(item);

  @override
  Future<Commission> update(String id, Commission item) => _service.updateCommission(id, item);

  @override
  Future<void> delete(String id) => _service.deleteCommission(id);
}
