import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class WebhookDeliveryService {
  final DioClient _dioClient;
  WebhookDeliveryService(this._dioClient);

  Future<WebhookDelivery> getWebhookDeliveryById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.webhookDeliveries}/$id');
    return WebhookDelivery.fromJson(response.data['data']);
  }

  Future<List<WebhookDelivery>> getWebhookDeliveries({
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
    final response = await _dioClient.get(ApiEndpoints.webhookDeliveries, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => WebhookDelivery.fromJson(json)).toList();
  }

  Future<WebhookDelivery> createWebhookDelivery(WebhookDelivery item) async {
    final response = await _dioClient.post(ApiEndpoints.webhookDeliveries, data: item.toJson());
    return WebhookDelivery.fromJson(response.data['data']);
  }

  Future<WebhookDelivery> updateWebhookDelivery(String id, WebhookDelivery item) async {
    final response = await _dioClient.patch('${ApiEndpoints.webhookDeliveries}/$id', data: item.toJson());
    return WebhookDelivery.fromJson(response.data['data']);
  }

  Future<void> deleteWebhookDelivery(String id) async {
    await _dioClient.delete('${ApiEndpoints.webhookDeliveries}/$id');
  }
}
