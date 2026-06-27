import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiPredictionService {
  final DioClient _dioClient;
  AiPredictionService(this._dioClient);

  Future<AiPrediction> getAiPredictionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiPredictions}/$id');
    return AiPrediction.fromJson(response.data['data']);
  }

  Future<List<AiPrediction>> getAiPredictions({
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
    final response = await _dioClient.get(ApiEndpoints.aiPredictions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiPrediction.fromJson(json)).toList();
  }

  Future<AiPrediction> createAiPrediction(AiPrediction item) async {
    final response = await _dioClient.post(ApiEndpoints.aiPredictions, data: item.toJson());
    return AiPrediction.fromJson(response.data['data']);
  }

  Future<AiPrediction> updateAiPrediction(String id, AiPrediction item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiPredictions}/$id', data: item.toJson());
    return AiPrediction.fromJson(response.data['data']);
  }

  Future<void> deleteAiPrediction(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiPredictions}/$id');
  }
}
