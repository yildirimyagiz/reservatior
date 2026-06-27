import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiPropertyValuationService {
  final DioClient _dioClient;
  AiPropertyValuationService(this._dioClient);

  Future<AiPropertyValuation> getAiPropertyValuationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiPropertyValuations}/$id');
    return AiPropertyValuation.fromJson(response.data['data']);
  }

  Future<List<AiPropertyValuation>> getAiPropertyValuations({
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
    final response = await _dioClient.get(ApiEndpoints.aiPropertyValuations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiPropertyValuation.fromJson(json)).toList();
  }

  Future<AiPropertyValuation> createAiPropertyValuation(AiPropertyValuation item) async {
    final response = await _dioClient.post(ApiEndpoints.aiPropertyValuations, data: item.toJson());
    return AiPropertyValuation.fromJson(response.data['data']);
  }

  Future<AiPropertyValuation> updateAiPropertyValuation(String id, AiPropertyValuation item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiPropertyValuations}/$id', data: item.toJson());
    return AiPropertyValuation.fromJson(response.data['data']);
  }

  Future<void> deleteAiPropertyValuation(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiPropertyValuations}/$id');
  }
}
