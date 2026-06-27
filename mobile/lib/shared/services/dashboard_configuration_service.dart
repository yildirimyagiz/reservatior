import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class DashboardConfigurationService {
  final DioClient _dioClient;
  DashboardConfigurationService(this._dioClient);

  Future<DashboardConfiguration> getDashboardConfigurationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.dashboardConfigurations}/$id');
    return DashboardConfiguration.fromJson(response.data['data']);
  }

  Future<List<DashboardConfiguration>> getDashboardConfigurations({
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
    final response = await _dioClient.get(ApiEndpoints.dashboardConfigurations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => DashboardConfiguration.fromJson(json)).toList();
  }

  Future<DashboardConfiguration> createDashboardConfiguration(DashboardConfiguration item) async {
    final response = await _dioClient.post(ApiEndpoints.dashboardConfigurations, data: item.toJson());
    return DashboardConfiguration.fromJson(response.data['data']);
  }

  Future<DashboardConfiguration> updateDashboardConfiguration(String id, DashboardConfiguration item) async {
    final response = await _dioClient.patch('${ApiEndpoints.dashboardConfigurations}/$id', data: item.toJson());
    return DashboardConfiguration.fromJson(response.data['data']);
  }

  Future<void> deleteDashboardConfiguration(String id) async {
    await _dioClient.delete('${ApiEndpoints.dashboardConfigurations}/$id');
  }
}
