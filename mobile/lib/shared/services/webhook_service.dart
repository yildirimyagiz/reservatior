import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class WebhookService {
  final DioClient _dioClient;
  WebhookService(this._dioClient);

  Future<Webhook> getWebhookById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.webhooks}/$id');
    return Webhook.fromJson(response.data['data']);
  }

  Future<List<Webhook>> getWebhooks({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.webhooks, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Webhook.fromJson(json)).toList();
  }

  Future<Webhook> createWebhook(Webhook item) async {
    final response = await _dioClient.post(ApiEndpoints.webhooks, data: item.toJson());
    return Webhook.fromJson(response.data['data']);
  }

  Future<Webhook> updateWebhook(String id, Webhook item) async {
    final response = await _dioClient.patch('${ApiEndpoints.webhooks}/$id', data: item.toJson());
    return Webhook.fromJson(response.data['data']);
  }

  Future<void> deleteWebhook(String id) async {
    await _dioClient.delete('${ApiEndpoints.webhooks}/$id');
  }
}
