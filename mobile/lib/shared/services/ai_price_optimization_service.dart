import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiPriceOptimizationService {
  final DioClient _dioClient;
  AiPriceOptimizationService(this._dioClient);

  Future<AiPriceOptimization> getAiPriceOptimizationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiPriceOptimizations}/$id');
    return AiPriceOptimization.fromJson(response.data['data']);
  }

  Future<List<AiPriceOptimization>> getAiPriceOptimizations({
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
    final response = await _dioClient.get(ApiEndpoints.aiPriceOptimizations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiPriceOptimization.fromJson(json)).toList();
  }

  Future<AiPriceOptimization> createAiPriceOptimization(AiPriceOptimization item) async {
    final response = await _dioClient.post(ApiEndpoints.aiPriceOptimizations, data: item.toJson());
    return AiPriceOptimization.fromJson(response.data['data']);
  }

  Future<AiPriceOptimization> updateAiPriceOptimization(String id, AiPriceOptimization item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiPriceOptimizations}/$id', data: item.toJson());
    return AiPriceOptimization.fromJson(response.data['data']);
  }

  Future<void> deleteAiPriceOptimization(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiPriceOptimizations}/$id');
  }
}
