import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiChatHandoff operations
/// Provides CRUD operations with proper error handling and type safety
class AiChatHandoffRepository {
  final DioClient _dioClient;

  AiChatHandoffRepository(this._dioClient);

  /// Get AiChatHandoff by ID
  /// Returns [AiChatHandoff] if found, throws [RepositoryException] otherwise
  Future<AiChatHandoff> getAiChatHandoffById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_chat_handoff/$id');
      if (response.statusCode == 200) {
        return AiChatHandoff.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_chat_handoff',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_chat_handoffs with pagination and filtering
  /// Returns list of [AiChatHandoff] objects
  Future<List<AiChatHandoff>> getai_chat_handoffs({
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
      
      final response = await _dioClient.get('/api/v1/ai_chat_handoff', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiChatHandoff.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_chat_handoffs',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiChatHandoff
  /// Returns created [AiChatHandoff] object
  Future<AiChatHandoff> createAiChatHandoff(AiChatHandoff aiChatHandoff) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_chat_handoff',
        data: aiChatHandoff.toJson(),
      );
      return AiChatHandoff.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiChatHandoff
  Future<AiChatHandoff> updateAiChatHandoff(String id, AiChatHandoff aiChatHandoff) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_chat_handoff/$id',
        data: aiChatHandoff.toJson(),
      );
      return AiChatHandoff.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiChatHandoff
  Future<void> deleteAiChatHandoff(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_chat_handoff/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
