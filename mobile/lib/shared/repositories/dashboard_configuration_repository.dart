import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for DashboardConfiguration operations
/// Provides CRUD operations with proper error handling and type safety
class DashboardConfigurationRepository {
  final DioClient _dioClient;

  DashboardConfigurationRepository(this._dioClient);

  /// Get DashboardConfiguration by ID
  /// Returns [DashboardConfiguration] if found, throws [RepositoryException] otherwise
  Future<DashboardConfiguration> getDashboardConfigurationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/dashboard_configuration/$id');
      if (response.statusCode == 200) {
        return DashboardConfiguration.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch dashboard_configuration',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all dashboard_configurations with pagination and filtering
  /// Returns list of [DashboardConfiguration] objects
  Future<List<DashboardConfiguration>> getdashboard_configurations({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/dashboard_configuration', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => DashboardConfiguration.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch dashboard_configurations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new DashboardConfiguration
  /// Returns created [DashboardConfiguration] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
