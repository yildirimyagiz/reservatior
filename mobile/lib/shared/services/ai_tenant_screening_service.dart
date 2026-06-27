import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiTenantScreeningService {
  final DioClient _dioClient;
  AiTenantScreeningService(this._dioClient);

  Future<AiTenantScreening> getAiTenantScreeningById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiTenantScreenings}/$id');
    return AiTenantScreening.fromJson(response.data['data']);
  }

  Future<List<AiTenantScreening>> getAiTenantScreenings({
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
    final response = await _dioClient.get(ApiEndpoints.aiTenantScreenings, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiTenantScreening.fromJson(json)).toList();
  }

  Future<AiTenantScreening> createAiTenantScreening(AiTenantScreening item) async {
    final response = await _dioClient.post(ApiEndpoints.aiTenantScreenings, data: item.toJson());
    return AiTenantScreening.fromJson(response.data['data']);
  }

  Future<AiTenantScreening> updateAiTenantScreening(String id, AiTenantScreening item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiTenantScreenings}/$id', data: item.toJson());
    return AiTenantScreening.fromJson(response.data['data']);
  }

  Future<void> deleteAiTenantScreening(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiTenantScreenings}/$id');
  }
}
