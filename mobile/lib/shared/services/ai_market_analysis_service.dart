import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiMarketAnalysisService {
  final DioClient _dioClient;
  AiMarketAnalysisService(this._dioClient);

  Future<AiMarketAnalysis> getAiMarketAnalysisById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiMarketAnalyses}/$id');
    return AiMarketAnalysis.fromJson(response.data['data']);
  }

  Future<List<AiMarketAnalysis>> getAiMarketAnalysises({
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
    final response = await _dioClient.get(ApiEndpoints.aiMarketAnalyses, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiMarketAnalysis.fromJson(json)).toList();
  }

  Future<AiMarketAnalysis> createAiMarketAnalysis(AiMarketAnalysis item) async {
    final response = await _dioClient.post(ApiEndpoints.aiMarketAnalyses, data: item.toJson());
    return AiMarketAnalysis.fromJson(response.data['data']);
  }

  Future<AiMarketAnalysis> updateAiMarketAnalysis(String id, AiMarketAnalysis item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiMarketAnalyses}/$id', data: item.toJson());
    return AiMarketAnalysis.fromJson(response.data['data']);
  }

  Future<void> deleteAiMarketAnalysis(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiMarketAnalyses}/$id');
  }
}
