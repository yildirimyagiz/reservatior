import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ProjectAnalytics operations
/// Provides CRUD operations with proper error handling and type safety
class ProjectAnalyticsRepository {
  final DioClient _dioClient;

  ProjectAnalyticsRepository(this._dioClient);

  /// Get ProjectAnalytics by ID
  /// Returns [ProjectAnalytics] if found, throws [RepositoryException] otherwise
  Future<ProjectAnalytics> getProjectAnalyticsById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/project_analytics/$id');
      if (response.statusCode == 200) {
        return ProjectAnalytics.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch project_analytics',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all project_analyticses with pagination and filtering
  /// Returns list of [ProjectAnalytics] objects
  Future<List<ProjectAnalytics>> getproject_analyticses({
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
      
      final response = await _dioClient.get('/api/v1/project_analytics', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ProjectAnalytics.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch project_analyticses',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ProjectAnalytics
  /// Returns created [ProjectAnalytics] object
  Future<ProjectAnalytics> createProjectAnalytics(ProjectAnalytics projectAnalytics) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/project_analytics',
        data: projectAnalytics.toJson(),
      );
      return ProjectAnalytics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ProjectAnalytics
  Future<ProjectAnalytics> updateProjectAnalytics(String id, ProjectAnalytics projectAnalytics) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/project_analytics/$id',
        data: projectAnalytics.toJson(),
      );
      return ProjectAnalytics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ProjectAnalytics
  Future<void> deleteProjectAnalytics(String id) async {
    try {
      await _dioClient.delete('/api/v1/project_analytics/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
