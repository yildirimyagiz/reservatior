import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiLeadScoringService {
  final DioClient _dioClient;
  AiLeadScoringService(this._dioClient);

  Future<AiLeadScoring> getAiLeadScoringById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiLeadScores}/$id');
    return AiLeadScoring.fromJson(response.data['data']);
  }

  Future<List<AiLeadScoring>> getAiLeadScorings({
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
    return data.map((json) => AiLeadScoring.fromJson(json)).toList();
  }

  Future<AiLeadScoring> createAiLeadScoring(AiLeadScoring item) async {
    final response = await _dioClient.post(ApiEndpoints.aiLeadScores, data: item.toJson());
    return AiLeadScoring.fromJson(response.data['data']);
  }

  Future<AiLeadScoring> updateAiLeadScoring(String id, AiLeadScoring item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiLeadScores}/$id', data: item.toJson());
    return AiLeadScoring.fromJson(response.data['data']);
  }

  Future<void> deleteAiLeadScoring(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiLeadScores}/$id');
  }
}
