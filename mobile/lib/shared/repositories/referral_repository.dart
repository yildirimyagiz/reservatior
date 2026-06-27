import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/referral_service.dart';

abstract class ReferralRepository {
  Future<Referral> getById(String id);
  Future<List<Referral>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Referral> create(Referral item);
  Future<Referral> update(String id, Referral item);
  Future<void> delete(String id);
}

class ReferralRepositoryImpl implements ReferralRepository {
  final ReferralService _service;
  ReferralRepositoryImpl(this._service);

  @override
  Future<Referral> getById(String id) => _service.getReferralById(id);

  @override
  Future<List<Referral>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getReferrals(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Referral> create(Referral item) => _service.createReferral(item);

  @override
  Future<Referral> update(String id, Referral item) => _service.updateReferral(id, item);

  @override
  Future<void> delete(String id) => _service.deleteReferral(id);
}
