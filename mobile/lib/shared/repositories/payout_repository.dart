import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/payout_service.dart';

abstract class PayoutRepository {
  Future<Payout> getById(String id);
  Future<List<Payout>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Payout> create(Payout item);
  Future<Payout> update(String id, Payout item);
  Future<void> delete(String id);
}

class PayoutRepositoryImpl implements PayoutRepository {
  final PayoutService _service;
  PayoutRepositoryImpl(this._service);

  @override
  Future<Payout> getById(String id) => _service.getPayoutById(id);

  @override
  Future<List<Payout>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPayouts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Payout> create(Payout item) => _service.createPayout(item);

  @override
  Future<Payout> update(String id, Payout item) => _service.updatePayout(id, item);

  @override
  Future<void> delete(String id) => _service.deletePayout(id);
}
