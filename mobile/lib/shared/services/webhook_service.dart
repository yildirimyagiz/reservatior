import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class WebhookService {
  final DioClient _dioClient;

  WebhookService(this._dioClient);

  // Get Webhook by ID
  Future<Webhook> getWebhookById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/webhook/$id');
      return Webhook.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all webhooks
  Future<List<Webhook>> getWebhooks({
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

      final response = await _dioClient.get('/api/v1/webhook', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Webhook.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Webhook
  Future<Webhook> createWebhook(Webhook webhook) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/webhook',
        data: webhook.toJson(),
      );
      return Webhook.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Webhook
  Future<Webhook> updateWebhook(String id, Webhook webhook) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/webhook/$id',
        data: webhook.toJson(),
      );
      return Webhook.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Webhook
  Future<void> deleteWebhook(String id) async {
    try {
      await _dioClient.delete('/api/v1/webhook/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
