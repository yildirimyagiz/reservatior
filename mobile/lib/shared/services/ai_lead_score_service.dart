import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiLeadScoreService {
  final DioClient _dioClient;
  AiLeadScoreService(this._dioClient);

  Future<AiLeadScore> getAiLeadScoreById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiLeadScores}/$id');
    return AiLeadScore.fromJson(response.data['data']);
  }

  Future<List<AiLeadScore>> getAiLeadScores({
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
    final response = await _dioClient.get(ApiEndpoints.aiLeadScores, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiLeadScore.fromJson(json)).toList();
  }

  Future<AiLeadScore> createAiLeadScore(AiLeadScore item) async {
    final response = await _dioClient.post(ApiEndpoints.aiLeadScores, data: item.toJson());
    return AiLeadScore.fromJson(response.data['data']);
  }

  Future<AiLeadScore> updateAiLeadScore(String id, AiLeadScore item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiLeadScores}/$id', data: item.toJson());
    return AiLeadScore.fromJson(response.data['data']);
  }

  Future<void> deleteAiLeadScore(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiLeadScores}/$id');
  }
}
