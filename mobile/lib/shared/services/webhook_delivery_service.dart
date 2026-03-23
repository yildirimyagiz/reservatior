import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class WebhookDeliveryService {
  final DioClient _dioClient;

  WebhookDeliveryService(this._dioClient);

  // Get WebhookDelivery by ID
  Future<WebhookDelivery> getWebhookDeliveryById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/webhook_delivery/$id');
      return WebhookDelivery.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all webhook_deliverys
  Future<List<WebhookDelivery>> getWebhookDeliverys({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/webhook_delivery', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => WebhookDelivery.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create WebhookDelivery
  Future<WebhookDelivery> createWebhookDelivery(WebhookDelivery webhookDelivery) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/webhook_delivery',
        data: webhookDelivery.toJson(),
      );
      return WebhookDelivery.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update WebhookDelivery
  Future<WebhookDelivery> updateWebhookDelivery(String id, WebhookDelivery webhookDelivery) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/webhook_delivery/$id',
        data: webhookDelivery.toJson(),
      );
      return WebhookDelivery.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete WebhookDelivery
  Future<void> deleteWebhookDelivery(String id) async {
    try {
      await _dioClient.delete('/api/v1/webhook_delivery/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
