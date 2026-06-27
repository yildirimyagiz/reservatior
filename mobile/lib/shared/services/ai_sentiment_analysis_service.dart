import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiSentimentAnalysisService {
  final DioClient _dioClient;
  AiSentimentAnalysisService(this._dioClient);

  Future<AiSentimentAnalysis> getAiSentimentAnalysisById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiSentimentAnalyses}/$id');
    return AiSentimentAnalysis.fromJson(response.data['data']);
  }

  Future<List<AiSentimentAnalysis>> getAiSentimentAnalysises({
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
    final response = await _dioClient.get(ApiEndpoints.aiSentimentAnalyses, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiSentimentAnalysis.fromJson(json)).toList();
  }

  Future<AiSentimentAnalysis> createAiSentimentAnalysis(AiSentimentAnalysis item) async {
    final response = await _dioClient.post(ApiEndpoints.aiSentimentAnalyses, data: item.toJson());
    return AiSentimentAnalysis.fromJson(response.data['data']);
  }

  Future<AiSentimentAnalysis> updateAiSentimentAnalysis(String id, AiSentimentAnalysis item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiSentimentAnalyses}/$id', data: item.toJson());
    return AiSentimentAnalysis.fromJson(response.data['data']);
  }

  Future<void> deleteAiSentimentAnalysis(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiSentimentAnalyses}/$id');
  }
}
