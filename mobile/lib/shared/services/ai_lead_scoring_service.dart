import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AILeadScoringService {
  final DioClient _dioClient;

  AILeadScoringService(this._dioClient);

  // Get AILeadScoring by ID
  Future<AILeadScoring> getAILeadScoringById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_lead_scoring/$id');
      return AILeadScoring.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_lead_scorings
  Future<List<AILeadScoring>> getAILeadScorings({
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

      final response = await _dioClient.get('/api/v1/ai_lead_scoring', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AILeadScoring.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AILeadScoring
  Future<AILeadScoring> createAILeadScoring(AILeadScoring aILeadScoring) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_lead_scoring',
        data: aILeadScoring.toJson(),
      );
      return AILeadScoring.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AILeadScoring
  Future<AILeadScoring> updateAILeadScoring(String id, AILeadScoring aILeadScoring) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_lead_scoring/$id',
        data: aILeadScoring.toJson(),
      );
      return AILeadScoring.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AILeadScoring
  Future<void> deleteAILeadScoring(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_lead_scoring/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
