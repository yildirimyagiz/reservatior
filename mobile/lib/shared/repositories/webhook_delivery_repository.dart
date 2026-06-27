import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/webhook_delivery_service.dart';

abstract class WebhookDeliveryRepository {
  Future<WebhookDelivery> getById(String id);
  Future<List<WebhookDelivery>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<WebhookDelivery> create(WebhookDelivery item);
  Future<WebhookDelivery> update(String id, WebhookDelivery item);
  Future<void> delete(String id);
}

class WebhookDeliveryRepositoryImpl implements WebhookDeliveryRepository {
  final WebhookDeliveryService _service;
  WebhookDeliveryRepositoryImpl(this._service);

  @override
  Future<WebhookDelivery> getById(String id) => _service.getWebhookDeliveryById(id);

  @override
  Future<List<WebhookDelivery>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getWebhookDeliveries(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<WebhookDelivery> create(WebhookDelivery item) => _service.createWebhookDelivery(item);

  @override
  Future<WebhookDelivery> update(String id, WebhookDelivery item) => _service.updateWebhookDelivery(id, item);

  @override
  Future<void> delete(String id) => _service.deleteWebhookDelivery(id);
}
