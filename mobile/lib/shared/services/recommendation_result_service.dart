import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class RecommendationResultService {
  final DioClient _dioClient;
  RecommendationResultService(this._dioClient);

  Future<RecommendationResult> getRecommendationResultById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.recommendationResults}/$id');
    return RecommendationResult.fromJson(response.data['data']);
  }

  Future<List<RecommendationResult>> getRecommendationResults({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.recommendationResults, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => RecommendationResult.fromJson(json)).toList();
  }

  Future<RecommendationResult> createRecommendationResult(RecommendationResult item) async {
    final response = await _dioClient.post(ApiEndpoints.recommendationResults, data: item.toJson());
    return RecommendationResult.fromJson(response.data['data']);
  }

  Future<RecommendationResult> updateRecommendationResult(String id, RecommendationResult item) async {
    final response = await _dioClient.patch('${ApiEndpoints.recommendationResults}/$id', data: item.toJson());
    return RecommendationResult.fromJson(response.data['data']);
  }

  Future<void> deleteRecommendationResult(String id) async {
    await _dioClient.delete('${ApiEndpoints.recommendationResults}/$id');
  }
}
