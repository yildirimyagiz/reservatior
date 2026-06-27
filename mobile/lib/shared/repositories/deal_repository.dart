import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/deal_service.dart';

abstract class DealRepository {
  Future<Deal> getById(String id);
  Future<List<Deal>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Deal> create(Deal item);
  Future<Deal> update(String id, Deal item);
  Future<void> delete(String id);
}

class DealRepositoryImpl implements DealRepository {
  final DealService _service;
  DealRepositoryImpl(this._service);

  @override
  Future<Deal> getById(String id) => _service.getDealById(id);

  @override
  Future<List<Deal>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getDeals(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Deal> create(Deal item) => _service.createDeal(item);

  @override
  Future<Deal> update(String id, Deal item) => _service.updateDeal(id, item);

  @override
  Future<void> delete(String id) => _service.deleteDeal(id);
}
