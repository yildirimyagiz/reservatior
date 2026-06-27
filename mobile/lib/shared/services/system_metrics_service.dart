import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SystemMetricsService {
  final DioClient _dioClient;
  SystemMetricsService(this._dioClient);

  Future<SystemMetrics> getSystemMetricsById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.systemMetrics}/$id');
    return SystemMetrics.fromJson(response.data['data']);
  }

  Future<List<SystemMetrics>> getSystemMetricses({
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
    final response = await _dioClient.get(ApiEndpoints.systemMetrics, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => SystemMetrics.fromJson(json)).toList();
  }

  Future<SystemMetrics> createSystemMetrics(SystemMetrics item) async {
    final response = await _dioClient.post(ApiEndpoints.systemMetrics, data: item.toJson());
    return SystemMetrics.fromJson(response.data['data']);
  }

  Future<SystemMetrics> updateSystemMetrics(String id, SystemMetrics item) async {
    final response = await _dioClient.patch('${ApiEndpoints.systemMetrics}/$id', data: item.toJson());
    return SystemMetrics.fromJson(response.data['data']);
  }

  Future<void> deleteSystemMetrics(String id) async {
    await _dioClient.delete('${ApiEndpoints.systemMetrics}/$id');
  }
}
