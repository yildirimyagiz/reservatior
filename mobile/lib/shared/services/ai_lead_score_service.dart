import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AILeadScoreService {
  final DioClient _dioClient;

  AILeadScoreService(this._dioClient);

  // Get AILeadScore by ID
  Future<AILeadScore> getAILeadScoreById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_lead_score/$id');
      return AILeadScore.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_lead_scores
  Future<List<AILeadScore>> getAILeadScores({
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

      final response = await _dioClient.get('/api/v1/ai_lead_score', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AILeadScore.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AILeadScore
  Future<AILeadScore> createAILeadScore(AILeadScore aILeadScore) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_lead_score',
        data: aILeadScore.toJson(),
      );
      return AILeadScore.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AILeadScore
  Future<AILeadScore> updateAILeadScore(String id, AILeadScore aILeadScore) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_lead_score/$id',
        data: aILeadScore.toJson(),
      );
      return AILeadScore.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AILeadScore
  Future<void> deleteAILeadScore(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_lead_score/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
