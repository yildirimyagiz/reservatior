import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/webhook_service.dart';

abstract class WebhookRepository {
  Future<Webhook> getById(String id);
  Future<List<Webhook>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Webhook> create(Webhook item);
  Future<Webhook> update(String id, Webhook item);
  Future<void> delete(String id);
}

class WebhookRepositoryImpl implements WebhookRepository {
  final WebhookService _service;
  WebhookRepositoryImpl(this._service);

  @override
  Future<Webhook> getById(String id) => _service.getWebhookById(id);

  @override
  Future<List<Webhook>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getWebhooks(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Webhook> create(Webhook item) => _service.createWebhook(item);

  @override
  Future<Webhook> update(String id, Webhook item) => _service.updateWebhook(id, item);

  @override
  Future<void> delete(String id) => _service.deleteWebhook(id);
}
