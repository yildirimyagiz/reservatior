import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiInvestmentAnalysisService {
  final DioClient _dioClient;
  AiInvestmentAnalysisService(this._dioClient);

  Future<AiInvestmentAnalysis> getAiInvestmentAnalysisById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiInvestmentAnalyses}/$id');
    return AiInvestmentAnalysis.fromJson(response.data['data']);
  }

  Future<List<AiInvestmentAnalysis>> getAiInvestmentAnalysises({
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
    final response = await _dioClient.get(ApiEndpoints.aiInvestmentAnalyses, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiInvestmentAnalysis.fromJson(json)).toList();
  }

  Future<AiInvestmentAnalysis> createAiInvestmentAnalysis(AiInvestmentAnalysis item) async {
    final response = await _dioClient.post(ApiEndpoints.aiInvestmentAnalyses, data: item.toJson());
    return AiInvestmentAnalysis.fromJson(response.data['data']);
  }

  Future<AiInvestmentAnalysis> updateAiInvestmentAnalysis(String id, AiInvestmentAnalysis item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiInvestmentAnalyses}/$id', data: item.toJson());
    return AiInvestmentAnalysis.fromJson(response.data['data']);
  }

  Future<void> deleteAiInvestmentAnalysis(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiInvestmentAnalyses}/$id');
  }
}
