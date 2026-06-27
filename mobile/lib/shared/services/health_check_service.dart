import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class HealthCheckService {
  final DioClient _dioClient;
  HealthCheckService(this._dioClient);

  Future<HealthCheck> getHealthCheckById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.healthChecks}/$id');
    return HealthCheck.fromJson(response.data['data']);
  }

  Future<List<HealthCheck>> getHealthChecks({
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
    final response = await _dioClient.get(ApiEndpoints.healthChecks, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => HealthCheck.fromJson(json)).toList();
  }

  Future<HealthCheck> createHealthCheck(HealthCheck item) async {
    final response = await _dioClient.post(ApiEndpoints.healthChecks, data: item.toJson());
    return HealthCheck.fromJson(response.data['data']);
  }

  Future<HealthCheck> updateHealthCheck(String id, HealthCheck item) async {
    final response = await _dioClient.patch('${ApiEndpoints.healthChecks}/$id', data: item.toJson());
    return HealthCheck.fromJson(response.data['data']);
  }

  Future<void> deleteHealthCheck(String id) async {
    await _dioClient.delete('${ApiEndpoints.healthChecks}/$id');
  }
}
