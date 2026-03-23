import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Project operations
/// Provides CRUD operations with proper error handling and type safety
class ProjectRepository {
  final DioClient _dioClient;

  ProjectRepository(this._dioClient);

  /// Get Project by ID
  /// Returns [Project] if found, throws [RepositoryException] otherwise
  Future<Project> getProjectById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/project/$id');
      if (response.statusCode == 200) {
        return Project.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch project',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all projects with pagination and filtering
  /// Returns list of [Project] objects
  Future<List<Project>> getprojects({
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
      
      final response = await _dioClient.get('/api/v1/project', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Project.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch projects',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Project
  /// Returns created [Project] object
  Future<Project> createProject(Project project) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/project',
        data: project.toJson(),
      );
      return Project.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Project
  Future<Project> updateProject(String id, Project project) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/project/$id',
        data: project.toJson(),
      );
      return Project.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Project
  Future<void> deleteProject(String id) async {
    try {
      await _dioClient.delete('/api/v1/project/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
