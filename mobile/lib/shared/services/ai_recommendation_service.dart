import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIRecommendationService {
  final DioClient _dioClient;

  AIRecommendationService(this._dioClient);

  // Get AIRecommendation by ID
  Future<AIRecommendation> getAIRecommendationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_recommendation/$id');
      return AIRecommendation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_recommendations
  Future<List<AIRecommendation>> getAIRecommendations({
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

      final response = await _dioClient.get('/api/v1/ai_recommendation', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIRecommendation.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIRecommendation
  Future<AIRecommendation> createAIRecommendation(AIRecommendation aIRecommendation) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_recommendation',
        data: aIRecommendation.toJson(),
      );
      return AIRecommendation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIRecommendation
  Future<AIRecommendation> updateAIRecommendation(String id, AIRecommendation aIRecommendation) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_recommendation/$id',
        data: aIRecommendation.toJson(),
      );
      return AIRecommendation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIRecommendation
  Future<void> deleteAIRecommendation(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_recommendation/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
