import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ApiTokenService {
  final DioClient _dioClient;
  ApiTokenService(this._dioClient);

  Future<ApiToken> getApiTokenById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.apiTokens}/$id');
    return ApiToken.fromJson(response.data['data']);
  }

  Future<List<ApiToken>> getApiTokens({
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
    final response = await _dioClient.get(ApiEndpoints.apiTokens, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ApiToken.fromJson(json)).toList();
  }

  Future<ApiToken> createApiToken(ApiToken item) async {
    final response = await _dioClient.post(ApiEndpoints.apiTokens, data: item.toJson());
    return ApiToken.fromJson(response.data['data']);
  }

  Future<ApiToken> updateApiToken(String id, ApiToken item) async {
    final response = await _dioClient.patch('${ApiEndpoints.apiTokens}/$id', data: item.toJson());
    return ApiToken.fromJson(response.data['data']);
  }

  Future<void> deleteApiToken(String id) async {
    await _dioClient.delete('${ApiEndpoints.apiTokens}/$id');
  }
}
