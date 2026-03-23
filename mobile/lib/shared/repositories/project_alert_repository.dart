import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ProjectAlert operations
/// Provides CRUD operations with proper error handling and type safety
class ProjectAlertRepository {
  final DioClient _dioClient;

  ProjectAlertRepository(this._dioClient);

  /// Get ProjectAlert by ID
  /// Returns [ProjectAlert] if found, throws [RepositoryException] otherwise
  Future<ProjectAlert> getProjectAlertById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/project_alert/$id');
      if (response.statusCode == 200) {
        return ProjectAlert.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch project_alert',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all project_alerts with pagination and filtering
  /// Returns list of [ProjectAlert] objects
  Future<List<ProjectAlert>> getproject_alerts({
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
      
      final response = await _dioClient.get('/api/v1/project_alert', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ProjectAlert.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch project_alerts',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ProjectAlert
  /// Returns created [ProjectAlert] object
  Future<ProjectAlert> createProjectAlert(ProjectAlert projectAlert) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/project_alert',
        data: projectAlert.toJson(),
      );
      return ProjectAlert.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ProjectAlert
  Future<ProjectAlert> updateProjectAlert(String id, ProjectAlert projectAlert) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/project_alert/$id',
        data: projectAlert.toJson(),
      );
      return ProjectAlert.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ProjectAlert
  Future<void> deleteProjectAlert(String id) async {
    try {
      await _dioClient.delete('/api/v1/project_alert/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
