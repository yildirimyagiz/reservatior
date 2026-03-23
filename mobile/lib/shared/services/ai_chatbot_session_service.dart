import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIChatbotSessionService {
  final DioClient _dioClient;

  AIChatbotSessionService(this._dioClient);

  // Get AIChatbotSession by ID
  Future<AIChatbotSession> getAIChatbotSessionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_chatbot_session/$id');
      return AIChatbotSession.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_chatbot_sessions
  Future<List<AIChatbotSession>> getAIChatbotSessions({
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

      final response = await _dioClient.get('/api/v1/ai_chatbot_session', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIChatbotSession.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIChatbotSession
  Future<AIChatbotSession> createAIChatbotSession(AIChatbotSession aIChatbotSession) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_chatbot_session',
        data: aIChatbotSession.toJson(),
      );
      return AIChatbotSession.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIChatbotSession
  Future<AIChatbotSession> updateAIChatbotSession(String id, AIChatbotSession aIChatbotSession) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_chatbot_session/$id',
        data: aIChatbotSession.toJson(),
      );
      return AIChatbotSession.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIChatbotSession
  Future<void> deleteAIChatbotSession(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_chatbot_session/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
