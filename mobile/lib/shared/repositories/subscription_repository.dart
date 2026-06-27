import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/subscription_service.dart';

abstract class SubscriptionRepository {
  Future<Subscription> getById(String id);
  Future<List<Subscription>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Subscription> create(Subscription item);
  Future<Subscription> update(String id, Subscription item);
  Future<void> delete(String id);
}

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionService _service;
  SubscriptionRepositoryImpl(this._service);

  @override
  Future<Subscription> getById(String id) => _service.getSubscriptionById(id);

  @override
  Future<List<Subscription>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSubscriptions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Subscription> create(Subscription item) => _service.createSubscription(item);

  @override
  Future<Subscription> update(String id, Subscription item) => _service.updateSubscription(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSubscription(id);
}
