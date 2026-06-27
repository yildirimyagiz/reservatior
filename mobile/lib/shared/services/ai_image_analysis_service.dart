import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiImageAnalysisService {
  final DioClient _dioClient;
  AiImageAnalysisService(this._dioClient);

  Future<AiImageAnalysis> getAiImageAnalysisById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiImageAnalyses}/$id');
    return AiImageAnalysis.fromJson(response.data['data']);
  }

  Future<List<AiImageAnalysis>> getAiImageAnalysises({
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
    final response = await _dioClient.get(ApiEndpoints.aiImageAnalyses, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiImageAnalysis.fromJson(json)).toList();
  }

  Future<AiImageAnalysis> createAiImageAnalysis(AiImageAnalysis item) async {
    final response = await _dioClient.post(ApiEndpoints.aiImageAnalyses, data: item.toJson());
    return AiImageAnalysis.fromJson(response.data['data']);
  }

  Future<AiImageAnalysis> updateAiImageAnalysis(String id, AiImageAnalysis item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiImageAnalyses}/$id', data: item.toJson());
    return AiImageAnalysis.fromJson(response.data['data']);
  }

  Future<void> deleteAiImageAnalysis(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiImageAnalyses}/$id');
  }
}
