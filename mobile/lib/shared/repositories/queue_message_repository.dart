import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for QueueMessage operations
/// Provides CRUD operations with proper error handling and type safety
class QueueMessageRepository {
  final DioClient _dioClient;

  QueueMessageRepository(this._dioClient);

  /// Get QueueMessage by ID
  /// Returns [QueueMessage] if found, throws [RepositoryException] otherwise
  Future<QueueMessage> getQueueMessageById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/queue_message/$id');
      if (response.statusCode == 200) {
        return QueueMessage.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch queue_message',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all queue_messages with pagination and filtering
  /// Returns list of [QueueMessage] objects
  Future<List<QueueMessage>> getqueue_messages({
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
      
      final response = await _dioClient.get('/api/v1/queue_message', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => QueueMessage.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch queue_messages',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new QueueMessage
  /// Returns created [QueueMessage] object
  Future<QueueMessage> createQueueMessage(QueueMessage queueMessage) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/queue_message',
        data: queueMessage.toJson(),
      );
      return QueueMessage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update QueueMessage
  Future<QueueMessage> updateQueueMessage(String id, QueueMessage queueMessage) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/queue_message/$id',
        data: queueMessage.toJson(),
      );
      return QueueMessage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete QueueMessage
  Future<void> deleteQueueMessage(String id) async {
    try {
      await _dioClient.delete('/api/v1/queue_message/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
