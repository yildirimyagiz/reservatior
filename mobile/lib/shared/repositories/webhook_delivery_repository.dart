import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for WebhookDelivery operations
/// Provides CRUD operations with proper error handling and type safety
class WebhookDeliveryRepository {
  final DioClient _dioClient;

  WebhookDeliveryRepository(this._dioClient);

  /// Get WebhookDelivery by ID
  /// Returns [WebhookDelivery] if found, throws [RepositoryException] otherwise
  Future<WebhookDelivery> getWebhookDeliveryById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/webhook_delivery/$id');
      if (response.statusCode == 200) {
        return WebhookDelivery.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch webhook_delivery',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all webhook_deliveries with pagination and filtering
  /// Returns list of [WebhookDelivery] objects
  Future<List<WebhookDelivery>> getwebhook_deliveries({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/webhook_delivery', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => WebhookDelivery.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch webhook_deliveries',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new WebhookDelivery
  /// Returns created [WebhookDelivery] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
