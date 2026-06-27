import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiRecommendationService {
  final DioClient _dioClient;
  AiRecommendationService(this._dioClient);

  Future<AiRecommendation> getAiRecommendationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiRecommendations}/$id');
    return AiRecommendation.fromJson(response.data['data']);
  }

  Future<List<AiRecommendation>> getAiRecommendations({
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
    final response = await _dioClient.get(ApiEndpoints.aiRecommendations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiRecommendation.fromJson(json)).toList();
  }

  Future<AiRecommendation> createAiRecommendation(AiRecommendation item) async {
    final response = await _dioClient.post(ApiEndpoints.aiRecommendations, data: item.toJson());
    return AiRecommendation.fromJson(response.data['data']);
  }

  Future<AiRecommendation> updateAiRecommendation(String id, AiRecommendation item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiRecommendations}/$id', data: item.toJson());
    return AiRecommendation.fromJson(response.data['data']);
  }

  Future<void> deleteAiRecommendation(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiRecommendations}/$id');
  }
}
