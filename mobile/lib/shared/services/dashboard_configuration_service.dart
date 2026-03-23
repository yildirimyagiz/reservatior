import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class DashboardConfigurationService {
  final DioClient _dioClient;

  DashboardConfigurationService(this._dioClient);

  // Get DashboardConfiguration by ID
  Future<DashboardConfiguration> getDashboardConfigurationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/dashboard_configuration/$id');
      return DashboardConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all dashboard_configurations
  Future<List<DashboardConfiguration>> getDashboardConfigurations({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/dashboard_configuration', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => DashboardConfiguration.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create DashboardConfiguration
  Future<DashboardConfiguration> createDashboardConfiguration(DashboardConfiguration dashboardConfiguration) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/dashboard_configuration',
        data: dashboardConfiguration.toJson(),
      );
      return DashboardConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update DashboardConfiguration
  Future<DashboardConfiguration> updateDashboardConfiguration(String id, DashboardConfiguration dashboardConfiguration) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/dashboard_configuration/$id',
        data: dashboardConfiguration.toJson(),
      );
      return DashboardConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete DashboardConfiguration
  Future<void> deleteDashboardConfiguration(String id) async {
    try {
      await _dioClient.delete('/api/v1/dashboard_configuration/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
