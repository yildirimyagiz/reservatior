import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class RecommendationResultService {
  final DioClient _dioClient;

  RecommendationResultService(this._dioClient);

  // Get RecommendationResult by ID
  Future<RecommendationResult> getRecommendationResultById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/recommendation_result/$id');
      return RecommendationResult.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all recommendation_results
  Future<List<RecommendationResult>> getRecommendationResults({
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

      final response = await _dioClient.get('/api/v1/recommendation_result', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => RecommendationResult.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create RecommendationResult
  Future<RecommendationResult> createRecommendationResult(RecommendationResult recommendationResult) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/recommendation_result',
        data: recommendationResult.toJson(),
      );
      return RecommendationResult.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RecommendationResult
  Future<RecommendationResult> updateRecommendationResult(String id, RecommendationResult recommendationResult) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/recommendation_result/$id',
        data: recommendationResult.toJson(),
      );
      return RecommendationResult.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RecommendationResult
  Future<void> deleteRecommendationResult(String id) async {
    try {
      await _dioClient.delete('/api/v1/recommendation_result/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
