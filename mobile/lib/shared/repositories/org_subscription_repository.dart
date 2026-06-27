import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/org_subscription_service.dart';

abstract class OrgSubscriptionRepository {
  Future<OrgSubscription> getById(String id);
  Future<List<OrgSubscription>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<OrgSubscription> create(OrgSubscription item);
  Future<OrgSubscription> update(String id, OrgSubscription item);
  Future<void> delete(String id);
}

class OrgSubscriptionRepositoryImpl implements OrgSubscriptionRepository {
  final OrgSubscriptionService _service;
  OrgSubscriptionRepositoryImpl(this._service);

  @override
  Future<OrgSubscription> getById(String id) => _service.getOrgSubscriptionById(id);

  @override
  Future<List<OrgSubscription>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getOrgSubscriptions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<OrgSubscription> create(OrgSubscription item) => _service.createOrgSubscription(item);

  @override
  Future<OrgSubscription> update(String id, OrgSubscription item) => _service.updateOrgSubscription(id, item);

  @override
  Future<void> delete(String id) => _service.deleteOrgSubscription(id);
}
