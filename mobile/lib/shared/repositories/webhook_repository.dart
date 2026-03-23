import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Webhook operations
/// Provides CRUD operations with proper error handling and type safety
class WebhookRepository {
  final DioClient _dioClient;

  WebhookRepository(this._dioClient);

  /// Get Webhook by ID
  /// Returns [Webhook] if found, throws [RepositoryException] otherwise
  Future<Webhook> getWebhookById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/webhook/$id');
      if (response.statusCode == 200) {
        return Webhook.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch webhook',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all webhooks with pagination and filtering
  /// Returns list of [Webhook] objects
  Future<List<Webhook>> getwebhooks({
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
      
      final response = await _dioClient.get('/api/v1/webhook', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Webhook.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch webhooks',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Webhook
  /// Returns created [Webhook] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
