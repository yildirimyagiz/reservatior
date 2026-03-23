import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AiChatbotSession operations
/// Provides CRUD operations with proper error handling and type safety
class AiChatbotSessionRepository {
  final DioClient _dioClient;

  AiChatbotSessionRepository(this._dioClient);

  /// Get AiChatbotSession by ID
  /// Returns [AiChatbotSession] if found, throws [RepositoryException] otherwise
  Future<AiChatbotSession> getAiChatbotSessionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_chatbot_session/$id');
      if (response.statusCode == 200) {
        return AiChatbotSession.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_chatbot_session',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ai_chatbot_sessions with pagination and filtering
  /// Returns list of [AiChatbotSession] objects
  Future<List<AiChatbotSession>> getai_chatbot_sessions({
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
      
      final response = await _dioClient.get('/api/v1/ai_chatbot_session', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AiChatbotSession.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ai_chatbot_sessions',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AiChatbotSession
  /// Returns created [AiChatbotSession] object
  Future<AiChatbotSession> createAiChatbotSession(AiChatbotSession aiChatbotSession) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_chatbot_session',
        data: aiChatbotSession.toJson(),
      );
      return AiChatbotSession.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AiChatbotSession
  Future<AiChatbotSession> updateAiChatbotSession(String id, AiChatbotSession aiChatbotSession) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_chatbot_session/$id',
        data: aiChatbotSession.toJson(),
      );
      return AiChatbotSession.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AiChatbotSession
  Future<void> deleteAiChatbotSession(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_chatbot_session/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
