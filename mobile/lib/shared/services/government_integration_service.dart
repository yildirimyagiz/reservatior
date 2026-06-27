import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class GovernmentIntegrationService {
  final DioClient _dioClient;
  GovernmentIntegrationService(this._dioClient);

  Future<GovernmentIntegration> getGovernmentIntegrationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.governmentIntegrations}/$id');
    return GovernmentIntegration.fromJson(response.data['data']);
  }

  Future<List<GovernmentIntegration>> getGovernmentIntegrations({
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
    final response = await _dioClient.get(ApiEndpoints.governmentIntegrations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => GovernmentIntegration.fromJson(json)).toList();
  }

  Future<GovernmentIntegration> createGovernmentIntegration(GovernmentIntegration item) async {
    final response = await _dioClient.post(ApiEndpoints.governmentIntegrations, data: item.toJson());
    return GovernmentIntegration.fromJson(response.data['data']);
  }

  Future<GovernmentIntegration> updateGovernmentIntegration(String id, GovernmentIntegration item) async {
    final response = await _dioClient.patch('${ApiEndpoints.governmentIntegrations}/$id', data: item.toJson());
    return GovernmentIntegration.fromJson(response.data['data']);
  }

  Future<void> deleteGovernmentIntegration(String id) async {
    await _dioClient.delete('${ApiEndpoints.governmentIntegrations}/$id');
  }
}
