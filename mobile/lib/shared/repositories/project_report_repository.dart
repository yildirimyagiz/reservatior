import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ProjectReport operations
/// Provides CRUD operations with proper error handling and type safety
class ProjectReportRepository {
  final DioClient _dioClient;

  ProjectReportRepository(this._dioClient);

  /// Get ProjectReport by ID
  /// Returns [ProjectReport] if found, throws [RepositoryException] otherwise
  Future<ProjectReport> getProjectReportById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/project_report/$id');
      if (response.statusCode == 200) {
        return ProjectReport.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch project_report',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all project_reports with pagination and filtering
  /// Returns list of [ProjectReport] objects
  Future<List<ProjectReport>> getproject_reports({
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
      
      final response = await _dioClient.get('/api/v1/project_report', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ProjectReport.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch project_reports',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ProjectReport
  /// Returns created [ProjectReport] object
  Future<ProjectReport> createProjectReport(ProjectReport projectReport) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/project_report',
        data: projectReport.toJson(),
      );
      return ProjectReport.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ProjectReport
  Future<ProjectReport> updateProjectReport(String id, ProjectReport projectReport) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/project_report/$id',
        data: projectReport.toJson(),
      );
      return ProjectReport.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ProjectReport
  Future<void> deleteProjectReport(String id) async {
    try {
      await _dioClient.delete('/api/v1/project_report/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
