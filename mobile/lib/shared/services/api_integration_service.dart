import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class APIIntegrationService {
  final DioClient _dioClient;
  APIIntegrationService(this._dioClient);

  Future<APIIntegration> getAPIIntegrationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.apiIntegrations}/$id');
    return APIIntegration.fromJson(response.data['data']);
  }

  Future<List<APIIntegration>> getAPIIntegrations({
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
    final response = await _dioClient.get(ApiEndpoints.apiIntegrations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => APIIntegration.fromJson(json)).toList();
  }

  Future<APIIntegration> createAPIIntegration(APIIntegration item) async {
    final response = await _dioClient.post(ApiEndpoints.apiIntegrations, data: item.toJson());
    return APIIntegration.fromJson(response.data['data']);
  }

  Future<APIIntegration> updateAPIIntegration(String id, APIIntegration item) async {
    final response = await _dioClient.patch('${ApiEndpoints.apiIntegrations}/$id', data: item.toJson());
    return APIIntegration.fromJson(response.data['data']);
  }

  Future<void> deleteAPIIntegration(String id) async {
    await _dioClient.delete('${ApiEndpoints.apiIntegrations}/$id');
  }
}
