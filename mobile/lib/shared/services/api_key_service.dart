import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ApiKeyService {
  final DioClient _dioClient;
  ApiKeyService(this._dioClient);

  Future<ApiKey> getApiKeyById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.apiKeys}/$id');
    return ApiKey.fromJson(response.data['data']);
  }

  Future<List<ApiKey>> getApiKeys({
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
    final response = await _dioClient.get(ApiEndpoints.apiKeys, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ApiKey.fromJson(json)).toList();
  }

  Future<ApiKey> createApiKey(ApiKey item) async {
    final response = await _dioClient.post(ApiEndpoints.apiKeys, data: item.toJson());
    return ApiKey.fromJson(response.data['data']);
  }

  Future<ApiKey> updateApiKey(String id, ApiKey item) async {
    final response = await _dioClient.patch('${ApiEndpoints.apiKeys}/$id', data: item.toJson());
    return ApiKey.fromJson(response.data['data']);
  }

  Future<void> deleteApiKey(String id) async {
    await _dioClient.delete('${ApiEndpoints.apiKeys}/$id');
  }
}
