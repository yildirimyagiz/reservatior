import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Message operations
/// Provides CRUD operations with proper error handling and type safety
class MessageRepository {
  final DioClient _dioClient;

  MessageRepository(this._dioClient);

  /// Get Message by ID
  /// Returns [Message] if found, throws [RepositoryException] otherwise
  Future<Message> getMessageById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/message/$id');
      if (response.statusCode == 200) {
        return Message.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch message',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all messages with pagination and filtering
  /// Returns list of [Message] objects
  Future<List<Message>> getmessages({
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
      
      final response = await _dioClient.get('/api/v1/message', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Message.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch messages',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Message
  /// Returns created [Message] object
  Future<Message> createMessage(Message message) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/message',
        data: message.toJson(),
      );
      return Message.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Message
  Future<Message> updateMessage(String id, Message message) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/message/$id',
        data: message.toJson(),
      );
      return Message.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Message
  Future<void> deleteMessage(String id) async {
    try {
      await _dioClient.delete('/api/v1/message/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
